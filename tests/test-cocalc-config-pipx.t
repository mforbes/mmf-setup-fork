First we set the PATH and make sure that PYTHONUSERBASE is set to the local folder so we
don't muck up the test-runner's ~/.local directory.

  $ export PYTHONUSERBASE="$HOME/.local"
  $ export PATH="$HOME/.local/bin/:$PATH"
  $ export PIPX_HOME="$HOME"
  $ python3 -m venv test_venv
  $ source test_venv/bin/activate
  $ python3 -m pip install -q -U pip pipx
  $ pipx install "$RUNTESTDIR/.."
  creating virtual environment...
  creating shared libraries...
  upgrading shared libraries...
  determining package name from '*'... (glob)
  creating virtual environment...
  installing mmf-setup from spec '*'... (glob)
  * Note: mmf_initial_setup was already on your PATH at (glob) (?)
    */mmf_initial_setup (glob) (?)
  * Note: mmf_setup was already on your PATH at (glob) (?)
    */mmf_setup (glob) (?)
  * Note: mmf_setup_bash.py was already on your PATH at (glob) (?)
    */mmf_setup_bash.py (glob) (?)
  done! * (glob)
    installed package mmf-setup *, installed using Python * (glob)
    These apps are now globally available
      - mmf_initial_setup
      - mmf_setup
      - mmf_setup_bash.py
  $ mmf_setup cocalc -v
  DRY RUN: the following is what would happen with the -v option
  
  pipx is $TESTTMP/test_venv/bin/pipx
  mmf-setup * (glob)
  Found pipx mmf-setup venv... Switching to PYTHON3=$TESTTMP/venvs/mmf-setup/bin/python3
  # Injecting mmf-setup with mercurial, hg-evolve, hg-git, jupytext, and black
  pipx inject mmf-setup mercurial hg-evolve hg-git jupytex black
  # Installing poetry...
  curl -sSL https://install.python-poetry.org | $TESTTMP/venvs/mmf-setup/bin/python3 -
  # Setting up config files for CoCalc...
  Warning: No dest = 2nd line in file '*/cocalc/README.md'... ignoring (glob)
  Warning: No dest = 2nd line in file '*/cocalc/gitconfig'... ignoring (glob)
  Warning: No dest = 2nd line in file '*/cocalc/message.txt'... ignoring (glob)
  Using <home> = $TESTTMP
  Using dir = */site-packages/mmf_setup/_data/config_files/cocalc (glob)
  os.symlink('*/site-packages/mmf_setup/_data/config_files/cocalc/bash_aliases', '$TESTTMP/.bash_aliases') (glob)
  os.symlink('*/site-packages/mmf_setup/_data/config_files/cocalc/bashrc', '$TESTTMP/.bashrc') (glob)
  os.symlink('*/site-packages/mmf_setup/_data/config_files/cocalc/gitignore', '$TESTTMP/.gitignore') (glob)
  os.symlink('*/site-packages/mmf_setup/_data/config_files/cocalc/hgignore', '$TESTTMP/.hgignore') (glob)
  os.symlink('*/site-packages/mmf_setup/_data/config_files/cocalc/hgrc', '$TESTTMP/.hgrc') (glob)
  os.symlink('*/site-packages/mmf_setup/_data/config_files/cocalc/inputrc', '$TESTTMP/.inputrc') (glob)
  os.symlink('*/site-packages/mmf_setup/_data/config_files/cocalc/mr', '$TESTTMP/.local/bin/mr') (glob)
  os.symlink('*/site-packages/mmf_setup/_data/config_files/cocalc/mrconfig', '$TESTTMP/.mrconfig') (glob)
  os.symlink('*/site-packages/mmf_setup/_data/config_files/cocalc/pdbrc', '$TESTTMP/.pdbrc') (glob)
  Configurations for your CoCalc project have been symlinked as described above.
  
  If you use version control, then to get the most of the configuration,
  please make sure that you set the following variables on your personal
  computer, and forward them when you ssh to the project:
  
      # ~/.bashrc or similar
      LC_HG_USERNAME=Your Full Name <your.email.address+hg@gmail.com>
      LC_GIT_USEREMAIL=your.email.address+git@gmail.com
      LC_GIT_USERNAME=Your Full Name
  
  To forward these, your SSH config file (~/.ssh/config) might look like:
  
      # ~/.ssh/config
      Host cc-project1
        User ff1cb986f...
      
      Host cc*
        HostName ssh.cocalc.com
        ForwardAgent yes
        SendEnv LC_HG_USERNAME
        SendEnv LC_GIT_USERNAME
        SendEnv LC_GIT_USEREMAIL
        SetEnv LC_EDITOR=vi

