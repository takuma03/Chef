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

#6.6yumの無効化
template "rheldvd.repo" do
              path "/etc/yum.repos.d/rheldvd.repo"
              source "rheldvd_disable.repo.erb"
end

#7.1 ネットワーク設定
#service "NetworkManager" do
#              action[:stop, :disable]
#end

service "iptables" do
              action :stop
end 

template "config" do
              path "/etc/selinux/config"
              source "config.erb"
end

template "network" do
              path "/etc/sysconfig/network"
              source "network.erb"
end

template "nsswitch.conf" do
              path "/etc/nsswich.conf"
              source "nsswitch.conf.erb"
end

template "hosts" do
              path "/etc/hosts"
              source "hosts.erb"
end

#template "ifcfg-bond0" do
#              path "/etc/sysconfig/network-scripts/ifcfg-bond0"
#              source "ifcfg-bond0.erb"
#end

#template "ifcfg-eth0" do
#              path "/etc/sysconfig/network-scripts/ifcfg-eth0"
#              source "ifcfg-eth0.erb"
#end

#template "ifcfg-eth1" do
#              path "/etc/sysconfig/network-scripts/ifcfg-eth1"
#              source "ifcfg-eth1.erb"
#end

#template "bonding.conf" do
#              path "/etc/modprobe.d/bonding.conf"
#              source "bonding.conf.erb"
#end

template "disable_ipv6.conf" do
              path "/etc/modprobe.d/disable_ipv6.conf"
              source "disable_ipv6.conf.erb"
end

service "network" do
              action :restart
end

#7.2ユーザ・グループの作成
group "webop" do
              group_name "webop"
              gid 1001
              action :create
end

group "tomcat" do
              group_name "tomcat"
              gid 1002
              action :create
end

group "scpuser" do
              group_name "scpuser"
              gid 1005
              action :create
end
 
group "nopaope" do
              group_name "nopaope"
              gid 2001
              action :create
end
 
group "batchuser" do
              group_name "batcjuser"
              gid 3001
              action :create
end

user "webop" do
	      uid 1001
	      home "/home/webop"
	      shell "/bin/bash"
	      gid 1001
end

user "scpuser" do
	      uid 1005
	      home "/home/scpuser"
	      shell "/bin/bash"
	      gid 1005
end

user "nopaadmin" do
              uid 2001
              home "/home/nopaadmin"
              shell "/bin/bash"
              gid 2001
end

user "nopaope1" do
	      uid 2002
	      home "/home/nopaope1"
              shell "/bin/bash"
	      gid 2001
end

user "batchuser01" do
	      uid 3001
	      home "/home/batchuser01"
	      shell "/bin/bash"
	      gid 3001
end
 
#7.3ユーザー環境定義ファイル設定
template "prfile" do
        path "/etc/profile"
        source "profile.erb"
end
 
template ".bash_profile" do
        path "/root/.bash_profile"
        source ".bash_profile.erb"
end

template ".bash_profile" do
        path "/home/webop/.bash_profile"
        source ".bash_profile_umask.erb"
end

template ".bash_profile" do
	path "/home/nopaadmin/.bash_profile"
        source ".bash_profile_umask.erb"
end

template ".bash_profile" do
        path "/home/nopaope1/.bash_profile"
        source ".bash_profile_umask.erb"
end

#7.4 Upstart設定
template "control-alt-delete.conf" do
	path "/etc/init/control-alt-delete.conf"
	source "control-alt-delete.conf.erb"
end

#7.5 ファイルシステム自動マウント設定
template "/etc/fstab" do
	path "/etc/fstab"
	source "fstab.erb"
end

#7.6カーネルパラメータ設定
template "grub.conf" do
        path "/boot/grub/grub.conf"
        source "grub.conf.erb"
end

template "sysctl.conf" do
        path "/etc/sysctl.conf"
        source "sysctl.conf.erb"
end

execute "mkdir" do
        command "mkdir -p /var/core/core"
        action :run
end
 
execute "chmod" do
        command "chmod 777 /var/core"
        action :run
end

#7.7kdumpの設定
#template "kdump.conf" do
#        path "/etc/kdump.conf"
#        source "kdump.conf.erb"
#end

#7.8functionスクリプト設定
template "functions" do
        path "/etc/init.d/functions"
        source "functions.erb"
end

#7.9リソース制御設定
#template "limit.conf" do
#        path "/etc/security/limit.conf"
#        source "limit.conf.erb"
#end
 
