---
layout: post
title: "OpenWRT Running in VirtualBox"
date: 2015-11-19 18:07
comments: true
categories: OpenWRT
---
#在VirtualBox里运行OpenWRT

在OpenWRT编译的时候，要选`vdi`格式输出，这样直接就有了VirtualBox的镜像了。

先在VBox里添加网络：
VirtualBox > Settings > Network > Add

完成后有个叫`vboxnet0`的网络，IP类似`192.168.56.1`。

然后在VirtualBox里新建，选Linux 32bit。然后disk选择那个vdi文件。

<!-- more -->
最重要的添加两个网上，一个用来上网，一个用来跟本地机器联局域网。网卡都选`PCnet-PCI II`，类型分别选`NAT`和`Host-only`，局域网选之前创建的`vboxnet0`。

## 上网
启动完要按下回车才能看到提示符。一开始是没有网络的，先修改下root密码：

	passwd 


在`/etc/config/network`把`wan`部分改成像以下的：

	config interface 'wan'
        option ifname 'eth0'
        option proto 'dhcp'

之后`/etc/init.d/network restart`重启网络生效。
 
 之后应该就可以上网了， `ping 114.114.114.114`， 现在没有配DNS，还不能用域名来PING。
 
 把/etc/resolv.conf改成以下内容：
 
 		search lan
		nameserver 114.114.114.114
		
		
用`ping baidu.com`试下：

	root@OpenWrt:~# ping baidu.com
	PING baidu.com : 56 data bytes
	64 bytes from 180.149.132.47: seq=0 ttl=63 time=42.094 ms
	64 bytes from 180.149.132.47: seq=1 ttl=63 time=40.834 ms
	64 bytes from 180.149.132.47: seq=2 ttl=63 time=41.735 ms


## 本地局域网
修改`/etc/config/network`里的`wan`部分：

	config interface 'lan'
        option ifname 'eth1'
        option proto 'static'
        option netmask '255.255.255.0'
        option ipaddr '192.168.56.12'
        
之后`/etc/init.d/network restart`重启网络生效。


这时通过`ssh root@192.168.56.12`登陆虚拟机。

在浏览器里也应该可以通过`http://192.168.56.12`打开路由配置界面


###Reference
* [SSH between Mac OS X host and Virtual Box guest](https://gist.github.com/wacko/5577187)
* [OpenWRT in VirtualBox](http://ediy.com.my/index.php/blog/item/31-openwrt-in-virtualbox)
* [OpenWRT in Virtualbox](http://hoverbear.org/2014/11/23/openwrt-in-virtualbox/)
