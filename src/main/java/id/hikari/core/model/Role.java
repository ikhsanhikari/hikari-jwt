/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package id.hikari.core.model;

import org.springframework.security.core.GrantedAuthority;

/**
 *
 * @author admin
 */
public enum Role implements GrantedAuthority {
    ROLE_ADMIN, ROLE_CLIENT, ROLE_OWNER;

    public String getAuthority() {
        return name();
    }

}
