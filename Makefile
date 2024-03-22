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
	cd tests && $(PYTHON) run-tests.py --with-hg=$(HG) -fd --tmpdir=_tmp test-cocalc*.t $(TESTFLAGS)

test-py:
	pytest

test-hg:
	cd tests && $(PYTHON) run-tests.py --with-hg=$(HG) test-hg*.t $(TESTFLAGS)

test: test-hg test-py

test-all: test-cocalc test

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
	-rm README_CHANGES.*
	-rm Notes.html
	-rm -rf tests/_tmp
	-rm -rf build
	find . -type f -name "*.py[ocd]" -delete
	find . -type f -name ".coverage" -delete
	find . -type d -name "__pycache__" -exec rm -rf "{}" +
	find . -type d -name "_build" -exec rm -rf "{}" +
	find . -type d -name "htmlcov" -exec rm -rf "{}" +
	find . -type d -name ".ipynb_checkpoints" -exec rm -rf "{}" +


.PHONY: help test-cocalc test-cocalc-debug test-hg test-py test test-all clean auto
