# Simple makefile with common rules.

makefiles_dir = .makefiles
include $(makefiles_dir)/rst2html.mk

# This gets the version of python that mercurial uses
PYTHON=$(shell hg debuginstall -T'{pythonexe}')
HG=$(shell which hg)
#MMF_SETUP=$(shell pwd)/src/mmf_setup
#MMF_SETUP=$(shell python -c "import os.path, mmf_setup;print(os.path.dirname(mmf_setup.__file__))")
TESTFLAGS=--shell bash
nbinit.py: make_nbinit.py src/mmf_setup/_data/nbthemes/mmf.*
	python make_nbinit.py

help:
	@echo 'Commonly used make targets:'
	@echo '  test - run all tests in the automatic test suite'

test-cocalc:
	cd tests && $(PYTHON) run-tests.py --with-hg=$(HG) test-cocalc*.t $(TESTFLAGS)

test-cocalc-debug:
	rm -rf tests/_tmp
	cd tests && $(PYTHON) run-tests.py -fd --tmpdir=_tmp --with-hg=$(HG) test-cocalc*.t $(TESTFLAGS)

test-py:
	pytest

test-hg:
	cd tests && $(PYTHON) run-tests.py --with-hg=$(HG) test-hg*.t $(TESTFLAGS)

test: test-cocalc test-hg test-py

%.html: %.md
	pandoc $< -o $@ --standalone

auto:
	pandoc $< -o $@ --standalone && open -g -a Safari $@
	fswatch -e ".*\.html" -o . | while read num ; do pandoc $< -o $@ --standalone && open -g -a Safari $@; done

%.html: %.rst
	rst2html5.py $< > $@

README_CHANGES.md: README.md CHANGES.md
	cat $^ > $@

clean:
	-rm -rf .nox src/mmf_setup.egg-info
	-rm -rf tests/.testtimes
	-rm -rf .pytest_cache
	-rm -rf mmf_setup.egg-info
	-find . -name "*.pyc" -delete
	-find . -name "*.pyo" -delete
	-find . -name "__pycache__" -type d -delete
	-rm README_CHANGES.*
	-rm Notes.html
	-rm -rf tests/_tmp

.PHONY: help test-cocalc test-cocalc-debug test-hg test-py test clean auto
