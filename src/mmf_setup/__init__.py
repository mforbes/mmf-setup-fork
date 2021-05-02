import os.path
from .notebook_configuration import nbinit

__all__ = ["nbinit", "MMF_SETUP", "DATA", "HGTHEMES", "NBTHEMES", "HGRC", "HGROOT"]

MMF_SETUP = os.path.abspath(os.path.dirname(__file__))
DATA = os.path.join(MMF_SETUP, "_data")
HGRC_LGA = os.path.join(DATA, "hgrc.lga")
HGRC_FULL = os.path.join(DATA, "hgrc.full")
HGTHEMES = os.path.join(DATA, "hgthemes")
NBTHEMES = os.path.join(DATA, "nbthemes")
ROOT = "."
HGROOT = None
