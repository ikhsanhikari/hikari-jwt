/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package id.hikari.core.constant;

import java.util.Arrays;
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

    public static String getRandomOutput() {
        List<String> result = Arrays.asList("Wooz", "Buff!", "Hi!", "Hello ", "Huzzzzzz", "Yosh!");
        Random rand = new Random();
        return result.get(rand.nextInt(result.size()));
    }

}