#template "login" do
#              path "/etc/pam.d/login"
#              source "login.erb"
#end

#7.10suコマンド設定
template "su" do
              path "/etc/pam.d/su"
              source "su.erb"
end
 
execute "authconfig" do
              command "authconfig --disablefingerprint --update"
              action :run
end

#7.11NTP設定
#template "ntp.conf" do
#              path "/etc/ntp.conf"
#              source "ntp.conf.erb"
#end
 
#template "ntpd" do
#              path "/etc/sysconfig/ntpd"
#              source "ntpd.erb"
#end
 
#template "ntpdate" do
#              path "/etc/sysconfig/ntpdate"
#              source "ntpdate.erb"
#end

#7.12ログローテーション設定
#ログローテーション個別設定が未完了
template "logrotate.conf" do
              path "/etc/logrotate.conf"
              source "logrotate.conf.erb"
end

#7.13scp設定
#chefでは難しい？
 
#7.14Fibre Channel ドライバ設定（維持管理サーバー（Linux）・DBサーバのみ）
#template "lpfc.conf" do
#              path "/etc/modprobe.d/lpfc.conf"
#              source "lpfc.conf.erb"
#end

#7.15再起動
#execute "reboot" do
#              command "reboot"
#              user "root"
#              action :run
#end

#9.1ログローテーション設定
#template "syslog" do
#              path "/etc/logrotate.d/syslog"
#              source "syslog.erb"
#end
 
#9.2起動サービスの設定
#service "サービス名" do
#              action :diable
#end
 
#9.3ランレベルの設定
#template "inittab" do
#              path "/etc/inittab"
#              source "inittab.erb"
#end
 
#9.4遠隔ログイン設定
#環境定義書に記載がないため未完了
#template "sshd" do
#              path "/etc/pam.d/sshd"
#              source "sshd.erb"
#end
 
#template "access.conf" do
#              path "/etc/security/access.conf"
#              source "access.conf.erb"
#end
 
#template "sshd_config" do
#              path "/etc/ssh/sshd_config"
#              source "sshd_config.erb"
#end
 
#9.5sudoの設定
#visudoコマンドで記入するため未記入
 
#9.6再起動
#execute "reboot" do
#              command "reboot"
#              user "root"
#end

#10.1ログ管理
 
#パーミッション変更
#httpd未インストールのためコメントアウト
#execute "chmod" do
#              command "chmod 755 /var/log/httpd"
#              user "root"
#              action :run
#end
 
#ログ転送先ディレクトリの作成
%w{syslog/nhut01 syslog/nhut02 syslog/nhsm01 syslog/nhlw01 syslog/nhlw02 syslog/nhap01 syslog/nhap02 syslog/nhsr01 syslog/nhdb01 syslog/nhdb02 hinemos/nhut01 hinemos/nhut02 hinemos/nhsm01 hinemos/nhlw01 hinemos/nhlw02 hinemos/nhap01 hinemos/nhap02 hinemos/nhsr01 hinemos/nhdb01 hinemos/nhdb02 ultramonkey/nhlw01 ultramonkey/nhlw02 httpd/nhlw01 httpd/nhlw02 httpd/nhlw01 tomcat/nhap01 tomcat/nhap02 l2sw/nhsm01 postgresql/nhdb01 postgresql/nhdb02}.each do |directory|
              execute "mkdir" do
                            command "mkdir -p /var/log/backup/" + directory
                            user "root"
              end
end
 
%w{syslog/nhut01 syslog/nhut02 syslog/nhsm01 syslog/nhlw01 syslog/nhlw02 syslog/nhap01 syslog/nhap02 syslog/nhsr01 syslog/nhdb01 syslog/nhdb02 hinemos/nhut01 hinemos/nhut02 hinemos/nhsm01 hinemos/nhlw01 hinemos/nhlw02 hinemos/nhap01 hinemos/nhap02 hinemos/nhsr01 hinemos/nhdb01 hinemos/nhdb02 ultramonkey/nhlw01 ultramonkey/nhlw02 httpd/nhlw01 httpd/nhlw02 httpd/nhlw01 tomcat/nhap01 tomcat/nhap02 l2sw/nhsm01 postgresql/nhdb01 postgresql/nhdb02}.each do |directory|
              execute "chown" do
                            command "chown scpuser /var/log/backup/" + directory
                            user "root"
              end
end
