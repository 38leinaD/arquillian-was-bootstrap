package de.dplatz;

import javax.inject.Inject;

import org.hamcrest.CoreMatchers;
import org.jboss.arquillian.container.test.api.Deployment;
import org.jboss.arquillian.junit.Arquillian;
import org.jboss.shrinkwrap.api.ShrinkWrap;
import org.jboss.shrinkwrap.api.asset.EmptyAsset;
import org.jboss.shrinkwrap.api.spec.WebArchive;
import org.junit.Assert;
import org.junit.Test;
import org.junit.runner.RunWith;


@RunWith(Arquillian.class)
public class HelloServiceIT {

    @Inject
    HelloService service;

    @Deployment  
    public static WebArchive createDeployment() {  
        WebArchive war = ShrinkWrap.create(WebArchive.class, "test.war")  
                .addClass(HelloService.class)  
                .addAsManifestResource(EmptyAsset.INSTANCE, "beans.xml");  
  
        return war;  
    }  

    @Test
    public void name() {
        Assert.assertThat(service.sayHelloTo("Duke"), CoreMatchers.is("Hello Duke!"));
    }

}