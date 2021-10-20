/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package id.hikari.core.model;

import id.hikari.core.audit.Auditable;
import id.hikari.core.dto.CourseLevel;
import id.hikari.core.dto.CourseType;
import java.io.Serializable;
import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import lombok.Data;

/**
 *
 * @author admin
 */
@Entity
@Data
@Table(name = "quiz_patterns")
public class QuizPatterns extends Auditable<String> implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;

    private String pattern;

    @Enumerated(EnumType.STRING)
    private CourseLevel courseLevel;

    @Enumerated(EnumType.STRING)
    private CourseType courseType;

}
