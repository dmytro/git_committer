#
# Cookbook Name:: git_committer
# Recipe:: default
#
# Copyright 2012, Dmytro Kovalov
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
path = File.expand_path("~#{node[:git_committer][:install_as]}/#{node[:git_committer][:install_to]}")

directory path do
  owner node[:git_committer][:install_as]
  mode  '0755'
  action :create
  recursive true
end

directory "#{path}/config" do
  owner node[:git_committer][:install_as]
  mode  '0755'
  action :create
end

cookbook_file "#{path}/git_committer"
cookbook_file "#{path}/config/git_committer.sample.yml"


# Randomize push'es so that they not all start at the same time, also
# ensure that push does not happen at the same time as commit.
cron "push" do 
  hour rand(24)
  minute (rand(55)+5).to_s 
  user node[:git_committer][:install_as]
  command "#{path}/git_committer push"
end

cron "commit" do 
  hour "*"
  minute "0"
  user node[:git_committer][:install_as]
  command "#{path}/git_committer"
end


template "#{path}/config/git_committer.yml" do 
  source "git_committer.yml.erb"
  #
  # Name of the user for installing github keys and committer is
  # taken form github_keys cookbook.
  # 
  variables( { :user => node[:github_keys][:local][:user],
               :identity => "~/.ssh/#{node[:github_keys][:local][:identity]}",
               :directory => node[:git_committer][:directory]
               
             } )
end

include_recipe "github_keys"
