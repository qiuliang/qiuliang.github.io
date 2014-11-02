---
layout: post
title:  "【Ruby on Rails】学习使用generator"
date:   2013-12-12 18:24:52
categories: ruby
tags: ruby
excerpt : "scaffold基本使用命令，rails generate scaffold Post id:integer title:string"
---

## scaffold基本使用命令

{% highlight bash %}
	rails generate scaffold Post id:integer title:string
{% endhighlight %}
执行完这条命令后，会自动生成model、view、controller的代码。

## FAQ
1. **给model增加一个属性**
	
	例如：需要给post这个model增加一个属性“tag”，可执行如下的命令：

        {% highlight bash %}
		rails g migration AddTagsToPost tag:string
        {% endhighlight %}

执行完成后，会自动在db/migrate目录下生成相应的迁移文件，其中命令行里面的Add[Tags]To[Post]是约定好的格式，其中Tags代表字段名称，Post代表表的名称。然后使用`rake db:migrate`命令使修改同步到数据库上。

