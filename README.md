# dircmd
Automating repetitive tasks one directory at a time.

# Installation

    $ curl --location https://github.com/dircmd/dircmd/raw/master/bin/dircmd-install | sudo bash -x

# Usage

After installation you will find a new _**~/.dircmd**_ directory. Inside that directory some example files from the [Helloworld](https://github.com/dircmd/dircmd/tree/master/examples/helloworld) example have been installed.

Log out, and log back in and you'll get a nice new welcome message each time you go to your $HOME directory. Just remove/edit the files in _**~/.dircmd/entry**_ and _**~/.dircmd/exit**_ to your needs.

You can create a _**.dircmd**_ directory anywhere on your system and the _entry/exit_ files will be used by _any_ user to traverse that location.
