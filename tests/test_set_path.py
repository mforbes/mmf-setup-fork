import copy
import importlib
import os
from pathlib import Path
import shutil
import subprocess
import sys
import tempfile
import warnings

import pytest

_pyproject_toml = """
[tool.mmf_setup]
ROOT = "{root}"
"""

_setup_cfg = """
[mmf_setup]
ROOT = {root}
"""


@pytest.fixture()
def tmpdir():
    """Provides a temporary directory for testing."""
    tmpdir = tempfile.mkdtemp()
    yield Path(tmpdir)
    shutil.rmtree(tmpdir)


@pytest.fixture()
def mmf_setup():
    """Return the mmf_setup module, but ensure that ROOT is deleted."""
    mmf_setup = importlib.import_module("mmf_setup")
    if hasattr(mmf_setup, "ROOT"):
        del mmf_setup.ROOT
    yield mmf_setup


@pytest.fixture(params=[("pyproject.toml", _pyproject_toml), ("setup.cfg", _setup_cfg)])
def config_file_info(request):
    yield request.param


def test_set_path_hgroot(recwarn, mmf_setup):
    """Test deprecated import `mmf_setup.set_path.hgroot`"""
    assert not hasattr(mmf_setup, "ROOT")
    hgroot = importlib.import_module("mmf_setup.set_path.hgroot")
    warnings.simplefilter("always")
    importlib.reload(hgroot)
    assert len(recwarn) == 1
    assert recwarn.pop(DeprecationWarning)

    assert Path(sys.path[0]).resolve() == Path(mmf_setup.ROOT).resolve()


def test_set_ROOT(tmpdir, mmf_setup):
    mmf_setup.ROOT = tmpdir
    mmf_setup.set_path(cwd=tmpdir)
    assert mmf_setup.ROOT == tmpdir
    assert sys.path[0] == str(tmpdir)

    mmf_setup.ROOT = tmpdir / "DOES_NOT_EXIST"
    mmf_setup.set_path(cwd=tmpdir / "DOES_NOT_EXIST")
    assert not hasattr(mmf_setup, "ROOT")

    # Not sure if this is what we want... but it is probably too much to expect cleanup
    assert sys.path[0] == str(tmpdir)


def test_set_path_config(tmpdir, config_file_info, mmf_setup):
    root = tmpdir / "A"
    cwd = root / "B"
    os.makedirs(cwd)

    config_filename, config_template = config_file_info
    config_file = tmpdir / config_filename
    config_contents = config_template.format(root=root)

    # Wrong filename
    with open(tmpdir / ("f" + config_filename), "w") as f:
        f.write(config_contents)

    mmf_setup.set_path(cwd=cwd)
    assert not hasattr(mmf_setup, "ROOT")

    # Wrong section.  This will set ROOT to tmpdir where the config file is, not to root.
    with open(config_file, "w") as f:
        f.write(config_contents.replace("mmf_setup", "mmf_settup"))

    mmf_setup.set_path(cwd=cwd)
    assert Path(mmf_setup.ROOT).resolve() == tmpdir.resolve()
    assert Path(mmf_setup.ROOT).resolve() != root.resolve()
    del mmf_setup.ROOT

    # Wrong spelling.  This will set ROOT to tmpdir where the config file is, not to root.
    with open(config_file, "w") as f:
        f.write(config_contents.replace("ROOT", "ROOTT"))

    mmf_setup.set_path(cwd=cwd)
    assert Path(mmf_setup.ROOT).resolve() == tmpdir.resolve()
    assert Path(mmf_setup.ROOT).resolve() != root.resolve()
    del mmf_setup.ROOT

    # Now do it for real.
    with open(config_file, "w") as f:
        f.write(config_contents)

    mmf_setup.set_path(cwd=cwd)
    assert Path(mmf_setup.ROOT).resolve() == root.resolve()
    assert Path(sys.path[0]).resolve() == root.resolve()


def test_set_path_toml_precedence(tmpdir, mmf_setup):
    """Check that pyproject.toml has precedence over setup.cfg"""
    root_toml = tmpdir / "A" / "R"
    root_cfg = tmpdir / "A"
    cwd = tmpdir / "A" / "B"
    os.makedirs(root_toml)
    os.makedirs(cwd)

    toml_info = tmpdir / "pyproject.toml", _pyproject_toml.format(root=root_toml)
    cfg_info = tmpdir / "setup.cfg", _setup_cfg.format(root=root_cfg)

    for _file, _contents in [toml_info, cfg_info]:
        with open(_file, "w") as f:
            f.write(_contents)

    mmf_setup.set_path(cwd=cwd)
    assert Path(mmf_setup.ROOT).resolve() == root_toml.resolve()
    assert Path(sys.path[0]).resolve() == root_toml.resolve()
