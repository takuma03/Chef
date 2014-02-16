#
# Cookbook Name:: redhat
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
rpm_package "kernel-firmware-2.6.32-431.5.1.el6.noarch.rpm" do
              action :install
	      source "/home/vagrant/kernel-firmware-2.6.32-431.5.1.el6.noarch.rpm"
end

rpm_package "kernel-2.6.32-431.5.1.el6.x86_64.rpm" do
              action :install
              source "/home/vagrant/kernel-2.6.32-431.5.1.el6.x86_64.rpm"
end

rpm_package "kernel-headers-2.6.32-431.5.1.el6.x86_64.rpm" do
              action :install
              source "/home/vagrant/kernel-headers-2.6.32-431.5.1.el6.x86_64.rpm"
end
 
rpm_package "perf-2.6.32-431.5.1.el6.x86_64.rpm" do
              action :install
              source "/home/vagrant/perf-2.6.32-431.5.1.el6.x86_64.rpm"          
end


#6 パッケージのインストール
#6.1 パッケージ自動更新サービスの停止
service "rhnsd" do
              action [:disable, :stop]
end
 
service "rhsmcertd" do
              action [:disable, :stop]
end

#6.2 メディアのマウント
#mount "/mnt/cdrom" do
#              device "/dev/cdrom"
#end
  
#6.3yumクライアント設定
template "rheldvd.repo" do
              path "/etc/yum.repos.d/rheldvd.repo"
              source "rheldvd.repo.erb"
end

#6.4 キャッシュの削除
execute "clean-yum-cache" do
              command "yum clean all"
end
 
#6.5必要パッケージのインストール
#execute "install-package" do
#              command "インストールパッケージ外だし"
#end        
#
#yum_package "インストール対象パッケージ" do
#              action :install
#end

#6.6 yumの無効化
template "rheldvd.repo" do
              path "/etc/yum.repos.d/rheldvd.repo"
              source "rheldvd_disable.repo.erb"
end

#7.1ネットワーク設定
service "NetworkManager" do
              action[:stop :disable]
end
 
sevice "iptables" do
              action :stop
end
 
template "config" do
              path "/etc/selinux/config"
              source "config.erb"
end
 
template "network" do
              path "/etc/sysconfig/network"
              sorce "network.erb"
end
 
template "nsswitch.conf" do
              path "/etc/nsswich.conf"
              sorce "nsswitch.conf.erb"
end
 
template "hosts" do
              path "/etc/hosts"
              sorce "hosts.erb"
end
 
template "ifcfg-bond0" do
              path "/etc/sysconfig/network-scripts/ifcfg-bond0"
              sorce "ifcfg-bond0.erb"
end
 
template "ifcfg-eth0" do
              path "/etc/sysconfig/network-scripts/ifcfg-eth0"
              sorce "ifcfg-eth0.erb"
end
 
template "bonding.conf" do
              path "/etc/modprobe.d/bonding.conf
              sorce "bonding.conf.erb"
end
 
template "disable_ipv6.conf" do
              path "/etc/modprobe.d/disable_ipv6.conf"
              sorce "disable_ipv6.conf.erb"
end
 
service "network" do
              action: restart
end
