#
# Cookbook Name:: build-essential
# Attributes:: default
#
# Copyright 2008-2012, Chef Software, Inc.
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

default['build-essential']['compile_time'] = false

# Solaris 10 omnibus-build-essential package information
default['build-essential']['solaris10_package_url'] = 'https://chef-releng.s3.amazonaws.com/omnibus/build-essential'
default['build-essential']['solaris10_package_version'] = '0.0.4-1'
