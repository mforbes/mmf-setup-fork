% Developer Notes

Developer Notes
===============

[![Documentation Status][rtd_badge]][rtd]
[![Tests][ci_badge]][ci]
[![Language grade: Python][lgtm_mmfutils_badge]][lgtm_mmfutils]
[![Language grade: Python][lgtm_mmfutils_fork_badge]][lgtm_mmfutils_fork]
[![Code style: black][black_img]][black]

Summary:

* https://alum.mit.edu/www/mforbes/hg/forbes-group/mmf-setup: Main development
  repository (Mercurial) running on our hosted [Heptapod] server.  This is where
  [Issues](https://alum.mit.edu/www/mforbes/hg/forbes-group/mmf-setup/issues), [Merge
  Requests](https://alum.mit.edu/www/mforbes/hg/forbes-group/mmf-setup/merge_requests)
  etc. should be reported.
* https://github.com/forbes-group/mmf-setup: Main public mirror (Git) for releases.
  Protected branches are automatically pushed here.  No development work should be done
  here: this is just for public access, and to use GitHub's CI tools.
* https://github.com/mforbes/mmf-setup-fork: My development fork (Git).  Everything
  is pushed here to use GitHub's CI tools during development.  Should not be used for
  anything else.
  
## Badges

With CI setup, we have the following badges:

* Documentation at [Read the Docs](https://readthedocs.org):

    [![Documentation Status][rtd_badge]][rtd]

* Testing at [DroneIO](https://cloud.drone.io) and with GitHub actions:
    
    [![DroneIO Build Status][drone_badge]][drone]
    [![Tests][ci_badge]][ci]

* Code quality testing at [lgtm](https://lgtm.com):

    [![Language grade: Python][lgtm_mmf-setup_badge]][lgtm_mmf-setup]
    [![Language grade: Python][lgtm_mmf-setup_fork_badge]][lgtm_mmf-setup_fork]

* Style:

    [![Code style: black][black_img]][black]


[rtd_badge]: <https://readthedocs.org/projects/mmf-setup/badge/?version=latest>
[rtd]: <https://mmf-setup.readthedocs.io/en/latest/?badge=latest>


[drone_badge]: <https://cloud.drone.io/api/badges/forbes-group/mmf-setup/status.svg>
[drone]: https://cloud.drone.io/forbes-group/mmf-setup
[ci_badge]: <https://github.com/mforbes/mmf-setup-fork/actions/workflows/tests.yml/badge.svg>
[ci]: <https://github.com/mforbes/mmf-setup-fork/actions/workflows/tests.yml>

[black]: https://github.com/psf/black
[black_img]: https://img.shields.io/badge/code%20style-black-000000.svg


[lgtm_mmf-setup]: <https://lgtm.com/projects/g/forbes-group/mmf-setup/context:python>
[lgtm_mmf-setup_badge]: <https://img.shields.io/lgtm/grade/python/g/forbes-group/mmf-setup.svg?logo=lgtm&logoWidth=18>

[lgtm_mmf-setup_fork]: <https://lgtm.com/projects/g/forbes-group/mmf-setup/context:python>
[lgtm_mmf-setup_fork_badge]: <https://img.shields.io/lgtm/grade/python/g/mforbes/mmf-setup-fork.svg?logo=lgtm&logoWidth=18> 

<!-- Links -->
[Nox]: <https://nox.thea.codes> "Nox: Flexible test automation"
[Hypermodern Python]: <https://cjolowicz.github.io/posts/hypermodern-python-01-setup/> "Hypermodern Python"
[`pyenv`]: <https://github.com/pyenv/pyenv> "Simple Python Version Management: pyenv"
[`minconda`]: <https://docs.conda.io/en/latest/miniconda.html> "Miniconda"
[Conda]: <https://docs.conda.io> "Conda"
[Heptapod]: <https://heptapod.net> "Heptapod website"
[pytest]: <https://docs.pytest.org> "pytest"
