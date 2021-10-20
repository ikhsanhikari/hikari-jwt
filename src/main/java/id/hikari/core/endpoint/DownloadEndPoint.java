/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package id.hikari.core.endpoint;

import id.hikari.core.service.QuestionService;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

/**
 *
 * @author admin
 */
@RestController
public class DownloadEndPoint {

    @Autowired
    private QuestionService questionService;

    @GetMapping("/pdf")
    public void pdf(HttpServletResponse response, @RequestParam("output") String outputFileName,@RequestParam("generateId") String generateId) {
        questionService.generateQuestion(response, outputFileName,generateId);
    }

    @GetMapping("/download")
    public void download(HttpServletResponse response, @RequestParam("output") String outputFileName) {
        try {
            questionService.downloadExcel(response, outputFileName);
        } catch (Exception ex) {
            Logger.getLogger(DownloadEndPoint.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}
