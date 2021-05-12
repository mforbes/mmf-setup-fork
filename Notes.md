% Developer Notes

Developer Notes
===============

[![Documentation Status][rtd_badge]][rtd]
[![Tests of Release][ci_badge]][ci]
[![Tests of Fork][ci_fork_badge]][ci_fork]
[![Language grade: Python][lgtm_mmf-setup_badge]][lgtm_mmf-setup]
[![Language grade: Python][lgtm_mmf-setup-fork_badge]][lgtm_mmf-setup-fork]
[![Code style: black][black_img]][black]

Summary:

* <https://alum.mit.edu/www/mforbes/hg/forbes-group/mmf-setup>: Main development
  repository (Mercurial) running on our hosted [Heptapod] server.  This is where
  [Issues](https://alum.mit.edu/www/mforbes/hg/forbes-group/mmf-setup/issues), [Merge
  Requests](https://alum.mit.edu/www/mforbes/hg/forbes-group/mmf-setup/merge_requests)
  etc. should be reported.
* <https://github.com/forbes-group/mmf-setup>: Main public mirror (Git) for releases.
  Protected branches are automatically pushed here.  No development work should be done
  here: this is just for public access, and to use GitHub's CI tools.
* <https://github.com/mforbes/mmf-setup-fork>: My development fork (Git).  Everything
  is pushed here to use GitHub's CI tools during development.  Should not be used for
  anything else.
  
## Badges

With CI setup, we have the following badges:

* Documentation at [Read the Docs](https://readthedocs.org):

    [![Documentation Status][rtd_badge]][rtd]

* Testing at with GitHub actions (release and fork):

    [![Tests of Release][ci_badge]][ci]
    [![Tests of Fork][ci_fork_badge]][ci_fork]

* Code quality testing at [lgtm](https://lgtm.com):

    [![Total
alerts](https://img.shields.io/lgtm/alerts/g/mforbes/mmf-setup-fork.svg?logo=lgtm&logoWidth=18)](https://lgtm.com/projects/g/mforbes/mmf-setup-fork/alerts/)

    [![Language grade: Python][lgtm_mmf-setup_badge]][lgtm_mmf-setup]
    [![Language grade: Python][lgtm_mmf-setup-fork_badge]][lgtm_mmf-setup-fork]

* Style:

    [![Code style: black][black_img]][black]



Releases
--------

To prepare for release, make sure you are running in a development environment with the
Mercurial evolve and topics extensions enabled, and with [Black] and [Nox].

### Release Procedure

*(Here is a sample release procedure going from `0.4.0` to `0.4.1`.  Modify the version
numbers as appropriate)*

1. **Preparation:** Make sure you do your work on the development branch with the name
   `0.4` (major.minor) with version number `'0.4.x.dev0'` in `setup.py` or
   `pyproject.toml`.  All work should be with with topics, then merged into the branch.

   Typically this is setup is ensured at the end of the release procedure, but if
   needed you can do the following:

   ```bash
   hg up 0.4         # Run hg branch 0.4 if needed, but this should exist.
   hg topic 0.4.1
   # Check that setup.py has version='0.4.1.dev0'
   ```

2. **Development:** Complete your changes making sure code is well tested etc. While
   working on specific features, you should always use topics.  When you push to
   Heptapod, the commits in these topics will remain in the draft phase, allowing you
   to rebase, etc. as needed to clean the history. We have setup automatic pushes to
   GitHub and you can see the status of the tests with the badges: [![Tests of
   Release][ci_badge]][ci][![Tests of Fork][ci_fork_badge]][ci_fork].  The first tests
   the releases while the second tests development work.  The second one should update
   when you push topics.

   To run the complete set of tests locally, you should be able to just run:

   ```bash
   nox
   ```

   (INCOMPLETE) Demonstrate how to run tests while developing with.

   (INCOMPLETE) Also check the documentation.  *The `docs` directory contains some old
   documentation and we have code in `.makefiles` to convert this to HTML.  This needs
   updating and cleanup.  The official package documentation is in the `README.md` file
   which we discuss below.*

3. **Release:** Once everything is working and tested, push it to Heptapod and create
   Merge Requests as needed.  First merge all open topics to the development branch,
   then:

   1. Change the revision in `setup.py` or `pyproject.toml` to `version='0.4.2'`,
      dropping the `'.dev0'`.  Push this to Heptapod and create a merge request to
      merge this to the default branch.   Review the changes and fix as needed.
   2. Add notes about the changes in `CHANGES.md`.  *(These should be apparent from the review.)*
   3. Check that the documentation looks okay:

      ```bash
      make README_CHANGES.html
      open README_CHANGES.html
      make clean
      ```
   4. Try uploading your package to `pypi` with `twine`:

      ```bash
      python setup.py sdist bdist_wheel
      twine check dist/mmf_setup-*
      twine upload dist/mmf_setup-*
      ```

      *(Eventually this will be done with [Poetry]).*
   5. If this works, then complete the Merge Request into the default branch with a commit
      message starting: `"REL: 0.4.1"`.  *Unlike previously, do not close the
      branch. Just leave it open so it can be found.*
   6. Pull in these changes, update, and tag the commit.  Then return to the
      development branch for future work.

      ```bash
      $ hg pull
      $ hg up default
      $ hg lg
        o  214:p m (22 hours ago)  0.4.1
       /|   REL: 0.4.1
      o |  213:p michael (23 hours ago) 0.4
      | |   TST: Working tests.  Ready for release.
      o |  212:p michael (4 days ago) 0.4
      | |   Add comment to mmf_setup -v output so it can be evaled.
      ...
      $ hg tag 0.4.1
      $ hg up 0.4
      $ hg lg -v
        0  217:1c56fef2ea9c:d michael (9 hours ago)
        |   Added tag 0.4.1 for changeset 69c00f4e2154
        o  214:69c00f4e2154:p m (22 hours ago)  0.4.1
       /|   REL: 0.4.1
      @ |  213:453e5d5838d2:p michael (23 hours ago) 0.4
      | |   TST: Working tests.  Ready for release.
      o |  212:9036a9114731:p michael (4 days ago) 0.4
      | |   Add comment to mmf_setup -v output so it can be evaled.
      ...
      ```
4. **Preparation:***  Start work on next release by tagging and/or creating a new branch
   if needed.
   
   ```bash
   # Edit setup.py or pyproject.toml to set `version='0.4.2.dev0'`
   $ hg topic 0.4.2
   $ hg com -m "VER: 0.4.2 start"
   $ hg lg
   @  219:d michael (9 hours ago) 0.4[0.4.2] tip
   |   VER: 0.4.2 start
   | o  217:d michael (9 hours ago)
   | |   Added tag 0.4.1 for changeset 69c00f4e2154
   | o  214:p m (22 hours ago)  0.4.1
   |/|   REL: 0.4.1
   o |  213:p michael (23 hours ago) 0.4
   | |   TST: Working tests.  Ready for release.
   o |  212:p michael (4 days ago) 0.4
   | |   Add comment to mmf_setup -v output so it can be evaled.
   ...
   ```
   
   or, if starting branch 0.5:

   ```bash
   # Edit setup.py or pyproject.toml to set `version='0.5.0.dev0'`
   $ hg branch 0.5
   $ hg com -m "BRN: 0.5"
   $ hg topic 0.5.0
   $ hg com -m "VER: 0.5.0 start"
   $ hg lg
   @  219:d michael (9 hours ago) 0.5[0.5.0] tip
   |   VER: 0.5.0 start
   | o  217:d michael (9 hours ago)
   | |   Added tag 0.4.1 for changeset 69c00f4e2154
   | o  214:p m (22 hours ago)  0.4.1
   |/|   REL: 0.4.1
   o |  213:p michael (23 hours ago) 0.4
   | |   TST: Working tests.  Ready for release.
   o |  212:p michael (4 days ago) 0.4
   | |   Add comment to mmf_setup -v output so it can be evaled.
   ...
   ```

Testing
=======
(INCOMPLETE)

To release a new version be sure to do the following. (The examples use
revision numbers etc. for release 0.1.11.)

1.  Make sure your code works and that the tests pass. Pull any open
    issues into the main release branch, closing those issue branches.

    To run the tests, make sure you have [nox](https://nox.thea.codes)
    and [Conda](http://docs.continuum.io/conda) installed in some
    environment, then run:

        nox

    This will create a bunch of environments in `.nox` and run the
    test-suite on those.

    -   To activate one for testing, activate the environment:

            conda activate .nox/test_conda-3-6
            make test

    -   These can get quite large, so you might want to remove them when
        you are done with one of the following:

            rm -rf .nox
            make clean        # Does this and more

    To manually run the test suite:

        conda env remove -n tst3        # If needed
        conda create -yn tst3 python=3
        conda activate tst3
        pip install -e .[test]
        make test

    If you want to test things from conda, you can get a debug
    environment by running:

        conda debug .

    After you activate the development library, install pytest:

        cd /data/apps/conda/conda-bld/debug_.../work && source build_env_setup.sh
        pip install -e .[test]

**Anaconda**

(INCOMPLETE) I am not sure if we want to keep supporting releases with Anaconda.  Might
be simpler just to use pip and eventually integrate with conda-forge.

(INCOMPLETE) I am not sure if we want to keep supporting releases with Anaconda.  Might
be simpler just to use pip and eventually integrate with conda-forge.

The information about building the package for conda is specified in the
`meta.yaml` file.

1.  (Optional) Prepare a clean environment:

        conda env remove -n tst3        # If needed
        conda create -yn tst3 python=3 anaconda-client conda-build
        conda activate tst3

    *(I keep the conda build tools in my base environment so I do not
    need this.)*

2.  Build locally and test. Note: we need to specify the channel since
    `python-hglib` is there. Since we will host this on our channel,
    this will be explicitly specified by anyone installing `mmf_setup`:

        conda config --set anaconda_upload no
        conda build --override-channels -c defaults -c conda-forge -c mforbes .

3.  (Optional) Debugging a failed build. If things go wrong before
    building, use a conda debug environment:

        conda debug -c mforbes .
        cd .../conda-bld/debug_.../work && source .../conda-bld/debug_.../work/build_env_setup.sh
        bash conda_build.sh

    (Optional) Debugging failed tests. Again use conda debug, but
    provide the broken package:

        conda debug .../conda-bld/broken/mmf_setup-0.11.0-py_0.tar.bz2
        cd .../conda-bld/debug_.../test_tmp && source .../conda-bld/debug_.../test_tmp/conda_test_env_vars.sh
        bash conda_test_runner.sh 

    See the output of conda build for the location:

        Tests failed for mmf_setup-0.3.0-py_0.tar.bz2 - moving package to /data/apps/conda/conda-bld/broken

4.  Login and upload to anaconda cloud:

        CONDA_PACKAGE="$(conda build . --output)"
        echo $CONDA_PACKAGE
        anaconda login
        anaconda upload $CONDA_PACKAGE

5.  Test the final package. If everything is done correctly, you should
    be able to build a complete environment with this package:

        conda create --use-local -n test_mmf_setup mmf_setup
        conda activate mmf_setup



<!-- Badges -->
[rtd_badge]: <https://readthedocs.org/projects/mmf-setup/badge/?version=latest>
[rtd]: <https://mmf-setup.readthedocs.io/en/latest/?badge=latest>


[drone_badge]: <https://cloud.drone.io/api/badges/forbes-group/mmf-setup/status.svg>
[drone]: https://cloud.drone.io/forbes-group/mmf-setup
[ci_badge]: <https://github.com/forbes-group/mmf-setup/actions/workflows/tests.yml/badge.svg>
[ci]: <https://github.com/forbes-group/mmf-setup/actions/workflows/tests.yml>

[ci_fork_badge]: <https://github.com/mforbes/mmf-setup-fork/actions/workflows/tests.yml/badge.svg>
[ci_fork]: <https://github.com/mforbes/mmf-setup-fork/actions/workflows/tests.yml>

[black]: https://github.com/psf/black
[black_img]: https://img.shields.io/badge/code%20style-black-000000.svg


[lgtm_mmf-setup-fork]: <https://lgtm.com/projects/g/mforbes/mmf-setup-fork/context:python>
[lgtm_mmf-setup-fork_badge]: <https://img.shields.io/lgtm/grade/python/g/mforbes/mmf-setup-fork.svg?logo=lgtm&logoWidth=18>

[lgtm_mmf-setup]: <https://lgtm.com/projects/g/forbes-group/mmf-setup/context:python>
[lgtm_mmf-setup_badge]: <https://img.shields.io/lgtm/grade/python/g/mforbes/mmf-setup.svg?logo=lgtm&logoWidth=18> 

<!-- Links -->
[Nox]: <https://nox.thea.codes> "Nox: Flexible test automation"
[Hypermodern Python]: <https://cjolowicz.github.io/posts/hypermodern-python-01-setup/> "Hypermodern Python"
[`pyenv`]: <https://github.com/pyenv/pyenv> "Simple Python Version Management: pyenv"
[`minconda`]: <https://docs.conda.io/en/latest/miniconda.html> "Miniconda"
[Conda]: <https://docs.conda.io> "Conda"
[Heptapod]: <https://heptapod.net> "Heptapod website"
[pytest]: <https://docs.pytest.org> "pytest"
[Poetry]: <https://python-poetry.org> "Poetry": Python packaging and dependency management made easy."
