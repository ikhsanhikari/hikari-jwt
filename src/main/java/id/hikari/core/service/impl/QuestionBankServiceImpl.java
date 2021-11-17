/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package id.hikari.core.service.impl;

import id.hikari.core.dto.AnswerDTO;
import id.hikari.core.dto.AnswerResponseDTO;
import id.hikari.core.dto.ResponseDTO;
import id.hikari.core.dto.Status;
import id.hikari.core.model.QuestionBank;
import id.hikari.core.repository.QuestionBankRepository;
import id.hikari.core.service.QuestionBankService;
import java.util.ArrayList;
import java.util.Collections;
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
        Collections.shuffle(list);
        return new ResponseDTO(list, Status.Success);
    }

    @Override
    public ResponseDTO findByIdAndGenerateId(List<AnswerDTO> listAnswer) {
        List<AnswerResponseDTO> answerResponse = new ArrayList<>();
        for (AnswerDTO answerDTO : listAnswer) {
            QuestionBank questionBank = questionBankRepository.findDistinctFirstByIdAndGenerateId(answerDTO.getId(), answerDTO.getGenerateId());
            AnswerResponseDTO ardto = new AnswerResponseDTO();
            ardto.setId(questionBank.getId());
            ardto.setGenerateId(questionBank.getGenerateId());
            ardto.setRightAnswer(questionBank.getAnswer());
            if (answerDTO.getAnswer() != null && !answerDTO.getAnswer().isEmpty()  ) {
                if (answerDTO.getAnswer().trim().equals(questionBank.getAnswer())) {
                    ardto.setResult("true");
                } else {
                    ardto.setResult("false");
                }
            }else{
                 ardto.setResult("not answered");
            }
            answerResponse.add(ardto);
        }
        return new ResponseDTO(answerResponse, Status.Success);
    }

}
