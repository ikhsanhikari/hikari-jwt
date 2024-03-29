/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package id.hikari.core.model;

import id.hikari.core.audit.Auditable;
import java.io.Serializable;
import javax.persistence.*;

import lombok.Data;

/**
 *
 * @author admin
 */
@Entity
@Data
@Table(name = "general_setting")
public class GeneralSetting extends Auditable<String> implements Serializable {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long settingId;
    
    private String settingValue;
    
    private String description;
}
