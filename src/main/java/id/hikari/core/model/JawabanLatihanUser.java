package id.hikari.core.model;

import id.hikari.core.audit.Auditable;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import java.io.Serializable;
import java.math.BigDecimal;

@Data
@Builder@AllArgsConstructor@NoArgsConstructor
@Entity
@Table(name = "jawaban_latihan_user")
public class JawabanLatihanUser extends Auditable<String> implements Serializable {
    @Id
    @Column(name = "id", nullable = false)
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;

    private String generateId;
    private String username;
    private String answer;
    private Integer result;
    private Integer totalSoal;
    @Column(name = "setting_id")
    private Integer settingId;

    @ManyToOne(cascade = CascadeType.ALL)
    @JoinColumn(referencedColumnName = "id",name = "setting_id",insertable = false,updatable = false)
    private SettingLatihan settingLatihan;

}
