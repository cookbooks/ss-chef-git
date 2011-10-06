#
# Cookbook Name:: git
# Attributes:: source
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

default['git']['source']['version'] = "1.7.6.1"
default['git']['source']['prefix']  = "/usr/local"

default['git']['source']['tar_url']   =
  "https://github.com/git/git/tarball/v#{node['git']['source']['version']}"
default['git']['source']['tar_checksum']   =
  "50664be795fe40970cd890384144368cfd63035bd5b9faccdad4ccbec6b82898"

case platform
when "suse"
  node.set['git']['source']['pkgs'] = %w{curl-devel python-devel}
else
  node.set['git']['source']['pkgs'] = []
end
