---
layout: post
title:  "使用Nginx结合Jekyll搭建静态博客"
date:   2013-12-13 18:24:52
categories: jekyll
---


简单介绍一下Jekyll，是一个采用Ruby开发的一个静态博客引擎，非常的轻量级和简洁，原生支持markdown语法，个人感觉也适用于wiki类应用。配合disquz插件或国内的友言等，也可实现评论功能。

## **环境准备**

- 单独的服务器或虚拟机或vps
- CentOS
- Ruby
- RubyGem

## **安装**
执行如下的命令后，即可在服务器上运行一个jekyll站点，内部的WebServer采用Ruby的Webrick，默认端口为4000，可通过http://yourdomain:4000来进行浏览。

{% highlight bash %}
~ $ gem install jekyll
~ $ jekyll new jekyll_site
~ $ cd jekyll_site
~ $ jekyll serve
{% endhighlight %}

因为Jekyll产生的都是静态html文件，因此也可采用其他WebServer，例如：Nginx、Apache等。

### 配置Nginx

关键配置截图如下：

![20131213160522.jpg](C:/Users/1/Desktop/20131213160522.jpg "")

## **快速上手**

### 目录结构
在正式开始写博客之前，需要先了解一下Jekyll的基本目录结构。

- _layouts

    公共模板文件目录，例如头尾、需要调用的样式和脚本等。
- _posts

    所有的文章都需要放在此目录下，支持markdown格式的源文件。
- _site

    Jekyll生成的网页文件目录，纯静态，因此也可用其他WebServer把站点根目录指向此目录来使用其他WebServer。
- css

    样式文件存放处。
- index.html

    首页模板，可使用Jekyll变量。
- _config.yml

    网站的各种配置信息。

### 发布文章

只需把你的markdown源文件拷贝到_posts目录即可，也可结合git来进行管理。
然后执行以下命令：（需要进入到Jekyll根目录下）

{% highlight bash %}
~ $ jekyll build
{% endhighlight %}

执行完后，会将markdown源文件转换为html文档。

> 注意：需要在markdown源文件中添加jekyll头信息。并且markdown源文件的命令必须符合格式：2013-12-12-title

{% highlight yaml %}
---
layout: post
title:  "Advanced Ruby String Tips"
date:   2013-12-12 18:24:52
categories: ruby
---
{% endhighlight %}

title即页面的title信息，categories即文件目录，用空格分开代表多级目录。上面的头信息可代表如下的url：`http://yourdomain/ruby/2013/12/12/title.html`


## **参考**

- [官方网站](http://www.jekyllrb.com/)
- [Jekyll官网中国镜像](http://jekyllcn.com/ "Jekyll官网中国镜像")
- [项目源码](https://github.com/mojombo/jekyll)