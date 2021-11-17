/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package id.hikari.core.endpoint;

import id.hikari.core.dto.AnswerDTO;
import id.hikari.core.dto.ResponseDTO;
import id.hikari.core.service.QuestionBankService;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

/**
 *
 * @author admin
 */
@RestController
@RequestMapping("/bank")
public class QuestionBankEndPoint {
    
    @Autowired
    private QuestionBankService questionBankService;
    
    @GetMapping("/findByGenerateId")
    public ResponseDTO findByGenerateId(@RequestParam("generateId") String generateId){
        return questionBankService.findByGenerateId(generateId);
    }
    
    @PostMapping("/answer")
    public ResponseDTO findByGenerateIdAndId(@RequestBody List<AnswerDTO> listAnswer){
        return questionBankService.findByIdAndGenerateId(listAnswer);
    }
}
