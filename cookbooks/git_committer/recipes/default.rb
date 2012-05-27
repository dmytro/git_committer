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
path = File.expand_path("~#{node[:git_committer][:user]}/#{node[:git_committer][:dirname]}")


directory path do
  owner node[:git_committer][:user]
  mode  '0755'
  action :create
end

git path do
  repo node[:git_committer][:repo]
  action :sync
  reference "master"
end

cron "push" do 
  hour "0"
  minute "10"
  user node[:git_committer][:user]
  command "#{path}/git_committer push"
end

cron "commit" do 
  hour "*"
  minute "0"
  user node[:git_committer][:user]
  command "#{path}/git_committer"
end

cookbook_file "#{path}/config/git_committer.yml" do 
  owner node[:git_committer][:user]
  source "git_committer.yml"
end



