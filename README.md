Description
===========

This is simple cookbook to deploy `git_committer` script and to create configuration for github commits. Deploy configuration file for git_committer and crontab entries.

At the current time cookbook supports only single local user configuration deployment. While `git_committer` script supports multiple users on multiple hosts configuration, such advanced configurations must be configured manually. See [git_committer documentation](git_committer/GIT_COMMITTER.md) for reference.

Usage
============

Add it to your librarian `Cheffile` as:

````ruby
cookbook 'git_committer',
   :git => 'git@github.com:dmytro/git_committer.git'
````

Dependencies
-----------

`git_committer` cookbook relies on [github_keys](http://github.com:dmytro/github_keys.git) cookbook for creating and  deployment of ssh keys to Github.

UNIX local user name and SSH identity file is configured in `github_keys` cookbook. Only attributed described below are configured in this cookbook.


Attributes
==========

* `git_committer/directory`  -- Local repository directory

* `git_committer/install_as`   --  UNIX user to install and run git_committer

* `git_committer/install_to` --
   Directory to install `git_committer`. Sub-directory is created under `git_committer/install_as` home directory


