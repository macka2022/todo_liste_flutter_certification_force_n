package com.example.api_service_todolist.dao.daoImplement;

import com.example.api_service_todolist.dao.UserService;
import com.example.api_service_todolist.entity.Utilisateur;
import com.example.api_service_todolist.repository.UserRepository;
import com.example.api_service_todolist.user.ApiExecptionHandler;
import org.springframework.stereotype.Service;

import java.util.List;
@Service
public class ImplementUserService implements UserService {

private final UserRepository userRepository;

    public ImplementUserService(UserRepository userRepository) {
        this.userRepository = userRepository;
    }

    @Override
    public Utilisateur CreateUser(Utilisateur user) {
        boolean existsByEmail = userRepository.existsByEmail(user.getEmail());
        if (existsByEmail) {
            throw new ApiExecptionHandler.UserAlreadyExistsException("Un utilisateur avec cet email existe déjà.");
        }
        return userRepository.save(user);

    }

    @Override
    public List<Utilisateur> listUser() {
        return  userRepository.findAll();
    }

    @Override
    public Utilisateur findUserById(Long id) {
        return userRepository.findById(id)
                .orElseThrow(() -> new ApiExecptionHandler.UserNotFoundException("Utilisateur avec id " + id + " non trouvée"));
    }

    @Override
    public Utilisateur update(Utilisateur user) {
        if (!userRepository.existsById(   user.getId())) {
            throw new ApiExecptionHandler.UserNotFoundException("Certificat ajoute avec id " + user.getId() + " n'existe pas");
        }
        return userRepository.save(user);
    }


}
