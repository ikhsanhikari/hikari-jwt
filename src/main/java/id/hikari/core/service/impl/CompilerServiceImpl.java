/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package id.hikari.core.service.impl;

import id.hikari.core.dto.CompileRequestDTO;
import id.hikari.core.dto.ResponseDTO;
import id.hikari.core.dto.Status;
import id.hikari.core.service.CompilerService;
import id.hikari.core.utils.GeneralUtil;
import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.io.UnsupportedEncodingException;
import java.io.Writer;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;
import org.springframework.stereotype.Service;

/**
 *
 * @author admin
 */
@Service
public class CompilerServiceImpl implements CompilerService {

    private static final String DIR = "D:\\ikhsan\\output\\";

    @Override
    public ResponseDTO compile(CompileRequestDTO crdto) throws IOException {
        final String filename = UUID.randomUUID().toString().replace("-", "");

        StringBuilder sb = new StringBuilder(crdto.getCode());

        GeneralUtil.replaceRandomAll(sb);

        crdto.setCode(sb.toString());
//        System.out.println(crdto.getCode());

        generateJavaFile(crdto, filename);
        String output = execCMD(filename);

        crdto.setOutput(output);
        CompileRequestDTO dTO = new CompileRequestDTO(crdto.getCode(), crdto.getOutput());

        if (output.contains("Error") || output.contains("error")) {
            return new ResponseDTO(dTO, Status.Error);
        }
        return new ResponseDTO(dTO, Status.Success);
    }

    private String execCMD(String filename) throws IOException {
        ProcessBuilder builder = new ProcessBuilder(
                "cmd.exe", "/c", "D: && cd " + DIR + " && javac " + filename + ".java && java -cp . Program && del /q Program.class ");
        builder.redirectErrorStream(true);
        Process p = builder.start();
        BufferedReader r = new BufferedReader(new InputStreamReader(p.getInputStream()));
        String line;
        String output = "";
        List<String> outputList = new ArrayList<>();
        while (true) {
            line = r.readLine();
            if (line == null) {
                break;
            }
            outputList.add(line);
        }
        return String.join("\n",outputList);
    }

    private void generateJavaFile(CompileRequestDTO crdto, String filename) throws IOException {
        try (Writer writer = new BufferedWriter(new OutputStreamWriter(
                new FileOutputStream(DIR + filename + ".java"), "utf-8"))) {
            writer.write(crdto.getCode());
            writer.close();
        } catch (UnsupportedEncodingException ex) {
        }
    }

}
