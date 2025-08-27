package com.example.api_service_todolist.user;



import com.example.api_service_todolist.repository.UserRepository;

import jakarta.validation.ConstraintValidator;
import jakarta.validation.ConstraintValidatorContext;

import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;


@Component


public class UniqueEmailValidator implements ConstraintValidator<UniqueEmail, String> {



    //private  static UserRepository staticAproposRepository;

    private static UserRepository staticUserRepository;



    @Autowired
    public void setUserRepository(UserRepository userRepository) {
        UniqueEmailValidator.staticUserRepository = userRepository;
    }


    @Override
    public boolean isValid(String email, ConstraintValidatorContext context) {
        if (email == null) return true; // @NotBlank gère déjà ça
        return !staticUserRepository.existsByEmail(email) ;

    }
}
