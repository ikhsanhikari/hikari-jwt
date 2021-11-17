/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package id.hikari.core.constant;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;
import java.util.Random;

/**
 *
 * @author admin
 */
public class StaticValue {

    public static String psvm(String code) {
        return "class Program{\n"
                + " public static void main(String [] args){\n"
                + code + "\n"
                + " }\n"
                + "}";
    }

    public static String getOperator() {
        List<String> result = Arrays.asList("+", "-");
        Random rand = new Random();
        return result.get(rand.nextInt(result.size()));
    }

    public static String getComparison() {
        List<String> result = Arrays.asList("<", ">", "<=", ">=", "!=", "==");
        Random rand = new Random();
        return result.get(rand.nextInt(result.size()));
    }

    public static String getStandarVarName() {
        List<String> result = Arrays.asList("a", "b", "c");
        Random rand = new Random();
        return result.get(rand.nextInt(result.size()));
    }

    public static String printLnText(String text) {
        return "System.out.println(\"" + text + "\");";
    }

    public static String getRandomOutput(int index) {
        List<String> result = Arrays.asList("Wooz", "Buff!", "Hi!", "Hello ", "Huzzzzzz", "Yosh!");
        Collections.shuffle(result);
        if((result.size()-1)<index){
            return "default";
        }else{
            return result.get(index);
        }
        
    }
    
    public static Integer getRandomValue(int index) {
        List<Integer> result = new ArrayList<>();
        for (int i = 1; i < 30; i++) {
            result.add(i);
        }
        Collections.shuffle(result);
        return result.get(index);
    }

}
