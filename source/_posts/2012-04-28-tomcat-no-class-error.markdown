---
layout: post
title: "tomcat No Class Error"
date: 2012-04-28 11:37
comments: true
categories: 
---

If you have the same problem in deploying your webapp with ant, in Tomcat 7. Then copy the following jars to your lib directory of ant:
    catalina-ant.jar
	tomcat-coyote.jar
	tomcat-util.jar
	tomcat-juli.jar
	
That's it! You will be fine:)
