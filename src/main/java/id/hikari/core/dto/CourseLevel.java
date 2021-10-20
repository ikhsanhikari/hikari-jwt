/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package id.hikari.core.dto;

/**
 *
 * @author admin
 */
public enum CourseLevel {
    LOW("LOW"), MEDIUM("MEDIUM"), HIGH("HIGH"), ALL("");

    private final String code;

    CourseLevel(String code) {
        this.code = code;
    }

    // Overriding toString() method to return "" instead of "EMPTY"
    @Override
    public String toString() {
        return this.code;
    }
}
