#!/bin/bash

export WAS9_HOME=${WAS9_HOME:-/opt/IBM/WebSphere/AppServer}
export JAVA_HOME=${JAVA_HOME:-/opt/IBM/WebSphere/AppServer/java/8.0}

cd arquillian-container-was
# Build arquillian-was-adapater and deploy to local maven-repo
mvn clean install -pl was-remote-9 -am -Pwercker

# Also deploy required libs from WAS to local maven-repo
mvn install:install-file -Dfile=/opt/IBM/WebSphere/AppServer/java/8.0/jre/lib/ibmorb.jar -DgroupId=com.ibm -DartifactId=ibmorb -Dversion=1.0 -Dpackaging=jar
mvn install:install-file -Dfile=/opt/IBM/WebSphere/AppServer/runtimes/com.ibm.ws.admin.client.forJython21_9.0.jar -DgroupId=com.ibm -DartifactId=com.ibm.ws.admin.client.forJython21_9.0 -Dversion=1.0 -Dpackaging=jar
mvn install:install-file -Dfile=/opt/IBM/WebSphere/AppServer/deploytool/itp/plugins/com.ibm.websphere.v85.core_1.0.100.v20141119_2034/wasJars/com.ibm.ws.orb_8.5.0.jar -DgroupId=com.ibm -DartifactId=com.ibm.ws.orb_8.5.0 -Dversion=1.0 -Dpackaging=jar
