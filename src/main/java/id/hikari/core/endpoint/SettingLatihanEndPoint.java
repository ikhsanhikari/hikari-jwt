package id.hikari.core.endpoint;

import id.hikari.core.dto.ResponseDTO;
import id.hikari.core.dto.Status;
import id.hikari.core.model.SettingLatihan;
import id.hikari.core.repository.SettingLatihanRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequiredArgsConstructor
public class SettingLatihanEndPoint {
    private final SettingLatihanRepository settingLatihanRepository;

    @PostMapping("/save_setting_latihan")
    public ResponseEntity saveSettingLatihan(@RequestBody SettingLatihan settingLatihan) {
        SettingLatihan save = settingLatihanRepository.save(settingLatihan);
        return ResponseEntity.ok(save);
    }

    @GetMapping("/get_setting_latihan")
    public ResponseEntity getAll() {
        return ResponseEntity.ok(new ResponseDTO(settingLatihanRepository.findAll(), Status.Success));
    }
}
