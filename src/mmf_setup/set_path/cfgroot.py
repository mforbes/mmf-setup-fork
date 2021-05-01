"""Importing this module will set `mmf_setup.CFGROOT` to the first parent directory with
a `pyproject.toml`, `setup.cfg`, or `setup.py` file.
"""
from . import get_cfgroot
import mmf_setup

mmf_setup.CGFROOT = get_cfgroot()