We filter the output with grep because the order of these installs is random.
  $ mmf_setup cocalc | grep -Ev "^(Requirement|Collecting|  Downloading)"
  installing mercurial...
  done! * (glob)
  installing hg-evolve...
  done! * (glob)
  installing hg-git...
  done! * (glob)
  installing jupytex...
  done! * (glob)
  installing black...
  done! * (glob)
  Warning: No dest = 2nd line in file '*/cocalc/README.md'... ignoring (glob)
  Warning: No dest = 2nd line in file '*/cocalc/gitconfig'... ignoring (glob)
  Warning: No dest = 2nd line in file '*/cocalc/message.txt'... ignoring (glob)
  pipx is $TESTTMP/test_venv/bin/pipx
  mmf-setup * (glob)
  Found pipx mmf-setup venv... Switching to PYTHON3=$TESTTMP/venvs/mmf-setup/bin/python3
  # Injecting mmf-setup with mercurial, hg-evolve, hg-git, jupytext, and black
  pipx inject mmf-setup mercurial hg-evolve hg-git jupytex black
    injected package mercurial into venv mmf-setup
    injected package hg-evolve into venv mmf-setup
    injected package hg-git into venv mmf-setup
    injected package jupytex into venv mmf-setup
    injected package black into venv mmf-setup
  # Installing poetry...
  curl -sSL https://install.python-poetry.org | $TESTTMP/venvs/mmf-setup/bin/python3 -
  Retrieving Poetry metadata
  
  # Welcome to Poetry!
  
  This will download and install the latest version of Poetry,
  a dependency and package manager for Python.
  
  It will add the `poetry` command to Poetry's bin directory, located at:
  
  $TESTTMP/.local/bin
  
  You can uninstall at any time by executing this script with the --uninstall option,
  and these changes will be reverted.
  
  Installing Poetry (*) (glob)
  Installing Poetry (*): Creating environment (glob)
  Installing Poetry (*): Installing Poetry (glob)
  Installing Poetry (*): Creating script (glob)
  Installing Poetry (*): Done (glob)
  
  Poetry (*) is installed now. Great! (glob)
  
  To get started you need Poetry's bin directory ($TESTTMP/.local/bin) in your `PATH`
  environment variable.
  
  Add `export PATH="$TESTTMP/.local/bin:$PATH"` to your shell configuration file.
  
  Alternatively, you can call Poetry explicitly with `$TESTTMP/.local/bin/poetry`.
  
  You can test that everything is set up by executing:
  
  `poetry --version`
  
  # Setting up config files for CoCalc...
  */mmf_initial_setup -v */site-packages/mmf_setup/_data/config_files/cocalc (glob)
  Using <home> = $TESTTMP
  Using dir = */site-packages/mmf_setup/_data/config_files/cocalc (glob)
  os.symlink('*/site-packages/mmf_setup/_data/config_files/cocalc/bash_aliases', '$TESTTMP/.bash_aliases') (glob)
  os.symlink('*/site-packages/mmf_setup/_data/config_files/cocalc/bashrc', '$TESTTMP/.bashrc') (glob)
  os.symlink('*/site-packages/mmf_setup/_data/config_files/cocalc/gitignore', '$TESTTMP/.gitignore') (glob)
  os.symlink('*/site-packages/mmf_setup/_data/config_files/cocalc/hgignore', '$TESTTMP/.hgignore') (glob)
  os.symlink('*/site-packages/mmf_setup/_data/config_files/cocalc/hgrc', '$TESTTMP/.hgrc') (glob)
  os.symlink('*/site-packages/mmf_setup/_data/config_files/cocalc/inputrc', '$TESTTMP/.inputrc') (glob)
  os.symlink('*/site-packages/mmf_setup/_data/config_files/cocalc/mr', '$TESTTMP/.local/bin/mr') (glob)
  os.symlink('*/site-packages/mmf_setup/_data/config_files/cocalc/mrconfig', '$TESTTMP/.mrconfig') (glob)
  os.symlink('*/site-packages/mmf_setup/_data/config_files/cocalc/pdbrc', '$TESTTMP/.pdbrc') (glob)
  Configurations for your CoCalc project have been symlinked as described above.
  
  If you use version control, then to get the most of the configuration,
  please make sure that you set the following variables on your personal
  computer, and forward them when you ssh to the project:
  
      # ~/.bashrc or similar
      LC_HG_USERNAME=Your Full Name <your.email.address+hg@gmail.com>
      LC_GIT_USEREMAIL=your.email.address+git@gmail.com
      LC_GIT_USERNAME=Your Full Name
  
  To forward these, your SSH config file (~/.ssh/config) might look like:
  
      # ~/.ssh/config
      Host cc-project1
        User ff1cb986f...
      
      Host cc*
        HostName ssh.cocalc.com
        ForwardAgent yes
        SendEnv LC_HG_USERNAME
        SendEnv LC_GIT_USERNAME
        SendEnv LC_GIT_USEREMAIL
        SetEnv LC_EDITOR=vi
