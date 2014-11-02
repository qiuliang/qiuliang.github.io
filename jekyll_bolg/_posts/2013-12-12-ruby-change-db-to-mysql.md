---
layout: post
title:  "【Ruby on Rails】切换数据库到MySQL"
date:   2013-12-12 18:24:52
categories: ruby
tags: ruby
excerpt : "根据官方指导手册，建立的rails程序默认使用SQLite3作为数据源，接下来的内容描述了如何将数据源改变为MySQL。"
---


> 根据官方指导手册，建立的rails程序默认使用SQLite3作为数据源，接下来的内容描述了如何将数据源改变为MySQL。

## 操作步骤

1. 修改database.yml。
		
		development:
  		adapter: mysql2
  		encoding: utf8
  		database: blog
  		pool: 5
  		username: dbuser
  		password: '123456'
  		socket: /tmp/mysql.sock

2. 修改Gemfile

		gem 'mysql2'

在使用scaffold的时候很可能会遇到错误：

###### Can't connect to local MySQL server through socket

出现这个错误的原因可能有很多，我的解决方案如下：
	
	ln -s /var/run/mysqld/mysqld.sock /tmp/mysql.sock

但该问题会在系统重启后再次出现，彻底解决方案：

	修改database.yml：socket: /var/run/mysqld/mysqld.sock
