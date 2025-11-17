package org.example.user_manager.service;

import org.example.user_manager.entity.User;
import org.example.user_manager.repository.IUserRepository;
import org.example.user_manager.repository.UserRepository;

import java.sql.SQLException;
import java.util.List;

public class UserService implements IUserService{
    IUserRepository userRepository = new UserRepository();
    @Override
    public boolean insertUser(User user) throws SQLException {
    return userRepository.insertUser(user);
    }

    @Override
    public User selectUser(int id) {
        return userRepository.selectUser(id);
    }

    @Override
    public List<User> selectAllUsers() {
        return userRepository.selectAllUsers();
    }

    @Override
    public boolean deleteUser(int id) throws SQLException {
        return userRepository.deleteUser(id);
    }

    @Override
    public boolean updateUser(User user) throws SQLException {
        return userRepository.updateUser(user);
    }
}
