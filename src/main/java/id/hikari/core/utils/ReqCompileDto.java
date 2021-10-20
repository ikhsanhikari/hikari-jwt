/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package id.hikari.core.utils;

/**
 *
 * @author admin
 */
public class ReqCompileDto {
    private String code;
    private String language;
    private String input;

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getLanguage() {
        return language;
    }

    public void setLanguage(String language) {
        this.language = language;
    }

    public String getInput() {
        return input;
    }

    public void setInput(String input) {
        this.input = input;
    }

    public ReqCompileDto() {
    }

    public ReqCompileDto(String code, String language, String input) {
        this.code = code;
        this.language = language;
        this.input = input;
    }
    
    
    
}
