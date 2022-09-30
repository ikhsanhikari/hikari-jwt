/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package id.hikari.core.repository;

import id.hikari.core.model.JawabanLatihanUser;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

/**
 * @author admin
 */
public interface JawabanLatihanUserRepository extends JpaRepository<JawabanLatihanUser, Long> {

    List<JawabanLatihanUser> findAllByUsername(String username);
}
