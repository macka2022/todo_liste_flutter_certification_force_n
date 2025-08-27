package com.example.api_service_todolist.repository;

import com.example.api_service_todolist.entity.Utilisateur;
import org.apache.catalina.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface UserRepository  extends JpaRepository<Utilisateur, Long> {
    boolean existsByEmail(String email);
}
