
NAME 
====

git_committer - automated git commits to local and remote repositories.

USE CASES
=========

* Automatic backup of server's configuration and/or frequently changed directory;

* Background commits of working directories for user(s) not requiring familiarity with version control systems;

* git based backup of data directories, etc.

DESCRIPTION
===========

* Read configuration file `config/git_committer.yml`

* Use branch (sub-tree) in configuration tree corresponding to current host (hostname returned by uname -n command)

* For every user in host's sub-tree can be specified one or more repositories for committing

Configuration
-------------

Each repository configuration contains attributes:

- :directory - working directory, i.e. local git repository location. Must exist and contain initiated .git directory;

- :remote - alias for remote repository. Remote repository must exist and alias must be created by git remote command. If not specified, defaults to 'origin'.

- :branch - git remote branch to do commit into. Defaults to 'master' if not specified in configuration;

- :message - commit comment as specified by -m parameter to git commit command;

- :identity - full path to SSH private key file used for committing to remote repository.

USAGE
===== 

````
  ./git_committer [push]
````


Crontabs
---------

Pus something similar to the below into crontab:

````
  */30 * * * * git_committer
  35 01 * * *  git_committer push
````

This will run local commits every half hour and push to remote once a day at 01:35am.

Sudo
----

All command run through sudo, user running `git_committer` command must have configuration to execute it without password (NOPASSWD: option in sudoers file).

Command line options
--------------------

Currently supported only one positional parameter `push` or `commit`. If none provided then assume `commit`. `commit` - does commit to local repository, `push` - pushes to remote branch.

Error reporting
----------------

Most of the configuration errors or missing configurations are ignored silently.

For example, if current host is not configured to run any commits, then script exits with 0 status without any message. This allows pushing same configuration and crontab to multiple hosts and avoiding cron errors from not configured hosts.

Local git repository, SSH key file, git branch all must exist, SSH key file should have proper permissions. Script doe not check for SSH key permissions and will fail to run if it's not OK.

See also
========

Simple Chef cookbook is provided together with this script which will install automatically simplified configuration - single user on single host.

Author
======

Dmytro Kovalov, dmytro.kovalov@gmail.com

May, 2011

