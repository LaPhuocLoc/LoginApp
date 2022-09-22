package com.laloc.userlogin.controllers;

import com.laloc.userlogin.models.ResponseObject;
import com.laloc.userlogin.models.User;
import com.laloc.userlogin.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/api/user")
public class UserController {
    @Autowired
    private UserRepository userRepository;

    // get list all users
    @GetMapping("")
    List<User> getAllUsers() {
        return userRepository.findAll();
    }

    // get user detail
    @GetMapping("/{userid}")
    ResponseEntity<ResponseObject> findById(@PathVariable Long userid) {
        Optional<User> foundUser = userRepository.findById(userid);
        return foundUser.isPresent() ?
                ResponseEntity.ok(new ResponseObject("ok", "Query user successfully", foundUser)) :
                ResponseEntity.ok(new ResponseObject("failed", "User not found by userid = " + userid, ""));
    }

    // register
    @PostMapping("/register")
    ResponseEntity<ResponseObject> userRegister(@RequestBody User newUser) {
        // 2 usernames must not have the same name!
//        Optional<User> foundUser = userRepository.findByUsername(newUser.getUsername().trim());
        if (userRepository.existsByUsername(newUser.getUsername())) {
            return ResponseEntity.status(HttpStatus.NOT_IMPLEMENTED).body(
                    new ResponseObject("failed", "Username already exists", "")
            );
        }
        return ResponseEntity.ok(
                new ResponseObject("ok", "register successfully", userRepository.save(newUser))
        );
    }

    // login
    @PostMapping("/login")
    ResponseEntity<ResponseObject> userLogin(
            @RequestParam("username") String username,
            @RequestParam("password") String password) {
        Optional<User> foundUser = userRepository.findByUsernameAndPassword(username, password);
        return foundUser.map(user -> ResponseEntity.ok(
                new ResponseObject("ok", "login successfully", user.getId())
        )).orElseGet(() -> ResponseEntity.status(HttpStatus.NOT_FOUND).body(
                new ResponseObject("failed", "Wrong username or password", "")
        ));
    }
}
