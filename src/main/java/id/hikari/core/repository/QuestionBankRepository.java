/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package id.hikari.core.repository;

import id.hikari.core.model.QuestionBank;
import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;

/**
 *
 * @author admin
 */
public interface QuestionBankRepository extends JpaRepository<QuestionBank, Long> {
    public List<QuestionBank> findAllByGenerateId(String generateId);
}
