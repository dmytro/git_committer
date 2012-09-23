maintainer       "Dmytro Kovalov"
maintainer_email "dmytro.kovalov@gmail.com"
license          "Apache 2.0"
description      "Installs/Configures git_commiter for automated commits to github."
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.0.2"


attribute "git_committer/directory",
  :description => 'Local repository directory',
  :type => "string",
  :required => "recommended"

attribute "git_committer/install_as",
  :description => 'UNIX user to install and run git_committer',
  :type => "string",
  :required => "recommended"

attribute "git_committer/install_to",
  :description => 'Directory to install git_committer. Sub-directory is created under git_committer/install_as home directory.',
  :type => "string",
  :required => "recommended"
