/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package id.hikari.core.service;

import id.hikari.core.dto.CourseLevel;
import id.hikari.core.dto.CourseType;
import id.hikari.core.dto.ResponseDTO;
import id.hikari.core.model.QuizPatterns;
import java.util.List;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author admin
 */
public interface QuestionService {

    void generateQuestion(HttpServletResponse response, String outputFileName, String generateId);

    public void downloadExcel(HttpServletResponse response, String outputFileName) throws Exception;

    ResponseDTO findAll();

    ResponseDTO findById(Long id);

    ResponseDTO save(QuizPatterns patterns);

    ResponseDTO findAllByCourse(CourseLevel level, CourseType type);

    ResponseDTO findAllByID(List<Long> id, boolean isExercise, Long settingId);
}
