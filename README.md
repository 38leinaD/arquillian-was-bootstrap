# Arquillian WAS 9 Bootstrap

Building and using the [arquillian-container-was](https://github.com/arquillian/arquillian-container-was) adapter can be hard when never done before.
There are a few things you have to know:

* It is "build it yourself". So, there are no artifacts on maven-central. It has to be built on your system before you can use it.
* It requires libraries/jars from Websphere itself to be compiled.
* It requires libraries/jars from Websphere to be run as part of an arquillian test.
* These libraries as well are not on maven-central.
* JUnit, when running the arquillian test, needs to be run with the IBM JRE coming with Websphere.

This respository is a self-contained package that you can use to get the arquillian-was-adapater running with Websphere 9.
For this, you will need:

* Docker
* Linux-based environment

## How does it work?

This package will use the [offical WAS 9 Developer Edition docker image](https://hub.docker.com/r/ibmcom/websphere-traditional/) to...

* Build the [arquillian-container-was](https://github.com/arquillian/arquillian-container-was) and deploy the generated jars to your local maven cache (by mounting your .m2 folder in the docker container)
* Installing required jars from the Websphere installation to your local maven cache
* Copy the IBM JRE out of the docker container to your system as the JUnit tests need to be run with this JRE

## Steps

Run `./run.sh` in one terminal. Monitor the output for

```
Add this to your build.gradle!
******************************************************
test {
    executable ="/home/daniel/junk/arquillian-was/ibmjava/bin/java"
}
******************************************************
```

Copy this snippet and paste it into helloworld/build.gradle.
Now wait for `WSVR0001I: Server server1 open for e-business`.

In a different terminal, now run `./gradlew test` on the `helloworld` project to test if the arquillian-container works.