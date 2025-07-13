package com.example.jwt;

import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import org.springframework.web.bind.annotation.*;

import java.util.Date;

@RestController
@RequestMapping("/auth")
public class AuthController {

    private final String SECRET_KEY = "secret";

    @PostMapping("/login")
    public String login(@RequestBody User user) {
        if ("admin".equals(user.getUsername()) && "password".equals(user.getPassword())) {
            return Jwts.builder()
                    .setSubject(user.getUsername())
                    .setIssuedAt(new Date())
                    .setExpiration(new Date(System.currentTimeMillis() + 600000)) // 10 min
                    .signWith(SignatureAlgorithm.HS256, SECRET_KEY)
                    .compact();
        } else {
            return "Invalid credentials";
        }
    }
}
