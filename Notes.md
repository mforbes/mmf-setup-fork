% Developer Notes

Developer Notes
===============

[![Documentation Status][rtd_badge]][rtd]
[![Tests][ci_badge]][ci]
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

* Testing at with GitHub actions:

    [![Tests][ci_badge]][ci]

* Code quality testing at [lgtm](https://lgtm.com):

    [![Total
alerts](https://img.shields.io/lgtm/alerts/g/mforbes/mmf-setup-fork.svg?logo=lgtm&logoWidth=18)](https://lgtm.com/projects/g/mforbes/mmf-setup-fork/alerts/)

    [![Language grade: Python][lgtm_mmf-setup_badge]][lgtm_mmf-setup]
    [![Language grade: Python][lgtm_mmf-setup-fork_badge]][lgtm_mmf-setup-fork]

* Style:

    [![Code style: black][black_img]][black]



Releases
--------

**PyPi**

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

2.  Commit all your changes. (This is an optional commit, if the changes
    are small, this can be rolled in with the following commit.)
3.  Remove the `'dev'` from the version, i.e. `'0.1.11dev' -> '0.1.11'`,
    in the following files:

        setup.py
        meta.yaml

4.  Add a note about the changes in `CHANGES.txt`.
5.  Check that the documentation looks okay:

        make README_CHANGES.html
        open README_CHANGES.html
        make clean

6.  Commit the changes. Start the commit message with:

        hg com -m "REL: 0.1.11 ..."

7.  Create a pull request (PR) on bitbucket to pull this branch to
    `default` and make sure to specify to close the branch on pull.
8.  Check, approve, and merge the PR.
9.  Upload your package to `pypi` with `twine`:

        python setup.py sdist bdist_wheel
        twine check dist/mmf_setup-*
        twine upload dist/mmf_setup-*

10. Pull the merge from bitbucket to your development machine but **do
    not update**.
11. Update the version in `setup.py` and `meta.yaml` to `'0.1.12dev'` or
    whatever is relevant.
12. From the previous commit (the last commit on branch `0.1.11` in this
    case), change the branch:

        hg branch 0.1.12

13. Commit and optionally push. Now you are ready to work on new
    changes:

        hg com -m "BRN: Start branch 0.1.12"
        hg push -r . --new-branch

**Anaconda**

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
[ci_badge]: <https://github.com/mforbes/mmf-setup-fork/actions/workflows/tests.yml/badge.svg>
[ci]: <https://github.com/mforbes/mmf-setup-fork/actions/workflows/tests.yml>

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
