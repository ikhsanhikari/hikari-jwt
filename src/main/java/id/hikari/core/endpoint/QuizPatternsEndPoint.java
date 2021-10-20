/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package id.hikari.core.endpoint;

import id.hikari.core.dto.CourseLevel;
import id.hikari.core.dto.CourseType;
import id.hikari.core.dto.QuestionRequestDTO;
import id.hikari.core.dto.ResponseDTO;
import id.hikari.core.model.QuizPatterns;
import id.hikari.core.service.QuestionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.lang.Nullable;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
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
@RequestMapping(value = "/pattern")
public class QuizPatternsEndPoint {

    @Autowired
    private QuestionService questionService;

    @GetMapping("/all")
    public ResponseDTO allPattern() {
        return questionService.findAll();
    }

    @GetMapping("/{id}")
    public ResponseDTO patternById(@PathVariable("id") Long id) {
        return questionService.findById(id);
    }

    @GetMapping("/findByCourse")
    public ResponseDTO findPatternByCourse(
            @Nullable @RequestParam("level") CourseLevel level,
            @Nullable @RequestParam("type") CourseType type) {
        return questionService.findAllByCourse(level, type);
    }

    @PostMapping("/save")
    public ResponseDTO save(@RequestBody QuizPatterns patterns) {
        return questionService.save(patterns);
    }
    
    @PostMapping("/findAllById")
    public ResponseDTO findAllById(@RequestBody QuestionRequestDTO dTO ) {
        return questionService.findAllByID(dTO.getId());
    }
}
