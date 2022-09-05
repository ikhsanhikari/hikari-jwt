/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package id.hikari.core;

import java.util.ArrayList;
import java.util.Collections;
import java.util.concurrent.CompletableFuture;

/**
 *
 * @author admin
 */
public class Test {

    public static void main(String[] args) {
        ArrayList<Integer> list = new ArrayList<Integer>();
        for (int i = 1; i < 11; i++) {
            list.add(i);
        }
        Collections.shuffle(list);
        for (int i = 0; i < 9; i++) {
            System.out.println(list.get(i));
        }
    }
}
