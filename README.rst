.. -*- rst -*- -*- restructuredtext -*-

.. This file should be written using the restructure text
.. conventions.  It will be displayed on the repository source page and
.. serves as the documentation of the directory.

.. |virtualenv.py| replace:: ``virtualenv.py``
.. _virtualenv.py: https://raw.github.com/pypa/virtualenv/master/virtualenv.py

.. |EPD| replace:: Enthough Python Distribution
.. _EPD: http://www.enthought.com/products/epd.php
.. _Anaconda: https://store.continuum.io/cshop/anaconda
.. _Conda: http://docs.continuum.io/conda
.. _Miniconda: http://conda.pydata.org/miniconda.html

.. _Enthought: http://www.enthought.com
.. _Continuum Analytics: http://continuum.io

.. _Spyder: https://code.google.com/p/spyderlib/
.. _Wakari: https://www.wakari.io
.. _Canopy: https://www.enthought.com/products/canopy/

.. _mercurial: http://mercurial.selenic.com/
.. _virtualenv: http://www.virtualenv.org/en/latest/
.. _IPython: http://ipython.org/
.. _Ipython notebook: \
   http://ipython.org/ipython-doc/dev/interactive/htmlnotebook.html
.. _NBViewer: http://nbviewer.ipython.org
.. |pip| replace:: ``pip``
.. _pip: http://www.pip-installer.org/
.. |nox| replace:: ``nox``
.. _nox: https://nox.thea.codes
.. _git: http://git-scm.com/
.. _github: https://github.com
.. _RunSnakeRun: http://www.vrplumber.com/programming/runsnakerun/
.. _GSL: http://www.gnu.org/software/gsl/
.. _pygsl: https://bitbucket.org/mforbes/pygsl
.. _Sphinx: http://sphinx-doc.org/
.. _SciPy: http://www.scipy.org/
.. _Mayavi: http://code.enthought.com/projects/mayavi/
.. _NumPy: http://numpy.scipy.org/
.. _Numba: https://github.com/numba/numba#readme
.. _NumbaPro: http://docs.continuum.io/numbapro/
.. _Blaze: http://blaze.pydata.org
.. _Python: http://www.python.org/
.. _matplotlib: http://matplotlib.org/
.. _Matlab: http://www.mathworks.com/products/matlab/
.. _MKL: http://software.intel.com/en-us/intel-mkl
.. _Intel compilers: http://software.intel.com/en-us/intel-compilers
.. _Bento: http://cournape.github.com/Bento/
.. _pyaudio: http://people.csail.mit.edu/hubert/pyaudio/
.. _PortAudio: http://www.portaudio.com/archives/pa_stable_v19_20111121.tgz
.. _MathJax: http://www.mathjax.org/
.. _reStructuredText: http://docutils.sourceforge.net/rst.html
.. _Emacs: http://www.gnu.org/software/emacs/
.. _Pymacs: https://github.com/pinard/Pymacs
.. _Ropemacs: http://rope.sourceforge.net/ropemacs.html
.. _PyPI: https://pypi.python.org/pypi

.. _FFTW: http://www.fftw.org
.. _EC2: http://aws.amazon.com/ec2/
.. _QT: http://qt.digia.com

.. |site.USER_BASE| replace:: ``site.USER_BASE``
.. _site.USER_BASE: https://docs.python.org/2/library/site.html#site.USER_BASE


.. This is so that I can work offline.  It should be ignored on bitbucket for
.. example.

.. sidebar:: Sidebar

   .. contents::

===========
 mmf_setup
===========
This meta-project provides an easy way to install all of the python
tools I typically use.  It also serves as a fairly minimal example of
setting up a package the |pip|_ can install, and specifying
dependencies.

In particular, I structure it for the following use-cases:

1. Rapid installation and configuration of the tools I need.  For example, I often use
   [CoCalc](cocalc.com).  Whenever I create a new project, I need to perform some
   initialization.  With this project, it is simply a matter of using |pip|_ to install
   this package, and then using some of the tools. Specifically::

     python3 -m pip install --user mmf-setup
     mmf_setup cocalc

     # OR install from a particular version of the sources.
     python3 -m pip install --user hg+https://alum.mit.edu/www/mforbes/hg/forbes-group/mmf-setup@0.4.0
     mmf_setup cocalc

2. Initial setup of a python distribution on a new computer.  This is a little more
   involved since one needs to first install python (I recommend using Miniconda_) and
   then updating the tools.
3. A place to document various aspects of installing and setting up python and related
   tools.  Some of this is old, but kept here for reference.
