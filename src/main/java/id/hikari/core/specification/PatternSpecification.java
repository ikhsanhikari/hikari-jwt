/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package id.hikari.core.specification;

import id.hikari.core.dto.CourseLevel;
import id.hikari.core.dto.CourseType;
import id.hikari.core.model.QuizPatterns;
import java.util.ArrayList;
import java.util.List;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Component;

/**
 *
 * @author admin
 */
@Component
public class PatternSpecification {

    public Specification<QuizPatterns> getPatten(CourseLevel level, CourseType type) {
        return (Root<QuizPatterns> root, CriteriaQuery<?> cq, CriteriaBuilder cb) -> {
            List<Predicate> predicates = new ArrayList<>();

            if (type != null) {
                final Predicate param = cb.equal(root.<CourseType>get("courseType"), type);
                predicates.add(param);
            }

            if (level != null) {
                final Predicate param = cb.equal(root.<CourseLevel>get("courseLevel"), level);
                predicates.add(param);
            }

            cq.orderBy(cb.desc(root.get("creationDate")));

            return cb.and(predicates.toArray(new Predicate[predicates.size()]));
        };
    }
}
