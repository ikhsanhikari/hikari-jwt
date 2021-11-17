/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package id.hikari.core.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

/**
 *
 * @author admin
 */
@Controller
public class ViewController {

    @GetMapping({"/", "/login"})
    public String test(Model model) {
        return "login";
    }

    @RequestMapping({"/index"})
    public ModelAndView login(Model model) {
        return new ModelAndView("index");
    }

    @RequestMapping({"/create-pattern"})
    public ModelAndView createPattern(Model model) {
        return new ModelAndView("create_pattern");
    }

    @RequestMapping({"/list-pattern"})
    public ModelAndView listPattern(Model model) {
        return new ModelAndView("list_pattern");
    }
    
    @RequestMapping({"/generate-pattern"})
    public ModelAndView generatePattern(Model model) {
        return new ModelAndView("generate_pattern");
    }
    
    @RequestMapping({"/exercise"})
    public ModelAndView exercise(Model model) {
        return new ModelAndView("exercise");
    }
    
    @RequestMapping({"/general-setting"})
    public ModelAndView generalSetting(Model model) {
        return new ModelAndView("general_setting");
    }
    
    @RequestMapping({"/help"})
    public ModelAndView help(Model model) {
        return new ModelAndView("help");
    }

}
