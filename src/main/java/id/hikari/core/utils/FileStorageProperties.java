package id.hikari.core.utils;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.boot.context.properties.ConfigurationProperties;


@Data
@NoArgsConstructor
@AllArgsConstructor
@ConfigurationProperties(prefix = "file")
public class FileStorageProperties {
    private String uploadDir;
}
