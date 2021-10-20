/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package id.hikari.core.endpoint;

import id.hikari.core.dto.CompileRequestDTO;
import id.hikari.core.dto.ResponseDTO;
import id.hikari.core.service.CompilerService;
import java.io.IOException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

/**
 *
 * @author admin
 */
@RestController
public class CompilerEndPoint {

    @Autowired
    private CompilerService compilerService;

    @PostMapping("/write-java")
    public ResponseDTO write(@RequestBody CompileRequestDTO crdto) throws IOException {
        return compilerService.compile(crdto);
    }
}
