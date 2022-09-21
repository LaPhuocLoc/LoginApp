package com.laloc.userlogin.database;

import com.laloc.userlogin.models.User;
import com.laloc.userlogin.repository.UserRepository;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.CommandLineRunner;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;


@Configuration

public class Database {
    private static final Logger logger = LoggerFactory.getLogger(Database.class);

    @Bean
    CommandLineRunner initDatabase(UserRepository userRepository) {
        return new CommandLineRunner() {
            @Override
            public void run(String... args) throws Exception {
                User user1 = new User("laloc173", "8913552113haha", "La Phuoc Loc");
                User user2 = new User("tsusura173", "123456789", "La Loc");
                logger.info("insert data: " + userRepository.save(user1));
                logger.info("insert data: " + userRepository.save(user2));
            }
        };
    }
}
