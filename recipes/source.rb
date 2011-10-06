#
# Cookbook Name:: git
# Recipe:: source
#
# Copyright 2011, Fletcher Nichol
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

cache_dir       = Chef::Config[:file_cache_path]
install_prefix  = node['git']['source']['prefix']
tar_url         = node['git']['source']['tar_url']
tar_checksum    = node['git']['source']['tar_checksum']
tar_file        = "git-#{node['git']['source']['version']}.tar.gz"
tar_dir         = tar_file.sub(/\.tar\.gz$/, '')

Array(node['git']['source']['pkgs']).each { |pkg| package pkg }

remote_file "#{cache_dir}/#{tar_file}" do
  source    tar_url
  checksum  tar_checksum
  mode      "0644"
end

execute "Extract #{tar_file}" do
  cwd       cache_dir
  command   <<-COMMAND
    mkdir #{tar_dir} && tar zxf #{tar_file} -C #{tar_dir} --strip-components 1
  COMMAND

  creates   "#{cache_dir}/#{tar_dir}"
end

execute "Build #{tar_dir.split('/').last}" do
  cwd       "#{cache_dir}/#{tar_dir}"
  command   %{make prefix=#{install_prefix} install}

  creates   "#{install_prefix}/bin/git"
end
