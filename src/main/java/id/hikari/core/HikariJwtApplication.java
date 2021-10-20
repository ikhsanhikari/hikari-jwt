package id.hikari.core;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;

@SpringBootApplication
public class HikariJwtApplication extends SpringBootServletInitializer{

    public static void main(String[] args) {
        SpringApplication.run(HikariJwtApplication.class, args);
    }

//    @Override
//    protected SpringApplicationBuilder configure(SpringApplicationBuilder application) {
//        return application.sources(HikariJwtApplication.class);
//    }
}
