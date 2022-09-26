package id.hikari.core.model;

import id.hikari.core.audit.Auditable;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.eclipse.persistence.annotations.UuidGenerator;
import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import java.io.Serializable;
import java.util.UUID;

@Entity
@Table(name = "setting_latihan")
@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class SettingLatihan extends Auditable<String> implements Serializable {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;
    private String namaLatihan;
    private Integer jumlahSoal;
    private String pola;
    private String waktu;

}
