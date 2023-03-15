Changes
=======
## 0.4.11
- Fix bug with warning on CoCalc.

## 0.4.10
- Add warning on CoCalc if users have not set `LC_HG_USERNAME`, or `LC_GIT_USERNAME`.

## 0.4.9
- Remove blank lines from `default.tex` so that `mmf_setup.nbinit()` works on CoCalc
  (workaround for [CoCalc issue #6210][]).
  
[CoCalc issue #6210]: <https://github.com/sagemathinc/cocalc/issues/6210>

## 0.4.8
- Don't install mercurial etc. on CoCalc by default: these are now included in the
  Default Ubuntu 20.04 image.  If you need these, then explicitly specify them:
  
  ```bash
  mmf-setup cocalc mercurial hg-git hg-evolve jupytext black
  ```
  
## 0.4.7

- Recommend and support installing mmf-setup with pipx on CoCalc.
- Use new Poetry install.
- Drop support for python3.6.

## 0.4.6

- Use python3 for CoCalc setup.  (Is a problem on Docker images).
- Ignore matplotlib errors.

## 0.4.3

- Resolves issue #28: Failure of `mmf_initial_setup` on Mac OS X if .DS_Store files exist.
- Resolves issue #29: Relative paths in config files resolve to absolute paths
- Added aliases `findpy`, `findf`, `finda` etc. for CoCalc for running `find` + `grep`.

## 0.4.2

- Resolves issue #26: Significant improvements for installation on CoCalc.
  - Moves `~/.bashrc` to `~/.bashrc_cocalc` so we can insert `~/.local/bin` to the
    `PATH` for non-login shells.  This is important when trying to push with `hg` over
    SSH, which runs `hg` without logging in.  Our new workflow needs that `hg` to have
    access to `evolve` etc.   Previously this worked by updating these with the system
    `Python 2` version of `hg`, but that now fails with new projects, so we have removed
    this.
  - Add `.hgrc` tweaks to top-level cocalc `~.hgrc` (might as well include `hgrc.lga`
    here now so students etc. can see these.  Don't enable `evolve` etc. by default
    though.)
  - Users should now call `eval "$(mmf_setup -v -H)"` rather than using source
    `. mmf_setup -H`.  Sourcing `mmf_setup` now emits a deprecation warning message.
  - Cocalc install is now tested in an isolated manner.  (Only the `nox -s test_cocalc`
    works... see issue #27.)
- Make `hgrc.full` POSIX compliant (work with `sh`).  (Was causing GitHub workflow to
  fail.)  Scripts still require `bash` which is explicitly chosen when we call
  `run-tests.py`.
- Working GitHub workflows and cocalc tests.
- Updated release process.

## 0.4.1

- Make `mmf_setup -v` output clean so that we can `eval "$(mmf_setup -v)"` rather than
  sourcing. *In the future we will make this a python file, so `eval` will be the only
  option.*
- Fixed issues with `nbinit()` failing with not paths defined.
- Added more tests.

## 0.4.0

- Resolves issue #23: Drop support of nbclean mercurial extension (to hard to
  maintain), thereby making issues #1, #3, #8, #9, #11, obsolete.
- Remove installation of old obsolete notebook extensions like Calico tools,
  [RISE](https://rise.readthedocs.io/en/stable/installation.html) etc. These can all be
  installed now with either the standard extensions, or pip. 
    * With pip:
    
        ```bash
        python -m pip install jupyter_contrib_nbextensions RISE
        jupyter contrib nbextension install --user
        ```
       
    * With conda:

        ```bash
        conda install -c conda-forge jupyter_contrib_nbextensions rise
        jupyter contrib nbextension install --user
        ```
  See also
  [NBExtensions](https://github.com/ipython-contrib/jupyter_contrib_nbextensions).
  
- Improved test isolation.
- Expanded options for `mmf_setup`.
    - Mercurial configuration is now in two stages: `hgrc.lga` which gives the `hg lg`
      command safely using only builtin modules, and `hgrc.full` which includes this,
      and also activates the `hg-git` and `evolve` extensions.  This also applies the
      `update` hook for including `.hgrc` files, but asks the user for confirmation
      because this is a security risk.
    
## 0.3.1
- Added `mmf_setup cocalc` initialization for CoCalc.com projects
  (changed from `mmf_setup smc`).
- Add message to `nbinit()` call indicating that HGROOT has been added
  to `sys.path`.
- Resolves issue #22 with git username classes on CoCalc. 

## 0.3.0
- Support python 3 - drop support for python 2.
- Conda installable from mforbes channel on anaconda cloud.
- Add missing default.tex theme so that nbinit() brings in math definitions even if no
  theme is specified.
- Fixed KeyError: `asyncio` error on failed IPython import.

## 0.1.13
- Incomplete version... everything here is rolled into 0.3.0

## 0.1.12
- Made `mmf_initial_setup` python 3 compliant.
- Added logging to `nbinit()` and made some slight tweaks to `HGROOT`.
- Added `\D`, `\sn`, `\cn`, `\dn` commands for MathJaX.

## 0.1.11
- Resolve issue #20:
    - `mmf_setup.set_path.set_path_from_file` allows for configuration of path in
      `setup.cfg` file.
    - Fix python 3 bug: TypeError: Can't mix strings and bytes in path components

## 0.1.10
- Added better backwards compatibility for previous changes.
- Simplified nbinit theme management and use `'default'` theme as default.
    - New themes only need to overwrite what they need.
    - Don't change fonts as default since this does not work well on CoCalc (the code
      cells change size on clicking which is a pain.)

## 0.1.9
- Resolve issues:
    - \#17: store `mmf_setup.HGROOT`
    - \#18: safer exception handling with `nbclean` commands so data is not lost
    - \#19: `nbclean` works with new mercurial API

- Added `\erfi`, `\sech`, `\Braket`
- `import mmf_setup.set_path.hgroot` will add `HGROOT` to path without IPython
- Added standalone `nbinit.py` for use without `mmf_setup` installs.

## 0.1.8
- Resolves issue #15.
- Use `$BASH_SOURCE{0}` to get `BIN_DIR` (resolves issue #16)
- Added `nbinit(hgroot)` option to add `hg root` to `sys.path` (issue #13)

## 0.1.7
- Changed option to `--clean-all` (resolves issue #7)
- Updated the notebook style (added `\Tr`, fixed output overflow issue)
- Added pip option mmf_setup[nbextensions]
- Removed `'EnableNBExtensionApp'` dependence which broke new Jupyter (resolves issue
  #12)
- Added some files for initializing setup on Sage Mathcloud (SMC) (resolves issue #14).
    - Added `mmf_initial_setup` script and some init files (`.inputrc`, `.hgrc`,
      `.bash_aliases`).
    - Run with `mmf_setup smc`
- Removed old extension manager since nbextensions are quite good now.

## 0.1.6
- Added cupdate command (resolves issue #4)
- Fixed bug with ccommit where it did not accept a list of files
  (issue #6)
- Issue commands in a context to provide a robust mechanism for
  recovery (issue #5)
