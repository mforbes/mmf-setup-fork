First we set the PATH and make sure that PYTHONUSERBASE is set to the local folder so we
don't muck up the test-runner's ~/.local directory.

  $ export PYTHONUSERBASE="$HOME/.local"
  $ export PATH="$RUNTESTDIR/../bin/:$HOME/.local/bin/:$PATH"
  $ mmf_initial_setup --help
  Usage: mmf_initial_setup [options] dir1 dir2 ...
  
  Creates symlinks to files in the specified config directories (default "./").
  
  Options:
    -h, --help         show this help message and exit
    --home=<home>      use <home> rather than ~ for installation.(Used to
                       replace '~' in dest strings.)
    -v, --verbose      print lots of information
    -n, --no-action    don't do anything:only print commands that would be
                       executed
    -i, --interactive  prompt before taking action
    -a, --abs-path     Use absolute symlinks (defaults are relative to ~)
  
  Run from the desired config directory, and files with a second line like
  "dest = ~/.bashrc"  will be symlinked to the specified location.  If a file
  already exists, it will be backed up (copied to a file with a .bak extension).
  Existing symlinks will be overwritten.
  $ mmf_setup --help
  usage: mmf_setup cocalc [options] OR mmf_setup -v [options]
  
  The first invocation will setup cocalc.com projects:
  
     mmf_setup cocalc [-v]
  
  The second invocation will show which environmental variables will be set,
  and can be evaluated to set these in your shell:
  
     mmf_setup -v [options]
  
  Valid options for mmf_setup_bash.py are:
  Usage: mmf_setup_bash.py [options]
  
  Options:
    -h, --help   show this help message and exit
    -d, --debug  debug missing files
    -H, --hg     Include hgrc.full in HGRCPATH with a complete set of mercurial
                 options including: the evolve extension with topics enabled,
                 the hggit extension so you can clone from git, and an update
                 hook to include project-specific .hgrc file to .hg/hgrc. (Note:
                 this is a POTENTIAL SECURITY RISK.  Make sure you inspect the
                 .hgrc file before running further mercurial commands.)
  
  You can set these in your shell by running mmf_setup_bash.py:
  
     eval "$(mmf_setup -v [options])"

  $ touch $HOME/.bash_aliases   # Touch this to see if mmf_setup backs it up.
  $ mmf_setup cocalc -v
  DRY RUN: the following is what would happen with the -v option
  
  # Installing mercurial, hg-evolve, hg-git, jupytext for python3...
  python3 -m pip install --upgrade --user pip mercurial hg-evolve hg-git jupytext
  # Setting up config files for CoCalc...
  Using <home> = $TESTTMP
  Using dir = */site-packages/mmf_setup/_data/config_files/cocalc (glob)
  Directory $TESTTMP/.local/bin does not exist.
  os.makedirs('$TESTTMP/.local/bin')
  os.symlink('*/site-packages/mmf_setup/_data/config_files/cocalc/mr', '$TESTTMP/.local/bin/mr') (glob)
  os.symlink('*/site-packages/mmf_setup/_data/config_files/cocalc/pdbrc', '$TESTTMP/.pdbrc') (glob)
  File $TESTTMP/.bash_aliases exists.
  backup('$TESTTMP/.bash_aliases')
  os.symlink('*/site-packages/mmf_setup/_data/config_files/cocalc/bash_aliases', '$TESTTMP/.bash_aliases') (glob)
  os.symlink('*/site-packages/mmf_setup/_data/config_files/cocalc/bashrc', '$TESTTMP/.bashrc') (glob)
  os.symlink('*/site-packages/mmf_setup/_data/config_files/cocalc/mrconfig', '$TESTTMP/.mrconfig') (glob)
  os.symlink('*/site-packages/mmf_setup/_data/config_files/cocalc/hgrc', '$TESTTMP/.hgrc') (glob)
  os.symlink('*/site-packages/mmf_setup/_data/config_files/cocalc/inputrc', '$TESTTMP/.inputrc') (glob)
  os.symlink('*/site-packages/mmf_setup/_data/config_files/cocalc/hgignore', '$TESTTMP/.hgignore') (glob)
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
  $ mmf_setup cocalc | grep -Ev "^Requirement already satisfied"
  # Installing mercurial, hg-evolve, hg-git, jupytext for python3...
  python3 -m pip install --upgrade --user pip mercurial hg-evolve hg-git jupytext
  Collecting * (glob)
    Downloading * (glob)
  Collecting * (glob)
    Downloading * (glob)
  Collecting * (glob)
    Downloading * (glob)
  Collecting * (glob)
    Downloading * (glob)
  Installing collected packages: markdown-it-py, mdit-py-plugins, pyyaml, jupytext
  Successfully installed jupytext* markdown-it-py* mdit-py-plugins* pyyaml* (glob)
  # Setting up config files for CoCalc...
  */mmf_initial_setup -v */site-packages/mmf_setup/_data/config_files/cocalc (glob)
  Using <home> = $TESTTMP
  Using dir = */site-packages/mmf_setup/_data/config_files/cocalc (glob)
  os.symlink('*/site-packages/mmf_setup/_data/config_files/cocalc/mr', '$TESTTMP/.local/bin/mr') (glob)
  os.symlink('*/site-packages/mmf_setup/_data/config_files/cocalc/pdbrc', '$TESTTMP/.pdbrc') (glob)
  File $TESTTMP/.bash_aliases exists.
  backup('$TESTTMP/.bash_aliases')
  os.rename('$TESTTMP/.bash_aliases', '$TESTTMP/.bash_aliases.bak')
  os.symlink('*/site-packages/mmf_setup/_data/config_files/cocalc/bash_aliases', '$TESTTMP/.bash_aliases') (glob)
  os.symlink('*/site-packages/mmf_setup/_data/config_files/cocalc/bashrc', '$TESTTMP/.bashrc') (glob)
  os.symlink('*/site-packages/mmf_setup/_data/config_files/cocalc/mrconfig', '$TESTTMP/.mrconfig') (glob)
  os.symlink('*/site-packages/mmf_setup/_data/config_files/cocalc/hgrc', '$TESTTMP/.hgrc') (glob)
  os.symlink('*/site-packages/mmf_setup/_data/config_files/cocalc/inputrc', '$TESTTMP/.inputrc') (glob)
  os.symlink('*/site-packages/mmf_setup/_data/config_files/cocalc/hgignore', '$TESTTMP/.hgignore') (glob)
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

  $ ls -aF "$HOME"
  ./
  ../
  .bash_aliases@
  .bash_aliases.bak
  .bashrc@
  .hgignore@
  .hgrc@
  .inputrc@
  .local/
  .mrconfig@
  .pdbrc@
  * (glob)
  $ mmf_setup cocalc -v
  DRY RUN: the following is what would happen with the -v option
  
  # Installing mercurial, hg-evolve, hg-git, jupytext for python3...
  python3 -m pip install --upgrade --user pip mercurial hg-evolve hg-git jupytext
  # Setting up config files for CoCalc...
  Using <home> = $TESTTMP
  Using dir = */site-packages/mmf_setup/_data/config_files/cocalc (glob)
  Symlink $TESTTMP/.local/bin/mr exists.
  os.remove('$TESTTMP/.local/bin/mr')
  os.symlink('*/site-packages/mmf_setup/_data/config_files/cocalc/mr', '$TESTTMP/.local/bin/mr') (glob)
  Symlink $TESTTMP/.pdbrc exists.
  os.remove('$TESTTMP/.pdbrc')
  os.symlink('*/site-packages/mmf_setup/_data/config_files/cocalc/pdbrc', '$TESTTMP/.pdbrc') (glob)
  Symlink $TESTTMP/.bash_aliases exists.
  os.remove('$TESTTMP/.bash_aliases')
  os.symlink('*/site-packages/mmf_setup/_data/config_files/cocalc/bash_aliases', '$TESTTMP/.bash_aliases') (glob)
  Symlink $TESTTMP/.bashrc exists.
  os.remove('$TESTTMP/.bashrc')
  os.symlink('*/site-packages/mmf_setup/_data/config_files/cocalc/bashrc', '$TESTTMP/.bashrc') (glob)
  Symlink $TESTTMP/.mrconfig exists.
  os.remove('$TESTTMP/.mrconfig')
  os.symlink('*/site-packages/mmf_setup/_data/config_files/cocalc/mrconfig', '$TESTTMP/.mrconfig') (glob)
  Symlink $TESTTMP/.hgrc exists.
  os.remove('$TESTTMP/.hgrc')
  os.symlink('*/site-packages/mmf_setup/_data/config_files/cocalc/hgrc', '$TESTTMP/.hgrc') (glob)
  Symlink $TESTTMP/.inputrc exists.
  os.remove('$TESTTMP/.inputrc')
  os.symlink('*/site-packages/mmf_setup/_data/config_files/cocalc/inputrc', '$TESTTMP/.inputrc') (glob)
  Symlink $TESTTMP/.hgignore exists.
  os.remove('$TESTTMP/.hgignore')
  os.symlink('*/site-packages/mmf_setup/_data/config_files/cocalc/hgignore', '$TESTTMP/.hgignore') (glob)
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
  $ ls -aF "$HOME"
  ./
  ../
  .bash_aliases@
  .bash_aliases.bak
  .bashrc@
  .hgignore@
  .hgrc@
  .inputrc@
  .local/
  .mrconfig@
  .pdbrc@
  * (glob)
