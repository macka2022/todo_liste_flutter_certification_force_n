package com.example.api_service_todolist.dao;

import com.example.api_service_todolist.entity.Utilisateur;

import java.util.List;

public interface UserService {
    public Utilisateur CreateUser(Utilisateur user);
    public List<Utilisateur> listUser();
    public Utilisateur findUserById(Long id);
    public Utilisateur update(Utilisateur user);
}
