---
layout: post
title:  "【Ruby on Rails】Advanced Ruby String Tips"
date:   2013-12-12 18:24:52
categories: ruby
tags: ruby
---




`ord`将字符转换为ASCII编码

{% highlight ruby %}
?B.ord
# => 66
{% endhighlight %}

`chr`将ASCII编码转换为字符

{% highlight ruby %}
66.chr
# => B
{% endhighlight %}

`split`将字符串分割为数组

{% highlight ruby %}
"I love Ruby Programming".split(' ')：
# => ["I","love","Ruby","Programming"]
{% endhighlight %}

`split`配合`uniq`后并去重

{% highlight ruby %}
"aabbcc".split('').uniq：
# => ["a","b","c"]
{% endhighlight %}

配合`sort`进行排序，按ASCII编码大小

{% highlight ruby %}
"I love Ruby Programming".split('').uniq.sort
{% endhighlight %}

`scan`从字符串中查找匹配的字符，返回数组

{% highlight ruby %}
"Everybody loves Ruby".scan(/[a-m]/)
# => ["e", "b", "d", "l", "e", "b"]
{% endhighlight %}

`gsub`该函数的作用是使用正则替换掉字符串中匹配的值。变量调用`gsub`方法后，变量本身不改变，如果需要改变，可在方法后加`!`。

{% highlight ruby %}
a = "test1";
b = a.gsub(/\d+/,'a');
print a;
print b;
a.gsub!(/\d+/,'b');
# a => test1
# b => testa
# a => testb
{% endhighlight %}


提取字符串中的数字，并乘以2后替换：

{% highlight ruby %}
"I am 18 years old.".gsub(/\d+/){2*$&.to_i}
# I am 36 years old.
{% endhighlight %}

提取字符串中的单引号和双引号，加上斜杠后替换：

{% highlight ruby %}
str = %q(Ruby said, "Don't you like Ruby"); str.gsub(/['"]/) {'\\'+$&}
# Ruby said, \"Don\'t you like Ruby\"
{% endhighlight %}

重复输出字符串N次：

{% highlight ruby %}
"hello" * 10;
{% endhighlight %}


`capitalize`将字符串首字母大写：

{% highlight ruby %}
"hello".capitalize
# Hello
{% endhighlight %}

`chop`去掉末尾的一个字符：

{% highlight ruby %}
"hello".chop
# hell
{% endhighlight %}

`next`将字符串末尾的一个字符替换为下一个字符，例如“a”替换为“b”，“1”替换为“2”，如果是非字母或数字的字符，则替换前一个。


{% highlight ruby %}
"hello".next
# hellp
{% endhighlight %}

`swapcase`将字符串中的字母大小写反转替换。

{% highlight ruby %}
"Hello".swapcase
# hELLO
{% endhighlight %}

