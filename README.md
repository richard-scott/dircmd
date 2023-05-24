![dircmd logo](https://raw.githubusercontent.com/dircmd/dircmd/master/images/tools.png)

# dircmd


**_dircmd_** can save you time when you need to repeat the same commands time and time again. For example, when programming in Python you may need to enable your Virtual Environment (virtualenv) each time you start writing or testing code. For example, you may repeatidly use these commands at the start of a session:

    cd ~/my_next_great_application
    source env/bin/activate

Great, you are now setup to start coding. What if you want to quickly do something else in another Python environment. For example, lets say you need to install a pip package in an old application codebase. You would need to do the following:

    deactivate
    cd ~/my_previous_great_application
    source env/bin/activate
    pip install <something>
    deactivate
    cd ~/my_next_great_application
    source env/bin/activate

Now you can carry on where you left off, but what if you could reduce your typing down to just 42% of that. With _**dircmd**_ helping you can reduce this to just 3 commands:

    cd ~/my_previous_great_application
    pip install <something>
    cd ~/my_next_great_application

## Installation

    curl -L https://git.io/get_dircmd.sh | bash

### Usage

After installation you will find a new _**~/.dircmd**_ directory with some [example](https://github.com/dircmd/dircmd/tree/master/examples/helloworld) files.

### Activation

You can activate the utility right now with the following command, or just log out and log back in again.

    source /etc/profile.d/dircmd.sh

Once you activate the utility you will get a nice new welcome message each time you go to your $HOME directory. Edit _**~/.dircmd/entry**_ and _**~/.dircmd/exit**_ to your needs and everytime you go to $HOME they will be loaded.

You can create a _**.dircmd**_ directory anywhere on your system and then add _entry/exit_ files that will be used by _any_ user to traverse that location.
