The help message:

  $ mmf_setup -h
  usage: mmf_setup cocalc [options] OR mmf_setup -v [options]
  
  The first invocation will setup cocalc.com projects.  Use the -v option
  to perform a dry run to see what would be done.
  
     mmf_setup cocalc [-v] [packages]
  
  Additional packages such as black, jupytext, mercurial, hg-git, and hg-evolve can
  be added if needed.  As of 16 Aug 2022, most of these are provided by CoCalc, but
  might be needed on a Docker instance:
  
      for app in mercurial black jupytext pdm poetry; do
          pipx install $app
      done
      pipx inject mercurial hg-git hg-evolve
      curl micro.mamba.pm/install.sh | bash
  
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

Try calling it without sourcing:

  $ mmf_setup -H
  usage: mmf_setup cocalc [options] OR mmf_setup -v [options]
  
  The first invocation will setup cocalc.com projects.  Use the -v option
  to perform a dry run to see what would be done.
  
     mmf_setup cocalc [-v] [packages]
  
  Additional packages such as black, jupytext, mercurial, hg-git, and hg-evolve can
  be added if needed.  As of 16 Aug 2022, most of these are provided by CoCalc, but
  might be needed on a Docker instance:
  
      for app in mercurial black jupytext pdm poetry; do
          pipx install $app
      done
      pipx inject mercurial hg-git hg-evolve
      curl micro.mamba.pm/install.sh | bash
  
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

Now try sourcing.  This should raise the deprecation warning

  $ . mmf_setup
  WARNING: mmf_setup Deprecation - Please do not source mmf_setup in future.
  Replace '. mmf_setup ' with the following in your .bash_aliases file:
  
      eval "$(mmf_setup )"
  
