import os

import nox

# Do not use anything installed in the site local directory (~/.local for example) which
# might have been installed by pip install --user.  These can prevent the install here
# from pulling in the correct packages, thereby mucking up tests later on.
# See https://stackoverflow.com/a/51640558/1088938
os.environ["PYTHONNOUSERSITE"] = "1"

# By default, we only execute the conda tests because the others required various python
# interpreters to be installed.  The other tests can be run, e.g., with `nox -s test` if
# desired.
nox.options.sessions = ["test_conda"]


@nox.session(python=["3.6", "3.7", "3.8", "3.9"])
def test(session):
    session.install(".[test]")
    session.run("make", "test-cocalc", external=True)


@nox.session(venv_backend="conda", python=["3.6", "3.7", "3.8", "3.9"])
def test_conda(session):
    session.install(".[test]")
    session.run("make", "test", external=True)
