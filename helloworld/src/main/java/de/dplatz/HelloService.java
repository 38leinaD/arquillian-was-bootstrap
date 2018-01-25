package de.dplatz;

import javax.ejb.Stateless;

@Stateless
public class HelloService {
    public String sayHelloTo(String name) {
        return String.format("Hello %s!", name);
    }
}