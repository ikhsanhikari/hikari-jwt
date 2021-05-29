/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package id.hikari.core.repository;

import id.hikari.core.model.User;
import javax.transaction.Transactional;
import org.springframework.data.jpa.repository.JpaRepository;

/**
 *
 * @author admin
 */
public interface UserRepository extends JpaRepository<User, Integer> {

    public User findByUsername(String username);

    public boolean existsByUsername(String username);

    @Transactional
    public void deleteByUsername(String username);

}
