Auto-update functionality for Ubuntu
====================================

Installation
------------

Execute the file [download_and_install.sh](download_and_install.sh)

It will ask you to add an ssh key to an [github](http://github.com) account. This [github](http://github.com) account should also join one of these groups:

- [Coder Dojo Potsdam - Coders](https://github.com/orgs/CoderDojoPotsdam/teams/coders) to make changes to the projects repository
- [Coder Dojo Potsdam - Computers](https://github.com/orgs/CoderDojoPotsdam/teams/computers) if it should make changes to the software repository and the projects

Usage
-----

The script waits for an internet connection to be made.
On startup this script will automatically

- update the software repository to include the latest required software
- update the [projects repository](https://github.com/CoderDojoPotsdam/projects) in the /home/*/projects folder. This will commit and push projects automatically.
- update the [organize repository](https://github.com/CoderDojoPotsdam/organize) so you can use the logo as a background image. 
- install the software
- update the system

