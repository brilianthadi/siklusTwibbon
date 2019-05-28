package com.araiintsoft.siklus;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class TesController {

    @GetMapping("/")
    @ResponseBody
    public String homePage(Model model){
        return "home";
    }
}
