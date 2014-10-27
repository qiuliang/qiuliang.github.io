---
layout: post
title:  "Spring MVC + Mybatis + MySQL CRUD Demo"
date:   2014-7-4
categories: java
tags: java spring mybatis
---


本文档结合`Spring MVC`、`Mybatis`、`MySQL`，说明如何实现一个简单的数据库单表CRUD操作。开发工具使用集成了spring mvc的eclipse（Spring Tool Suite，简称STS）。

[TOC]

##基础环境说明

- Mac OS X `10.9.4`
- jre version `1.8.0_05`
- java sdk `1.8.0_05`
- STS `3.5.1`
- maven `3.2.2`

以上环境安装配置好后，就可以开始demo程序了。

###MySQL建表语句

{% highlight sql %}
CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL,
  `age` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=big5
{% endhighlight %}

##Step 1 新建spring mvc项目

使用STS新建一个spring mvc project，建立好项目后，一个基本的spring mvc web项目已经搭建好，我们只需要在这之上配置好相关的beans，以及编写CRUD相关的代码。

可以注意一下项目中的`web.xml`、`servlet-context.xml`，STS已经帮我们把跟spring相关的基本配置项配置好。

例如：web.xml中定义了请求由spring接管，以及IOC相关的配置文件名称。

{% highlight xml %}
<!-- Processes application requests -->
	<servlet>
		<servlet-name>appServlet</servlet-name>
		<servlet-class>org.springframework.web.servlet.DispatcherServlet</servlet-class>
		<init-param>
			<param-name>contextConfigLocation</param-name>
            <!-- IOC配置文件 -->
			<param-value>/WEB-INF/spring/appServlet/servlet-context.xml</param-value>
		</init-param>
		<load-on-startup>1</load-on-startup>
	</servlet>
{% endhighlight %}

##Step 2 使用maven加载所需的jar包

如果使用独立安装的maven程序，需要在eclipse中指定maven的路径：

Preferences -- Maven -- Installations

例如，我的路径是：/usr/local/maven/maven3.2.2

maven配置好后，就可以在pom文件中添加相关的依赖项了，需要添加的相关依赖配置如下：

{% highlight xml %}
<dependency>
    <groupId>org.springframework</groupId>
    <artifactId>spring-context-support</artifactId>
    <version>${org.springframework-version}</version>
</dependency>
<dependency>
    <groupId>org.springframework</groupId>
    <artifactId>spring-jdbc</artifactId>
    <version>${org.springframework-version}</version>
</dependency>
<!-- mybatis -->
<dependency>
    <groupId>mysql</groupId>
    <artifactId>mysql-connector-java</artifactId>
    <version>5.1.31</version>
</dependency>
<dependency>
    <groupId>commons-dbcp</groupId>
    <artifactId>commons-dbcp</artifactId>
    <version>1.4</version>
</dependency>
<dependency>
    <groupId>org.mybatis</groupId>
    <artifactId>mybatis-spring</artifactId>
    <version>1.2.2</version>
</dependency>
<dependency>
    <groupId>org.mybatis</groupId>
    <artifactId>mybatis</artifactId>
    <version>3.2.7</version>
</dependency>
{% endhighlight %}

> 需要注意跟spring相关的jar包的版本问题

保存pom文件后会自动根据配置文件下载所需的jar包。

##Step 3 主要配置示例

###bean相关配置
在servlet-context.xml配置文件中增加如下的bean，注意schema格式

数据源：
{% highlight xml %}
<!--数据源：-->
<beans:bean id="dataSource" class="org.apache.commons.dbcp.BasicDataSource" lazy-init="default" autowire="default"  ]]>
      <beans:property name="driverClassName" value="com.mysql.jdbc.Driver"]]></beans:property]]>
      <beans:property name="url" value="jdbc:mysql://127.0.0.1:3306/remember" ]]></beans:property]]>
      <beans:property name="username" value="root"]]></beans:property]]>
      <beans:property name="password" value="123456"]]></beans:property]]>
      
   </beans:bean]]>
{% endhighlight %}

Mybatis Sql Session配置：
> 由spring接管的mybatis session，configLocation配置的value要和实际的mybatis配置文件一致。

{% highlight xml %}
   <beans:bean id="sqlSessionFactory" class="org.mybatis.spring.SqlSessionFactoryBean"]]>
      <beans:property name="configLocation" value="classpath:springdemo-mybatis-config.xml"]]></beans:property]]>
      <beans:property name="dataSource" ref="dataSource" />
   </beans:bean]]> 
 
   <beans:bean class="org.mybatis.spring.mapper.MapperScannerConfigurer"]]>
      <beans:property name="basePackage" value="ql.mac.springdemo" />
   </beans:bean]]>
{% endhighlight %}

###Mybatis主配置文件

