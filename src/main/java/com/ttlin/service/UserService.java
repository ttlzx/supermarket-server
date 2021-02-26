package com.ttlin.service;

import com.ttlin.pojo.entity.User;
import com.ttlin.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class UserService {

    @Autowired
    private UserRepository userRepository;

    public User getUserById(Long id) {
        return userRepository.findFirstById(id);
    }
}
