---
layout: post
title:  "ASP.NET MVC 4 小项目开发总结"
date:   2013-12-12 18:24:52
categories: asp.net
tags: mvc
---


项目很小，就是一个企业站的前后台，主要包括新闻模块、产品模块、视频模块、留言。没有什么技术上的难点，大部分就是CRUD操作。开始之前评估开发时间为4天，实际coding时间为3天，debug时间为2天，关于debug时间较长的问题，后面有较为详细的分析。

## 所用技术和工具

- Visual Studio 2012
- ASP.NET MVC 4
- Entify Framework 5
- Sqlite
- Uploadify

## 关于ASP.NET MVC 4

相比MVC 3，个人感觉并没有太大的变化，也许是一些新特性没有用到。最大的感受是开始支持HTML5。


## debug花费时间分析

除开没有后台页面等其他因素，自身原因分析如下：

### 拿到需求后没有进行较为详细的确认

虽然项目需求简单，但有些地方开始时疏于沟通，最终所省掉的时间还是用在了debug上，甚至更多。

### 浏览器兼容性问题

仅在开发阶段使用chrome浏览器，ie系也仅测试ie10，其余未考虑，后续在浏览器兼容性方面的调试花费了较多的时间。

例如如下的问题：

- ie7下jquery.validate报错

	> 将`this.attr("novalidate", "novalidate");` 修改为：
    `if (typeof (Worker) !== "undefined") { this.attr('novalidate', 'novalidate'); }`
- ie7下ckeditor的dialog加载iframe窗口高度不正常问题

	> 尝试了很多网上的解决方案，均不管用，后来使用了一个非常规手段，就是给浏览器加上强制使用ie8模式的meta信息
- ie8下jquery.validate不起作用

	> 版本匹配问题：经测试：jquery-1.8.2 with jquery.validate-1.9正常

### uploadify控件使用不是很熟练

很多api需要现查官方文档，而且官方站点还需翻墙。同时在集成uploadify到ckeditor里面的时候，也花费了较多的时间，主要是用在查官方文档上面。这块写了较多的js代码，在后续浏览器兼容性方面调试也比较麻烦。

- firefox下上传文件出现http error 302

	> 网上大部分的情况是firefox和chrome同时出现此问题，基本都是说session的原因，但我的环境chrome却没有出问题。我的解决方案比较简单，就是对上传文件的后台action取消授权检查。应该还是很session有关，更好的解决方案可查询谷歌。

### Entity Framework sqlite数据源适配问题
主要是开始无法新建sqlite数据源，ef的设计器总是报错，无法通过数据库更新实体等。另外sqlite中文模糊查询问题。

- 设计器报错问题

	> 需要到sqlite官网下载合适的数据源驱动程序
	> [http://system.data.sqlite.org/index.html/doc/trunk/www/downloads.wiki](http://system.data.sqlite.org/index.html/doc/trunk/www/downloads.wiki)
- sqlite中文字符串模糊查询问题

	> 原来使用的方式：dbcontext.Post.Where(t=>t.Name.Contains(s))，对应的sql语句为charindex，改为：list = context.Database.SqlQuery<Product>(string.Format("select * from product where name like '%{0}%'",arcTitle)).AsQueryable();

