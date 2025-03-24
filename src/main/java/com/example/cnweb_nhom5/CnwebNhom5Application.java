package com.example.cnweb_nhom5;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.openfeign.EnableFeignClients;

@SpringBootApplication
@EnableFeignClients
public class CnwebNhom5Application {

	public static void main(String[] args) {

		SpringApplication.run(CnwebNhom5Application.class, args);

	}

}
