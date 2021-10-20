/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package id.hikari.core.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 *
 * @author admin
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class ResponseDTO {

    private Object data;
    private Status status;

}
