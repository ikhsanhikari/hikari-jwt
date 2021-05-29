/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package id.hikari.core.dto;

import java.io.Serializable;

/**
 *
 * @author admin
 */
public class TokenResponseDTO implements Serializable {

    private String token;
    private String code;
    private String message;

    public TokenResponseDTO(String token, String code, String message) {
        this.token = token;
        this.code = code;
        this.message = message;
    }

    public TokenResponseDTO() {
    }

    public String getToken() {
        return token;
    }

    public void setToken(String token) {
        this.token = token;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }
}
