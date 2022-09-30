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
import id.hikari.core.model.JawabanLatihanUser;
import id.hikari.core.model.QuestionBank;
import id.hikari.core.repository.JawabanLatihanUserRepository;
import id.hikari.core.repository.QuestionBankRepository;
import id.hikari.core.service.QuestionBankService;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.stream.Collectors;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

/**
 *
 * @author admin
 */
@RequiredArgsConstructor
@Service
public class QuestionBankServiceImpl implements QuestionBankService {

    private final QuestionBankRepository questionBankRepository;

    private final JawabanLatihanUserRepository jawabanLatihanUserRepository;

    @Override
    public ResponseDTO findByGenerateId(String generateId) {
        List<QuestionBank> list = questionBankRepository.findAllByGenerateId(generateId);
        Collections.shuffle(list);
        return new ResponseDTO(list, Status.Success);
    }

    @Override
    public ResponseDTO findByIdAndGenerateId(List<AnswerDTO> listAnswer, Integer settingId) {
        int result = 0;
        List<AnswerResponseDTO> answerResponse = new ArrayList<>();
        for (AnswerDTO answerDTO : listAnswer) {
            QuestionBank questionBank = questionBankRepository.findDistinctFirstByIdAndGenerateId(answerDTO.getId(), answerDTO.getGenerateId());
            AnswerResponseDTO ardto = new AnswerResponseDTO();
            ardto.setId(questionBank.getId());
            ardto.setGenerateId(questionBank.getGenerateId());
            ardto.setRightAnswer(questionBank.getAnswer());
            if (answerDTO.getAnswer() != null && !answerDTO.getAnswer().isEmpty()  ) {
                if (answerDTO.getAnswer().trim().equals(questionBank.getAnswer())) {
                    result+=1;
                    ardto.setResult("right");
                } else {
                    ardto.setResult("wrong");
                }
            }else{
                 ardto.setResult("not answered");
            }
            answerResponse.add(ardto);
            questionBank.setUserAnswer(answerDTO.getAnswer());
            questionBankRepository.save(questionBank);
        }

        String join = String.join(",", listAnswer.stream().map(item ->
                "("+item.getId()+". "+item.getAnswer()+")"
        ).collect(Collectors.toList()));

        jawabanLatihanUserRepository.save(
                JawabanLatihanUser.builder()
                        .username(listAnswer.get(0).getUsername())
                        .answer(join)
                        .generateId(listAnswer.get(0).getGenerateId())
                        .result(result)
                        .totalSoal(listAnswer.size())
                        .settingId(settingId)
                        .build()
        );

        return new ResponseDTO(answerResponse, Status.Success);
    }

}
