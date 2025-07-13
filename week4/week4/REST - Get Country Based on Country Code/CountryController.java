package com.example.countrycode;

import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("/api/country")
public class CountryController {

    private static final Map<String, String> countryData = new HashMap<>();

    static {
        countryData.put("IN", "India");
        countryData.put("US", "United States");
        countryData.put("JP", "Japan");
        countryData.put("FR", "France");
    }

    @GetMapping("/{code}")
    public String getCountryByCode(@PathVariable String code) {
        return countryData.getOrDefault(code.toUpperCase(), "Country Not Found");
    }
}
