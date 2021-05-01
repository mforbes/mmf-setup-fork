import configparser
import logging
from pathlib import Path
import shlex
import sys
import subprocess

import tomlkit

import mmf_setup

_CONFIG_FILES = ["pyproject.toml", "setup.cfg", "setup.py"]

_ERRORS = []


def log(msg, level=logging.INFO):
    logging.getLogger(__name__).log(level=level, msg=msg)


def get_hgroot():
    """Return `HGROOT = "$(hg root)"` if found."""
    return Path(subprocess.check_output(["hg", "root"]).strip().decode("utf-8"))


def get_gitroot():
    """Return `GITROOT = "$(git rev-parse --show-toplevel)"` if found."""
    return Path(
        subprocess.check_output(["git", "rev-parse", "--show-toplevel"])
        .strip()
        .decode("utf-8")
    )


def get_configroot():
    """Return `CFGROOT` as the first parent directory with a config file."""
    CFGROOT = None

    for p in Path(".").resolve().parents:
        if any((p / f).exists() for f in _CONFIG_FILES):
            CFGROOT = p
            break
        return CFGROOT


def set_roots():
    """Set the ROOTS and store any errors in _ERRORS."""

    global _ERRORS
    _ERRORS.clear()

    mmf_setup.HGROOT = mmf_setup.GITROOT = mmf_setup.CFGROOT = None
    try:
        mmf_setup.HGROOT = get_hgroot()
    except Exception as err:
        _ERRORS.append(f"Could not set HGROOT: {err.output}")

    try:
        mmf_setup.GITROOT = get_gitroot()
    except Exception as err:
        _ERRORS.append(f"Could not set GITROOT: {err.output}")

    mmf_setup.CFGROOT = get_configroot()
    if not mmf_setup.CFGROOT:
        _ERRORS.append(
            f"Could find any config files above {Path('.').resolve()} to set CFGROOT"
        )

    if not any([mmf_setup.HGROOT, mmf_setup.GITROOT, mmf_setup.CFGROOT]):
        log(
            "Could not set HGROOT, GITROOT, or CFGROOT: {_ERRORS}",
            level=logging.WARNING,
        )


def set_path(filename=None, ROOT=None, check=True):
    """Set the path from one of the following sources.

    1. The appropriate [mmf_setup] section in an existing config file:

       * `filename` if `filename` is an absolute path.
       * `ROOT/filename` if filename is a relative path.

    2. `ROOT`

    If not specified `ROOT` is set to the first of the following to be defined:

       * `mmf_setup.ROOT`
       * `mmf_setup.CFGROOT`
       * `mmf_setup.HGROOT`
       * `mmf_setup.GITROOT`
       * `.`

    If not specified, `filename` is an existing `"pyproject.toml"` or `"setup.cfg"`, checked
    in that order.

    Details
    -------
    from the `paths` variable in the [mmf_setup] section of the
    specified config file.  Each path entry should be on a separate line.
    I.e.::

        [mmf_setup]
        paths = .          # ROOT not included by default!  Add it here.
                src        # Paths relative to ROOT
                /abs/path  # Absolute paths are okay too

    Note: if you specify the paths this way, you need to explicitly include the
    root directory `.` as shown above if you want that.  All paths are relative to
    ROOT (defaults to `mmf_setup.ROOT`) unless specified as an absolute path.

    Arguments
    ---------
    filename : str
       Name of config file (default is 'setup.cfg').  If relative, then we look
       in `ROOT`.
    ROOT : str, None
       Root directory used for all relative paths.  If `None`, then we use
       `mmf_setup.ROOT`.
    check : bool
       If `True`, then only add paths if they actually exist.
    """
    if ROOT is None:
        ROOT = getattr(mmf_setup, "ROOT", None)
    if ROOT is None:
        ROOT = getattr(mmf_setup, "CFGROOT", None)
    if ROOT is None:
        ROOT = getattr(mmf_setup, "HGROOT", None)
    if ROOT is None:
        ROOT = getattr(mmf_setup, "GITROOT", None)
    if ROOT is None:
        ROOT = "."

    ROOT = Path(ROOT)

    if filename is None:
        filenames = [ROOT / _f for _f in _CONFIG_FILES]
    else:
        filename = Path(filename)
        if filename.is_absolute():
            filenames = [filename]
        else:
            filenames = [ROOT / "pyproject.toml", ROOT / "setup.cfg"]

    for filename in filenames:
        if filename.exists():
            break

    paths = []
    if filename.exists():
        if filename.suffix == ".toml":
            paths = get_paths_from_toml(filename, ROOT=ROOT)
        elif filename.suffix == ".cfg":
            paths = get_paths_from_cfg(filename, ROOT=ROOT)
        else:
            raise ValueError(
                f"Unrecognized config file {filename} (not '.toml' or '.cfg')"
            )
    else:
        log(
            f"Could not find any config files {filenames}. Using ROOT={ROOT}",
            level=logging.WARNING,
        )
        paths = [ROOT]

    # Cleanup paths and make them absolute.
    _paths = []
    for path in paths:
        path = Path(path)

        if not path.is_absolute():
            path = ROOT / path

        _paths.append(path.resolve())
    paths = _paths

    for path in reversed(paths):
        if not check or path.exists():
            current_paths = [Path(_p).resolve() for _p in sys.path]
            if path not in current_paths:
                sys.path.insert(0, str(path))
    return paths


def get_paths_from_toml(filename, ROOT):
    with open(filename) as f:
        doc = tomlkit.parse(f.read())
        try:
            paths = doc["tool"]["mmf_setup"]["paths"]
        except tomlkit.exceptions.NonExistentKey:
            paths = [ROOT]
    return paths


def get_paths_from_cfg(filename, ROOT):
    config = configparser.ConfigParser()
    config.read(filename)
    if config.has_section("mmf_setup"):
        if config.has_option("mmf_setup", "paths"):
            paths = []
            for line in config.get("mmf_setup", "paths").split("\n"):
                # Strips out comments etc.  See
                # https://stackoverflow.com/a/27178714/1088938
                lex = shlex.shlex(line)
                lex.whitespace = ""  # if you want to strip newlines, use '\n'
                line = "".join(list(lex))
                if line:
                    paths.append(Path(line.strip()))
    else:
        paths = [ROOT]
    return paths


set_roots()
set_path()
