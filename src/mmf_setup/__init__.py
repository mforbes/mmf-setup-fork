import os.path
import warnings

try:
    from importlib import metadata
except ImportError:
    import importlib_metadata as metadata

from .notebook_configuration import nbinit
from .set_path import set_path

try:
    ip = get_ipython()
    from .ipython_setup import (
        load_ipython_extension,
        unload_ipython_extension,
        register_magics,
    )

    register_magics(ip=ip)

except NameError:
    ip = None


def nbinit():
    warnings.warn(
        "Calling mmf_setup.nbinit() is deprecated.  Use %nbinit instead.",
        DeprecationWarning,
    )


__version__ = metadata.version(__name__)

__all__ = [
    "nbinit",
    "set_path",
    "MMF_SETUP",
    "DATA",
    "HGTHEMES",
    "NBTHEMES",
    "HGRC_LGA",
    "HGRC_FULL",
    "load_ipython_extension",
    "unload_ipython_extension",
]

MMF_SETUP = os.path.abspath(os.path.dirname(__file__))
DATA = os.path.join(MMF_SETUP, "_data")
HGRC_LGA = os.path.join(DATA, "hgrc.lga")
HGRC_FULL = os.path.join(DATA, "hgrc.full")
HGTHEMES = os.path.join(DATA, "hgthemes")
NBTHEMES = os.path.join(DATA, "nbthemes")
