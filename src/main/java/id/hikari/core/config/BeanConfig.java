package id.hikari.core.config;

import java.util.Optional;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.domain.AuditorAware;
import org.springframework.data.jpa.repository.config.EnableJpaAuditing;

import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;

//spring annotation
@Configuration
//spring jpa audit annotation
//annotation enables the auditing in jpa via annotation configuration
@EnableJpaAuditing(auditorAwareRef = "aware")
public class BeanConfig {

    //helps to aware the application's current auditor.
    //this is some kind of user mostly.
    @Bean
    public AuditorAware<String> aware() {
        return new AuditorAware<String>() {
            @Override
            public Optional<String> getCurrentAuditor() {
                if (SecurityContextHolder.getContext().getAuthentication() != null) {
                    UserDetails userDetails = (UserDetails) SecurityContextHolder.getContext().getAuthentication()
                            .getPrincipal();
                    String username = userDetails.getUsername();
                    return Optional.of(username);
                } else {
                    return Optional.of("No Name");
                }
            }

        };
    }

//    @Bean
//    public Faker faker() {
//        return new Faker(Locale.ENGLISH);
//    }
}
