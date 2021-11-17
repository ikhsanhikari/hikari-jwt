/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package id.hikari.core.endpoint;

import id.hikari.core.dto.ResponseDTO;
import id.hikari.core.service.GeneralSettingService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 *
 * @author admin
 */
@RestController
@RequestMapping("/setting")
public class GeneralSettingEndPoint {
    
    @Autowired
    private GeneralSettingService generalSettingService;
    
    @GetMapping("/all")
    public ResponseDTO findAll(){
        return generalSettingService.findAll();
    }
}