springdemo-mybatis-config.xml配置文件示例如下：

{% highlight xml %}
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE configuration
    PUBLIC "-//mybatis.org//DTD Config 3.0//EN"
    "http://mybatis.org/dtd/mybatis-3-config.dtd"]]>
 
<configuration]]>
   <settings]]>
      <setting name="cacheEnabled" value="true" />
      <setting name="lazyLoadingEnabled" value="true" />
      <setting name="aggressiveLazyLoading" value="false" /> 
      <setting name="multipleResultSetsEnabled" value="true" />
      <setting name="useColumnLabel" value="true" />
      <setting name="useGeneratedKeys" value="false" />
      <setting name="autoMappingBehavior" value="PARTIAL" />
      <setting name="defaultExecutorType" value="SIMPLE" />
      <setting name="defaultStatementTimeout" value="25000" />
      <setting name="safeRowBoundsEnabled" value="false" />
      <setting name="mapUnderscoreToCamelCase" value="false" />
      <setting name="localCacheScope" value="SESSION" />
      <setting name="jdbcTypeForNull" value="OTHER" />
      <setting name="lazyLoadTriggerMethods" value="equals,clone,hashCode,toString" />
   </settings]]>
   <typeAliases]]>
      <typeAlias alias="User" type="ql.mac.springdemo.model.User" />
   </typeAliases]]>
   <mappers]]>
      <mapper resource="mapper/user.xml" />
   </mappers]]>
</configuration]]>
{% endhighlight %}

###mapper文件
例如：mapper/user.xml

{% highlight xml %}
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN"   "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="ql.mac.springdemo.da.UserMapper"> 
       
    
    <select id="get" parameterType="int"  resultType="User">
      select * from user where ID=#{id};
    </select>
     
    <insert id="insert" parameterType="User" >
      insert into user values (#{id}, #{name}, #{age});
    </insert>
    
    <update id="update" parameterType="User" >
      update user set name=#{name},age=#{age} where id=#{id};
    </update>
  
</mapper>
{% endhighlight %}

##Step 4 主要代码

###定义Model
User.java

{% highlight java %}
package ql.mac.springdemo.model;

public class User {
	private int id;
	private String name;
	private int age;

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public int getAge() {
		return age;
	}

	public void setAge(int age) {
		this.age = age;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}
}
{% endhighlight %}

###定义CRUD操作接口
UserMapper.java

{% highlight java %}
package ql.mac.springdemo.da;

import ql.mac.springdemo.model.User;

public interface UserMapper {
	User get(int id);
	void insert(User u);
	void update(User u);
}
{% endhighlight %}

###编写Action

在Controller中增加CRUD相关的action。需要先将数据操作的mapper类注入到controller中，增加代码如下：

{% highlight java %}
@Autowired
private UserMapper _userMapper;
{% endhighlight %}

####get一个数据实体

{% highlight java %}
@RequestMapping(value = "/get/{id}", method = RequestMethod.GET)
public String get(@PathVariable("id") int id, Model model) {

    User u = _userMapper.get(id);
    model.addAttribute("user", u);

    return "user";
}
{% endhighlight %}

注解RequestMapping说明对应的url，以及http method，其中{id}代表URL参数，和action中的参数id对应，同时需要在参数id前增加注解：@PathVariable("id")

这里使用spring内置的model传递参数到view，在页面上可以采用如下语句获取数据实体内容。

{% highlight html %}
<div>
	<p>
		<strong>Id</strong>
		<span>${user.getId()}</span>
	</p>
	<p>
		<strong>Name</strong>
		<span>${user.getName()}</span>
	</p>
	<p>
		<strong>Age</strong>
		<span>${user.getAge()}</span>
	</p>
</div>
{% endhighlight %}

####insert一个数据实体

add的get方法

{% highlight java %}
@RequestMapping(value = "/add", method = RequestMethod.GET )
	public String Insert() {
		return "add";
	}
{% endhighlight %}

add的post方法

{% highlight java %}
@RequestMapping(value = "/add", method = RequestMethod.POST )
@ResponseBody
public String Insert(User u) {
    _userMapper.insert(u);
    return "insert a new user";
}
{% endhighlight %}

对应的view
{% highlight html %}
<form action="" method="post">
	<div>
		<p>
			<input type="text" value="${user.getId()}" name="id" />
		</p>
		<p>
			<strong>Name</strong>
			<input type="text" value="${user.getName()}" name="name" />
		</p>
		<p>
			<strong>Age</strong>
			<input type="text" value="${user.getAge()}" name="age" />
		</p>
	</div>
	
	<div>
		<input type="submit" value="Submit" />
	</div>
</form>
{% endhighlight %}

其他update和delete操作和上面基本类似，至此一个简单的单表CRUD程序已经能run起来了。