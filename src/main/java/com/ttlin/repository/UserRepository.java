package com.ttlin.repository;

import com.ttlin.pojo.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface UserRepository extends JpaRepository<User, Long> {
    Optional<User> findByOpenid(String openId);
}
