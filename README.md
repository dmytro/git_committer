
NAME 
====

git_committer - automated git commits to local and remote repositories.

This distribution includes executable script, configuration samples and Chef cookbook for deployment. If you want to use only `git_committer` script without Chef deployment, grab it from `files/default` directory.

For instructions of how to use cookbook please see section Cookbook configuration below.

USE CASES
=========

* Automatic backup of server's configuration and/or frequently changed directory;

* Background commits of working directories for user(s) not requiring familiarity with version control systems;

* git based backup of data directories, etc. 

DESCRIPTION
===========

* `git_committer` configuration file is `config/git_committer.yml` relative to the directory where binary is installed

* Each host is configured separately in configuration from sub-tree corresponding to host's hostname -- as returned by `uname -n` command).

  * Every user in host's sub-tree can have one or more repositories

  * Each repository configuration contains attributes:

    - `:directory` - working directory, i.e. local git repository location. Must exist and contain initiated .git directory;

    - `:message` - commit comment as specified by -m parameter to git commit command;

    - :identity - full path to SSH private key file used for committing to remote repository.

USAGE
=====

  ./git_committer [push]

* Optional argument `push` specifies that push to git `origin` repository be made.

* Without `push` simply does commit to local repository.

Crontabs
--------

To automate commits periodically and send commits to git origin put something similar to the below into crontab:

````
  */30 * * * * git_committer
  35 01 * * *  git_committer push
````

This will run local commits every half hour and push to remote once a day at 01:35am.

Sudo
----

All commands in `git_committer` are executed using sudo.  `git_committer` user must have configuration to execute script without password (NOPASSWD: option in sudoers file).

Command line options
--------------------

Currently supported only one positional parameter 'push' or 'commit'. If none provided then 'commit' is assumed. 'commit' - commits to local repository, 'push' - pushes to remote branch.

Error reporting
---------------

Most of the configuration errors or missing configurations are ignored silently.

For example, if current host is not configured to run any commits, then script exits with 0 status without any message. This allows pushing same configuration and crontab to multiple hosts and avoiding cron errors from not configured hosts.

Local git repository, SSH key file, git branch all must exist, SSH key file should have proper permissions. Script doe not check for SSH key permissions and will fail to run if it's not OK.

Cookbook configuration
----------------------

Cookbook deploys git_committer, configuration file for git_committer and creates necessary crontab entries.

### Cookbook Attributes


* `git_committer[:user]` -- UNIX user to install and run git_committer

* `git_committer[:dirname]` -- Directory to install git_committer. This sub-directory is created under git_committer[:user] home directory.

* `git_committer[:node][:config]` - node configuration for automatic user's config creation. See attributes/default.rb comments for details. If this configuration present it will be used as main config, if not then provided YAML files in `files/default/git_committer.yml` will be used.

  Note: if this automatic configuration section is present, git committer will attempt to create and upload SSH keys to github account.

  Node configuration hash has following structure:

````  
       { :ubuntu =>                               # `git_committer[:user]`
       # TODO: attribute cleanups directory <-> dirname
         { :directory => '/home/ubuntu/test',     # `git_committer[:dirname]` 
           :identity => "~/.ssh/git_committer",   # SSH key file name
           
           #
           # Github configuration
           # 
           :github => {
           
                   :repository  => 'git@github.com:user/repo',
                   :user => 'github-user', 
                   :password => 'SECRET',
                   :create_key => true,
                   :branch => 'auto-commit-branch',
                   :setup_branch => true,
           }         
        }
     }
````


Author
------

Dmytro Kovalov, dmytro.kovalov@gmail.com

May,Aug 2012

LocalWords:  committer config

