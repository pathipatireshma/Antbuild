#!/bin/bash

if [ -f /etc/systemd/system/tomcat.service ]
   then echo "***tomcat exists"
   else 
	echo "tomcat needs to be installed"
fi
