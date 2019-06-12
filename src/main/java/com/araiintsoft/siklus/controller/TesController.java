package com.araiintsoft.siklus.controller;

import org.apache.tomcat.util.http.fileupload.IOUtils;
import org.springframework.core.io.ClassPathResource;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StreamUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.InputStream;

@Controller
public class TesController {

    @GetMapping("/home")
    public String homePage(Model model){
        model.addAttribute("appName", "siklus");
        return "home";
    }

    @GetMapping("/twibbon")
    public String twibbon(Model model){
        model.addAttribute("appName", "siklus");
        return "twibbon";
    }

    @GetMapping("/")
    public String home(Model model){
        model.addAttribute("appName", "siklus");
        return "twibbon";
    }

    @GetMapping(value = "/img-twibbon", produces = MediaType.IMAGE_PNG_VALUE)
    public void getImage(HttpServletResponse response) throws IOException {
        ClassPathResource imgFile = new ClassPathResource("image/twibbon.png");
        response.setContentType(MediaType.IMAGE_PNG_VALUE);
        StreamUtils.copy(imgFile.getInputStream(), response.getOutputStream());
    }

    @GetMapping(value = "/img-cluster", produces = MediaType.IMAGE_JPEG_VALUE)
    public void clusterLogo(HttpServletResponse response) throws IOException {
        ClassPathResource imgFile = new ClassPathResource("image/cluster.png");
        response.setContentType(MediaType.IMAGE_JPEG_VALUE);
        StreamUtils.copy(imgFile.getInputStream(), response.getOutputStream());
    }

    @GetMapping(value = "/img-siklus", produces = MediaType.IMAGE_PNG_VALUE)
    public void siklusLogo(HttpServletResponse response) throws IOException {
        ClassPathResource imgFile = new ClassPathResource("image/siklus.png");
        response.setContentType(MediaType.IMAGE_PNG_VALUE);
        StreamUtils.copy(imgFile.getInputStream(), response.getOutputStream());
    }
}
