package id.hikari.core.endpoint;

import id.hikari.core.repository.JawabanLatihanUserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RequiredArgsConstructor
@RestController
public class JawabanUserLatihanEndPoint {

    private final JawabanLatihanUserRepository jawabanLatihanUserRepository;

    @GetMapping("/jawaban_user_latihan")
    public ResponseEntity findAllJawabanUserByUserId(@RequestParam("username")  String username){
        return ResponseEntity.ok(jawabanLatihanUserRepository.findAllByUsername(username));
    }
}
