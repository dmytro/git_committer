maintainer       "Dmytro Kovalov"
maintainer_email "dmytro.kovalov@gmail.com"
license          "Apache 2.0"
description      "Installs/Configures git_commiter"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.0.1"


attribute "git_committer/repo",
  :description => 'git_committer repository on github for deployment',
  :type => "string",
  :required => "recommended"

attribute "git_committer/user",
  :description => 'UNIX user to install and run git_committer',
  :type => "string",
  :required => "recommended"

attribute "git_committer/dirname",
  :description => 'Directory to install git_committer. Sub-directory is created under git_committer/user home directory.',
  :type => "string",
  :required => "recommended"
