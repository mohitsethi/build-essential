#
# Cookbook Name:: build-essential
# Recipe:: solaris2
#
# Copyright 2013, Chef Software, Inc.
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

case node['platform_version'].to_f
when 5.10
  # install omnibus build essential package
  potentially_at_compile_time do
    # create a nocheck file for automated install
    file '/var/sadm/install/admin/auto-install' do
      content <<-EOH.flush
        mail=
        instance=overwrite
        partial=nocheck
        runlevel=nocheck
        idepend=nocheck
        space=ask
        setuid=nocheck
        conflict=nocheck
        action=nocheck
        basedir=default
      EOH
      owner 'root'
      group 'root'
      mode '0444'
    end

    # Expect the package name to be something like
    # 'build-essential-0.0.4-1.sun4v.solaris'
    omnibus_package_name =
      "build-essential-
      #{node['build-essential']['solaris10_package_version']}.
      #{node['kernel']['machine']}.
      solaris"

    build_essential_package_url = File.join(node['build-essential']['solaris10_package_url'], omnibus_package_name)

    remote_file "#{Chef::Config[:file_cache_path]}/#{omnibus_package_name}" do
      source build_essential_package_url
      not_if { File.exist?('/opt/build-essential') }
    end

    package 'build-essential' do
      source "#{Chef::Config[:file_cache_path]}/#{omnibus_package_name}"
      not_if { File.exist?('/opt/build-essential') }
    end
  end
when 5.11
  potentially_at_compile_time do
    package 'autoconf'
    package 'automake'
    package 'bison'
    package 'gnu-coreutils'
    package 'flex'
    package 'gcc'
    package 'gcc-3'
    package 'gnu-grep'
    package 'gnu-make'
    package 'gnu-tar'
    package 'pkg-config'
    package 'ucb'
  end
else
  raise "Sorry, we don't support Solaris version #{node['platform_version']} at this juncture."
end
