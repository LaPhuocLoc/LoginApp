package com.laloc.userlogin.repository;

import com.laloc.userlogin.models.User;
import org.springframework.data.jpa.repository.JpaRepository;

// import java.util.List;
import java.util.Optional;

public interface UserRepository extends JpaRepository<User, Long> {
    Optional<User> findByUsername(String username);
    Optional<User> findByUsernameAndPassword(String username, String password);
    Boolean existsByUsername(String username);
}
