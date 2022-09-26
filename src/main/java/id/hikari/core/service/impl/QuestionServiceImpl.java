/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package id.hikari.core.service.impl;

import id.hikari.core.dto.*;
import id.hikari.core.model.GeneralSetting;
import id.hikari.core.model.QuestionBank;
import id.hikari.core.model.QuizPatterns;
import id.hikari.core.model.SettingLatihan;
import id.hikari.core.repository.GeneralSettingRepository;
import id.hikari.core.repository.QuestionBankRepository;
import id.hikari.core.repository.QuizPatternsRepository;
import id.hikari.core.repository.SettingLatihanRepository;
import id.hikari.core.service.CompilerService;
import id.hikari.core.service.QuestionService;
import id.hikari.core.specification.PatternSpecification;
import id.hikari.core.utils.GeneralUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.servlet.http.HttpServletResponse;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.*;
import java.util.stream.Collectors;

/**
 * @author admin
 */
@Service
public class QuestionServiceImpl implements QuestionService {

    private static final String DOWNLOAD_DIR = "D:\\test\\hikari-jwt\\upload\\";

    Logger log = LoggerFactory.getLogger(QuestionServiceImpl.class);

    @Autowired
    private CompilerService compilerService;

    @Autowired
    private QuizPatternsRepository patternsRepository;

    @Autowired
    private QuestionBankRepository bankRepository;

    @Autowired
    private PatternSpecification patternSpecification;

    @Autowired
    private GeneralSettingRepository generalSettingRepository;

    @Autowired
    private SettingLatihanRepository settingLatihanRepository;

    private String getOutput(String pattern) throws IOException {
        CompileRequestDTO crdto = new CompileRequestDTO();
        crdto.setCode(pattern);
        ResponseDTO compile = compilerService.compile(crdto);
        CompileRequestDTO res = (CompileRequestDTO) compile.getData();
        return res.getOutput();
    }

    @Override
    @Transactional
    public void generateQuestion(HttpServletResponse response, String outputFileName, String generateId) {
        try {
            List<QuestionBank> list = bankRepository.findAllByGenerateId(generateId);
            String code = "";
            String answer = "";
            int no = 1;
            for (QuestionBank questionBank : list) {
                code += no + ". " + questionBank.getPattern() + "\n\n";
                answer += no + ". " + questionBank.getAnswer() + "\n";
                no++;
            }

            code += "\nAnswer\n" + answer;

            GeneralUtil.generatePDF(code, outputFileName);
        } catch (Exception ex) {
        }
    }

    @Override
    public void downloadExcel(HttpServletResponse response, String outputFileName) throws Exception {
        Path pathFile = Paths.get(DOWNLOAD_DIR, outputFileName);
        try {
            response.setContentType("application/*");
            response.addHeader("Content-Disposition", "attachment; filename=" + outputFileName);
            OutputStream out = response.getOutputStream();
            try (FileInputStream in = new FileInputStream(pathFile.toFile())) {
                byte[] buffer = new byte[4096];
                int length;
                while ((length = in.read(buffer)) > 0) {
                    out.write(buffer, 0, length);
                }
            }
            out.flush();
            out.close();
        } catch (IOException ex) {
            throw new RuntimeException("IOError writing file to output stream");
        }
    }

    @Override
    public ResponseDTO findAll() {
        List<QuizPatterns> patterns = patternsRepository.findAll();
        return new ResponseDTO(patterns, Status.Success);
    }

    @Override
    public ResponseDTO findById(Long id) {
        QuizPatterns patterns = patternsRepository.findById(id).orElse(null);
        return new ResponseDTO(patterns, Status.Success);
    }

    @Override
    public ResponseDTO save(QuizPatterns patterns) {
        QuizPatterns save = patternsRepository.save(patterns);
        return new ResponseDTO(save, Status.Success);
    }

    @Override
    public ResponseDTO findAllByCourse(CourseLevel level, CourseType type) {
        List<QuizPatterns> list = patternsRepository.findAll(patternSpecification.getPatten(level, type));
        return new ResponseDTO(list, Status.Success);
    }

    @Override
    public ResponseDTO findAllByID(List<Long> id, boolean isExercise, Long settingId) {
        List<QuizPatterns> patternses = new ArrayList<>();
        Optional<SettingLatihan> byId = settingLatihanRepository.findById(settingId);

        if (isExercise) {
            List<String> myList = new ArrayList<>(Arrays.asList(byId.get().getPola().split(",")));
            List<Long> collect = myList.stream()
                    .map(Long::parseLong)
                    .collect(Collectors.toList());
            patternses = patternsRepository.findAllByID(collect);
        } else {
            patternses = patternsRepository.findAllByID(id);
        }
        List<QuestionBank> newRandom = new ArrayList<>();
        Integer jumlahSoal = byId.get().getJumlahSoal();
        Long time = new Date().getTime();
        for (int i = 0; i < jumlahSoal; i++) {
            patternses.forEach(
                    (data) -> {
                        StringBuilder sb = new StringBuilder(data.getPattern());
                        GeneralUtil.replaceRandomAll(sb);
                        QuestionBank qp = new QuestionBank();
                        qp.setId(null);
                        qp.setPattern(sb.toString());
                        try {
                            qp.setAnswer(getOutput(sb.toString()));
                        } catch (IOException ex) {
//                            Logger.getLogger(QuestionServiceImpl.class.getName()).log(Level.SEVERE, null, ex);
                        }
                        qp.setGenerateId(time.toString());
                        bankRepository.save(qp);
                    });
        }
        Collections.shuffle(newRandom);
        return new ResponseDTO(time.toString(), Status.Success);
    }

    private String getGeneralSetting(String code) {
        GeneralSetting setting = generalSettingRepository.findById(code).orElse(null);
        return String.valueOf(setting.getSettingValue());
    }
}
