package com.araiintsoft.siklus;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.web.servlet.ServletComponentScan;

@ServletComponentScan
@SpringBootApplication
public class SiklusApplication {

	public static void main(String[] args) {
		SpringApplication.run(SiklusApplication.class, args);
	}

}
