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


def test_no_paths(tmpdir, mmf_setup):
    os.chdir(tmpdir)
    mmf_setup.notebook_configuration.nbinit()
