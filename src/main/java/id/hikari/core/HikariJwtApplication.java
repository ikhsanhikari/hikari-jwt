package id.hikari.core;

import id.hikari.core.utils.FileStorageProperties;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;

@EnableConfigurationProperties({ FileStorageProperties.class})
@SpringBootApplication
public class HikariJwtApplication extends SpringBootServletInitializer{

    public static void main(String[] args) {
        SpringApplication.run(HikariJwtApplication.class, args);
    }

}
