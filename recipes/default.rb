#
# Selenium environment for functional test.
#

#
# Java Installation for selenium server.
#
package node[:selenium][:java_package] do
  action :install
  not_if "rpm -q #{node[:selenium][:java_package]}"
end

# selenium server
cookbook_file node[:selenium][:install_to] + '/' + node[:selenium][:jar] do
  source node[:selenium][:jar]
  owner "root"
  group "root"
  mode "0755"
  not_if "test -e " + node[:selenium][:install_to] + '/' + node[:selenium][:jar]
end

link node[:selenium][:prog_path] do
  to node[:selenium][:install_to] + '/' + node[:selenium][:jar]
end

# init.d script
template "/etc/init.d/selenium" do
  source "init.d/selenium.erb"
  owner "root"
  group "root"
  mode "0755"
end

# logrotate
template "/etc/logrotate.d/selenium" do
  source "logrotate.d/selenium.erb"
  owner "root"
  group "root"
  mode "0644"
end


# xorg-x11-server-Xvfb
package "xorg-x11-server-Xvfb" do
  action :install
  not_if "rpm -q xorg-x11-server-Xvfb"
end

template "/etc/init.d/xvfb" do
  source "init.d/xvfb.erb"
  owner "root"
  group "root"
  mode "0755"
end

template "/etc/logrotate.d/xvfb" do
  source "logrotate.d/xvfb.erb"
  owner "root"
  group "root"
  mode "0644"
end

# browser firefox
package "firefox" do
  action :install
  not_if "rpm -q firefox"
end

