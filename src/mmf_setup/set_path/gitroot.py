"""Importing this module will set `mmf_setup.GITROOT`."""
import mmf_setup
from . import get_gitroot

mmf_setup.GITROOT = get_gitroot()
