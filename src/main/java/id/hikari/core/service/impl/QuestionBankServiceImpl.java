/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package id.hikari.core.service.impl;

import id.hikari.core.dto.ResponseDTO;
import id.hikari.core.dto.Status;
import id.hikari.core.model.QuestionBank;
import id.hikari.core.repository.QuestionBankRepository;
import id.hikari.core.service.QuestionBankService;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 *
 * @author admin
 */
@Service
public class QuestionBankServiceImpl implements QuestionBankService {

    @Autowired
    private QuestionBankRepository questionBankRepository;

    @Override
    public ResponseDTO findByGenerateId(String generateId) {
        List<QuestionBank> list = questionBankRepository.findAllByGenerateId(generateId);
        return new ResponseDTO(list, Status.Success);
    }
    
    

}
