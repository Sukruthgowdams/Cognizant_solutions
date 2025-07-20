package com.example.loan;

import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/loan")
public class LoanController {
    @GetMapping("/{id}")
    public String getLoan(@PathVariable String id) {
        return "Loan details for ID: " + id;
    }
}
