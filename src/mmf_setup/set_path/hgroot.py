"""Importing this module will set `mmf_setup.HGROOT`."""
import mmf_setup
from . import get_hgroot

mmf_setup.HGROOT = get_hgroot()
