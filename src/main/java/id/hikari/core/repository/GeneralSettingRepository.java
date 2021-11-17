/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package id.hikari.core.repository;

import id.hikari.core.model.GeneralSetting;
import org.springframework.data.jpa.repository.JpaRepository;

/**
 *
 * @author admin
 */
public interface GeneralSettingRepository extends JpaRepository<GeneralSetting, String>{

}
