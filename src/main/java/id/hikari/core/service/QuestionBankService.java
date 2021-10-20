/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package id.hikari.core.service;

import id.hikari.core.dto.ResponseDTO;

/**
 *
 * @author admin
 */
public interface QuestionBankService {
    ResponseDTO findByGenerateId(String generateId);
    
}
