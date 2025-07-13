package com.example.springcore.model;

public class Country {
    private String name;
    private String capital;
    private String currency;
    private long population;
    
    // Default constructor
    public Country() {}
    
    // Parameterized constructor
    public Country(String name, String capital, String currency, long population) {
        this.name = name;
        this.capital = capital;
        this.currency = currency;
        this.population = population;
    }
    
    // Getters and Setters
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    
    public String getCapital() { return capital; }
    public void setCapital(String capital) { this.capital = capital; }
    
    public String getCurrency() { return currency; }
    public void setCurrency(String currency) { this.currency = currency; }
    
    public long getPopulation() { return population; }
    public void setPopulation(long population) { this.population = population; }
    
    @Override
    public String toString() {
        return "Country{" +
                "name='" + name + '\'' +
                ", capital='" + capital + '\'' +
                ", currency='" + currency + '\'' +
                ", population=" + population +
                '}';
    }
}