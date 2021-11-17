/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package id.hikari.core.service.impl;

import id.hikari.core.dto.ResponseDTO;
import id.hikari.core.dto.Status;
import id.hikari.core.model.GeneralSetting;
import id.hikari.core.repository.GeneralSettingRepository;
import id.hikari.core.service.GeneralSettingService;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 *
 * @author admin
 */
@Service
public class GeneralSettingServiceImpl implements GeneralSettingService{

    @Autowired
    private GeneralSettingRepository generalSettingRepository;
    
    @Override
    public ResponseDTO findAll() {
        List<GeneralSetting> gen = generalSettingRepository.findAll();
        return new ResponseDTO(gen, Status.Success);
    }
    
} 
