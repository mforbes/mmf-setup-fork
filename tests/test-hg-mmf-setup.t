The help message:

  $ mmf_setup -h
  usage: mmf_setup cocalc [options] OR mmf_setup -v [options] OR source mmf_setup [options]
  
  The first invocation will setup cocalc.com projects:
  
     mmf_setup cocalc [options]
  
  Additional options are passed to mmf_initial_setup.  For more info run
  
     mmf_initial_setup -h
  
  The second invocation will show which environmental variables will be set:
  
     mmf_setup -v [options]
  
  The third invocation will actually set this in your shell by running mmf_setup_bash.py:
  
     source mmf_setup [options]   OR . mmf_setup [options]
  
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
  [1]

Try calling it without sourcing:

  $ mmf_setup -H
  Error: mmf_setup must be sourced. Run 'source mmf_setup' or '. mmf_setup' instead of 'mmf_setup'
  
  usage: mmf_setup cocalc [options] OR mmf_setup -v [options] OR source mmf_setup [options]
  
  The first invocation will setup cocalc.com projects:
  
     mmf_setup cocalc [options]
  
  Additional options are passed to mmf_initial_setup.  For more info run
  
     mmf_initial_setup -h
  
  The second invocation will show which environmental variables will be set:
  
     mmf_setup -v [options]
  
  The third invocation will actually set this in your shell by running mmf_setup_bash.py:
  
     source mmf_setup [options]   OR . mmf_setup [options]
  
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
