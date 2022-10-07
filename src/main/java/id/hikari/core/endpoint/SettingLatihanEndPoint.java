package id.hikari.core.endpoint;

import id.hikari.core.dto.ResponseDTO;
import id.hikari.core.dto.Status;
import id.hikari.core.model.SettingLatihan;
import id.hikari.core.repository.JawabanLatihanUserRepository;
import id.hikari.core.repository.SettingLatihanRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

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

    @GetMapping("/get_setting_latihan_by_id/{id}")
    public ResponseEntity getById(@PathVariable("id") Long id) {
        return ResponseEntity.ok(new ResponseDTO(settingLatihanRepository.findById(id).orElse(null), Status.Success));
    }

    @GetMapping("/delete_setting_latihan_by_id/{id}")
    public ResponseEntity deleteById(@PathVariable("id") Long id) {
        settingLatihanRepository.delete(settingLatihanRepository.findById(id).orElse(null));
        return ResponseEntity.ok(new ResponseDTO(null, Status.Success));
    }
}
