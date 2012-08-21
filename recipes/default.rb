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

if node[:git_committer][:node][:config]
  template "#{path}/config/git_committer.yml" do 
    source "git_committer.yml.erb"
    variables({ :users => node[:git_committer][:node][:config] })
  end
  #
  # Githup keys setup. Only when config is provided, not when using
  # config file from recipe
  #
  node[:git_committer][:node][:config].each do |user,config|
    if config.has_key? :github

      if config[:github][:create_key]

        identity   = File.expand_path config[:identity]
        url        = 'https://api.github.com/user/keys'
        
        directory  File.expand_path("~#{user}/.ssh") do
          owner user
          group user
          mode 0700
          action :create
          recursive true
        end

        execute :ssh_keygen do
          require 'date'
          key_title = "Git committer key #{user}@#{node.hostname} - #{DateTime.now.to_s}"
          user  user
          group user
          command <<-EOCMD
             ssh-keygen -f #{identity} -t dsa -N ''
             KEY=$(cat #{identity}.pub)
             curl -X POST -L --user #{config[:github][:user]}:#{config[:github][:password]} #{url} --data "{\\"title\\":\\"#{key_title}\\", \\"key\\":\\"$KEY\\"}"
EOCMD
          creates "#{identity}"
          action :run
        end

      end

    end # :github
  end

else
  cookbook_file "#{path}/config/git_committer.yml" do 
    owner node[:git_committer][:user]
    source "git_committer.yml"

  end
end
