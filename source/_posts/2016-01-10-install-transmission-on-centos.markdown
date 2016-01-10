---
layout: post
title: "Centos安装Transimission及远程管理"
date: 2016-01-10 17:55
comments: true
categories: 
---

### 服务器


	yum install epel-release -y
	yum -y install transmission transmission-daemon
	
	service transmission-daemon start
	
浏览器打开`http://server_ip:9091`，应该看到403 Forbidden，就是已经安排并成功启动了，但还没有权限。

<!-- more -->

{% img center /images/transmission_forbidden.png   %}

这时要修改一下配置文件

	#=> service transmission-daemon stop
	#=> find / -name settings.json
	#=> /var/lib/transmission/.config/transmission-daemon/settings.json
	
修改这个文件里的几个值：

	"rpc-authentication-required": true, # 改为true要求验证，否则所有人都可以看到
	"rpc-bind-address": "0.0.0.0",
	"rpc-enabled": true,
	"rpc-password": "xxxxx", 			# 密码， 这里改完，start后它自己会把它改成哈希值，记住你自己改的密码即可。
	"rpc-username": "foo",  			# 用户名
	"rpc-whitelist-enabled": false,	# 这里要改为false

	service transmission-daemon start
	
{% img center /images/transmission_admin.png  %}
###本地
Mac上直接可以

	brew install transmission
	git clone https://github.com/fagga/transmission-remote-cli.git
	
	# 创建并保存配置文件
	transmission-remote-cli -c username:password@server_ip:9091 --create-config
	
	# 完成后可以通过这样加bt文件到服务器
	transmission-remote-cli xxx.torrent
	
	# 直接在cmd里看服务器上的任务
	transmission-remote-cli
	
	
{% img center https://github.com/fagga/transmission-remote-cli/raw/master/screenshots/screenshot-mainfull-v1.3.png  %}

	

##Reference
[Torrent Guide – Install Transmission Client to RHEL / CentOS 6
](http://www.filesharingguides.com/install-transmission-torrent-client-rhel-centos-6/)