4. A generic way of setting `sys.path` for development work using the following (in
   order of decreasing precedence) by importing `mmf_setup.set_path`.

   * An entry in a `pyproject.toml` file somewhere in a higher-level directory.
   * An entry in a `setup.cfg` file somewhere in a higher-level directory.
   * The directory returned by `hg root`.
   * The directory returned by `git rev-parse --show-toplevel`.

====================
 Quickstart (TL;DR)
====================

1. To get the notebook initialization features without having to install the
   package, just copy `nbinit.py <nbinit.py>`_ to your project.  Importing this
   will try to execute ``import mmf_setup;mmf_setup.nbinit()`` but failing this,
   will manually run a similar code.

2. Install this package from the source directory, PyPI_, etc. with
   one of the following:
  
   * **Directly from PyPI**

     ``python3 -m pip install --user mmf-setup[nbextensions]``

   * **From Source**

     ``python3 -m pip install --user hg+https://alum.mit.edu/www/mforbes/hg/forbes-group/mmf-setup[nbextensions]``

   * **From Local Source** (*Run this from the source directory after you unpack it.*)

     ``python3 -m pip install --user .[nbextensions]``

   Note: these includes the ``nbextensions`` extra.  You and run without the ``--user``
   flag if you want to install them system-wide  rather than into |site.USER_BASE|_.

3. To get the notebook tools for Jupyter (IPython) notebooks, execute
   the following as a code cell in your notebook and then trust the
   notebook with ``File/Trust Notebook``::

       import mmf_setup; mmf_setup.nbinit()

   This will set the theme which is implemented in the output cell so it is stored for
   use online such as when rendered through NBViewer_.  One can specify different
   themes. (Presently only ``theme='default'`` and ``theme='mmf'`` are supported.)

4. **Mercurial:** If you want to install mercurial with the ``hg-git`` and ``hg-evolve``
   extensions, then you can do that with the ``hg`` extra::

      python3 -m pip install --user .[hg]

   This essentially runs ``pip install mercurial hg-git hg-evolve``. 
   ``mmf_setup`` script::

      . mmf_setup -v

   To do this automatically when you login, add this line to your
   ``~/.bashc`` or ``~/.bash_profile`` scripts.

   These can also be enabled manually by adding the following to your ``~/.hgrc`` file::

      [extensions]
      evolve =
      topics =
      hggit =
      
====================
 Setting `sys.path`
====================

The preferred way to work with python code is to install it, preferably into a virtual
environment or a conda environment.  By installing it, you will assure that your program
or library is available to notebooks, etc. by being properly inserted into `sys.path`.
When developing, code, one can also do a `"editable" installs`
<https://pip.pypa.io/en/stable/reference/pip_install/#local-project-installs>` with
`pytnon -m install -e <path>` so that code updates are seen.

When developing code, however, this may not meet all use-cases, so we provide some
generic tools in `mmf_utils.set_path` for manipulating `sys.path`.  These work by
providing ways to specify local paths for development work.  The following options are
provided in order of precedence:

One can also manually set the path with one of the following statements:

* `import mmf_setup.set_path.hgroot`: Sets `mmf_setup.ROOT = mmf_setup.HGROOT` to the
  outcome of `hg root`.
* `import mmf_setup.set_path.gitroot`: Sets `mmf_setup.ROOT = mmf_setup.GITROOT` to the
  outcome of `git rev-parse --show-toplevel`.
* `import mmf_setup.set_path.config_files`


======================
 Mercurial (hg) Tools
======================

If you source the output of the ``mmf_setup`` script::

   . mmf_setup -v

then your ``HGRCPATH`` will be amended to include this projects
``hgrc`` file which does the following:

1. Adds some useful extensions:

   * ``evolve`` 
   * ``topics`` 
   * ``hg-git``
     
2. Adds the following commands:

   * ``hg lga`` (or ``hg lg``): provides a nice concise graphical
     display of the repo.

=================
 Developer Notes
=================

There are a couple of subtle points here that should be mentioned.

* Our approach of ``. mmf_setup`` sets ``HGRCPATH`` but if this was
  not set before, then this will skip the default search.  As such, we
  insert ``~/.hgrc`` if ``HGRCPATH`` was not previously set.  This is
  not ideal, but short of sticking an ``%include`` statement in the
  users ``~/.hgrc`` file, or creating an ``hg`` alias, I do not see a
  robust solution.  Note: we only insert ``~/.hgrc`` if ``HGRCPATH``
  is not defined - I ran into problems when always inserting it since
  this can change the order of precedence.
* Chain commands with semicolons ``;`` not ``&&`` so that things are
  restored even if a command fails.  (For example, ``hg ccom`` with a
  notebook that only has output changes used to fail early.)

