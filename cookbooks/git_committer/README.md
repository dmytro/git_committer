Description
===========

Deploys git_committer and creates configuration. Deploy configuration
file for git_committer and crontab entries.

Usage
============

Copy cookbooks/git_committer directory to chef-solo/site-cookbooks,
edit file files/default/git_committer.yml and run deploy.sh script.

Attributes
==========

git_committer/repo
  git_committer repository on github for deployment

git_committer/user
  UNIX user to install and run git_committer

git_committer/dirname
  
  Directory to install git_committer. Sub-directory is created under
  git_committer/user home directory.

