# dircmd
Automating repetitive tasks one directory at a time.

This utility can save you time when you need to repeat the same commands time and time again. For example, when programming in Python you may need to enable your Virtual Environment (virtualenv) each time you start writing code. For example, you may repeatidly use these commands at the start of a session:

    $ cd ~/my_next_great_application
    $ source env/bin/activate

Great, you are now setup to start coding... but what if you want to quickly do something else in Python somewhere on the system outside of your Virtual Environment. 
you need to disable your Virtual Environment each time with this command:

    $ deactivate
    $ cd ~/my_previous_great_application
    $ source env/bin/activate
    $ pip install <something>
    $ deactivate
    $ cd ~/my_next_great_application
    $ source env/bin/activate

Now you can carry on where you left off, but what if you could do this:

    $ cd ~/my_next_great_application
    $ pip install <something>
    $ cd ~/my_previous_great_application


This is where _**dircmd**_ steps on to help.

# Installation

    $ curl --location https://github.com/dircmd/dircmd/raw/master/bin/dircmd-installer | sudo bash

# Usage

After installation you will find a new _**~/.dircmd**_ directory. Inside that directory some example files from the [Helloworld](https://github.com/dircmd/dircmd/tree/master/examples/helloworld) example have been installed.

Log out, and log back in and you'll get a nice new welcome message each time you go to your $HOME directory. Just remove/edit the files in _**~/.dircmd/entry**_ and _**~/.dircmd/exit**_ to your needs.

You can create a _**.dircmd**_ directory anywhere on your system and the _entry/exit_ files will be used by _any_ user to traverse that location.
