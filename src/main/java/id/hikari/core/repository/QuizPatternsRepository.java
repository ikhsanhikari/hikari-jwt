/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package id.hikari.core.repository;

import id.hikari.core.model.QuizPatterns;
import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;

/**
 *
 * @author admin
 */
public interface QuizPatternsRepository extends JpaRepository<QuizPatterns, Long>, JpaSpecificationExecutor {

    @Query(value = "select a from QuizPatterns a where a.id in (?1)")
    public List<QuizPatterns> findAllByID(List<Long> id);
}
