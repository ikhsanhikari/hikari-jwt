/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package id.hikari.core.endpoint;

import io.swagger.annotations.Api;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 *
 * @author admin
 */
@RestController
@Api(tags = "test hikari")
public class TestController {

    @GetMapping("/ping")
//    @PreAuthorize("hasRole('ROLE_OWNER')")
    public String ping() {
        return "pong";
    }

    @GetMapping("/hikari")
    @PreAuthorize("hasRole('ROLE_OWNER')")
    public String hikari() {
        return "hikaru";
    }
}
