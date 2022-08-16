If you need to debug, the following can be useful

$ type hg
$ hg debuginstall -T'{pythonexe}'
$ $(hg debuginstall -T'{pythonexe}') -m pip list | grep hg
$ $(hg debuginstall -T'{pythonexe}') -m pip list | grep dulwich
dulwich * (glob)

Ensure that we are running without using any spurious packages in ~/.local.  I was
having great diffiulty with random errors when a version of dulwich was installed there
and thus randomly not getting installed by pip.

  $ # echo PYTHONNOUSERSITE="$PYTHONNOUSERSITE"
  $ hg init
  $ touch .hgrc
  $ hg add .hgrc
  $ hg commit -m "Added .hgrc"
  $ hg update
  0 files updated, 0 files merged, 0 files removed, 0 files unresolved

At this point, the lga alias should not be defined.

  $ hg lg
  hg: unknown command 'lg'
  (did you mean log?)
  [10]

We first define this by evaluating mmf_setup:

  $ mmf_setup -v
  # mmf_setup environment:
  export MMF_SETUP="*/site-packages/mmf_setup" (glob)
  export HGRCPATH="${HGRCPATH:-~/.hgrc}:*/site-packages/mmf_setup/_data/hgrc.lga" (glob)
  $ eval "$(mmf_setup -v)"
  $ hg lg
  @  0:d test (1970-01-01)  tip
      Added .hgrc

Our update hook has not yet beed activated.

  $ hg update
  0 files updated, 0 files merged, 0 files removed, 0 files unresolved

Now we do the full activation.

  $ mmf_setup -v -H
  # mmf_setup environment:
  export MMF_SETUP="*/site-packages/mmf_setup" (glob)
  export HGRCPATH="${HGRCPATH:-~/.hgrc}:*/site-packages/mmf_setup/_data/hgrc.full" (glob)
  $ eval "$(mmf_setup -v -H)"
  $ echo y | hg update
  Repository * contains an .hgrc file. (glob)
  Including this in .hg/hgrc is a potential security risk.
  Only do this if you trust the repository.
  
  Include this .hgrc in .hg/hgrc? [yN]
  Adding '%include ../.hgrc' to '.hg/hgrc'
  0 files updated, 0 files merged, 0 files removed, 0 files unresolved
  $ hg lg
  @  0:d test (1970-01-01)  tip
      Added .hgrc

The .hg/hgrc file now includes the local file:

  $ cat .hg/hgrc
  %include ../.hgrc