__ https://selenic.com/pipermail/mercurial-devel/2011-December/036480.html

Releases
========

**PyPi**

To release a new version be sure to do the following. (The examples
use revision numbers etc. for release 0.1.11.)

1. Make sure your code works and that the tests pass. Pull any open
   issues into the main release branch, closing those issue branches.

   To run the tests, make sure you have nox_ and Conda_ installed in
   some environment, then run::

     nox
   
   This will create a bunch of environments in ``.nox`` and run the
   test-suite on those.

   * To activate one for testing, activate the environment::

       conda activate .nox/test_conda-3-6
       make test
       
   * These can get quite large, so you might want to remove them when
     you are done with one of the following:: 

       rm -rf .nox
       make clean        # Does this and more

   To manually run the test suite::

     conda env remove -n tst3        # If needed
     conda create -yn tst3 python=3
     conda activate tst3
     pip install -e .[test]
     make test

   If you want to test things from conda, you can get a debug
   environment by running::

     conda debug .

   After you activate the development library, install pytest::

     cd /data/apps/conda/conda-bld/debug_.../work && source build_env_setup.sh
     pip install -e .[test]
     
2. Commit all your changes. (This is an optional commit, if the
   changes are small, this can be rolled in with the following
   commit.)
   
3. Remove the ``'dev'`` from the version, i.e. ``'0.1.11dev' ->
   '0.1.11'``, in the following files::
   
     setup.py
     meta.yaml
   
4. Add a note about the changes in ``CHANGES.txt``.
5. Check that the documentation looks okay::

     make README_CHANGES.html
     open README_CHANGES.html
     make clean
     
6. Commit the changes.  Start the commit message with::

     hg com -m "REL: 0.1.11 ..."

7. Create a pull request (PR) on bitbucket to pull this branch to
   ``default`` and make sure to specify to close the branch on pull.
8. Check, approve, and merge the PR.
9. Upload your package to ``pypi`` with ``twine``::

     python setup.py sdist bdist_wheel
     twine check dist/mmf_setup-*
     twine upload dist/mmf_setup-*
   
10. Pull the merge from bitbucket to your development machine but **do not update**.
11. Update the version in ``setup.py`` and ``meta.yaml`` to
    ``'0.1.12dev'`` or whatever is relevant.
12. From the previous commit (the last commit on branch ``0.1.11`` in this case),
    change the branch::

      hg branch 0.1.12
      
13. Commit and optionally push.  Now you are ready to work on new changes::

      hg com -m "BRN: Start branch 0.1.12"
      hg push -r . --new-branch

**Anaconda**

The information about building the package for conda is specified in
the ``meta.yaml`` file.

1. (Optional) Prepare a clean environment::
     
      conda env remove -n tst3        # If needed
      conda create -yn tst3 python=3 anaconda-client conda-build
      conda activate tst3

   *(I keep the conda build tools in my base environment so I do not
   need this.)*
      
2. Build locally and test.  Note: we need to specify the channel since
   ``python-hglib`` is there.  Since we will host this on our channel,
   this will be explicitly specified by anyone installing ``mmf_setup``::

      conda config --set anaconda_upload no
      conda build --override-channels -c defaults -c conda-forge -c mforbes .

3. (Optional) Debugging a failed build. If things go wrong before
   building, use a conda debug environment::

      conda debug -c mforbes .
      cd .../conda-bld/debug_.../work && source .../conda-bld/debug_.../work/build_env_setup.sh
      bash conda_build.sh

   (Optional) Debugging failed tests. Again use conda debug, but
   provide the broken package::

     conda debug .../conda-bld/broken/mmf_setup-0.11.0-py_0.tar.bz2
     cd .../conda-bld/debug_.../test_tmp && source .../conda-bld/debug_.../test_tmp/conda_test_env_vars.sh
     bash conda_test_runner.sh 
     
   See the output of conda build for the location::

      Tests failed for mmf_setup-0.3.0-py_0.tar.bz2 - moving package to /data/apps/conda/conda-bld/broken
      
3. Login and upload to anaconda cloud::

      CONDA_PACKAGE="$(conda build . --output)"
      echo $CONDA_PACKAGE
      anaconda login
      anaconda upload $CONDA_PACKAGE

5. Test the final package.  If everything is done correctly, you
   should be able to build a complete environment with this package::

      conda create --use-local -n test_mmf_setup mmf_setup
      conda activate mmf_setup
   
Notes
=====

Various notes about python, IPython, etc. are stored in the docs folder.

__ http://jupyter.cs.brynmawr.edu/hub/dblank/public/Jupyter%20Help.ipynb#2.-Installing-extensions

