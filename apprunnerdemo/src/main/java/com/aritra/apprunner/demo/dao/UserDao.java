package com.aritra.apprunner.demo.dao;

import com.aritra.apprunner.demo.entity.User;
import java.util.Optional;

public interface UserDao {
    public User findByUsername(String username);
    public void registerUser(String username, String password);
    public Boolean checkCredentialsMatch(String username, String password);
}
