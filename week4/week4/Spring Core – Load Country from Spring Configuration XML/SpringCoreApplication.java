package com.example.springcore;

import com.example.springcore.model.Country;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@SpringBootApplication
public class SpringCoreApplication {
    
    public static void main(String[] args) {
        SpringApplication.run(SpringCoreApplication.class, args);
        
        // Load Spring XML configuration
        ApplicationContext context = new ClassPathXmlApplicationContext("beans.xml");
        
        // Get country beans
        Country india = (Country) context.getBean("india");
        Country usa = (Country) context.getBean("usa");
        Country japan = (Country) context.getBean("japan");
        
        System.out.println("Countries loaded from XML configuration:");
        System.out.println(india);
        System.out.println(usa);
        System.out.println(japan);
    }
}

@RestController
class CountryController {
    
    @GetMapping("/countries")
    public String getCountries() {
        ApplicationContext context = new ClassPathXmlApplicationContext("beans.xml");
        
        Country india = (Country) context.getBean("india");
        Country usa = (Country) context.getBean("usa");
        Country japan = (Country) context.getBean("japan");
        
        return "Countries: " + india.getName() + ", " + usa.getName() + ", " + japan.getName();
    }
    
    @GetMapping("/country/india")
    public Country getIndia() {
        ApplicationContext context = new ClassPathXmlApplicationContext("beans.xml");
        return (Country) context.getBean("india");
    }
}