/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package id.hikari.core.constant;

import java.util.Random;

/**
 *
 * @author admin
 */
public class StaticQuestion {

    public static String pattern2code(Random rand) {
        final int size = 15;
        String code = "        int a = " + rand.nextInt(size) + ";\n"
                + "        if (a " + StaticValue.getComparison() + " " + rand.nextInt(size) + ") {\n"
                + "            " + StaticValue.printLnText(StaticValue.getRandomOutput()) + "\n"
                + "        } else if (a " + StaticValue.getComparison() + " " + rand.nextInt(size) + " ) {\n"
                + "            " + StaticValue.printLnText(StaticValue.getRandomOutput()) + "\n"
                + "        } else {\n"
                + "            " + StaticValue.printLnText(StaticValue.getRandomOutput()) + "\n"
                + "        }";
        return StaticValue.psvm(code);
    }

    public static String pattern1code(Random rand) {
        final int size = 15;
        String code = "         int a = " + rand.nextInt(size) + ";\n"
                + "        int b = " + rand.nextInt(size) + ";\n"
                + "        int c = " + rand.nextInt(size) + ";\n"
                + "        a = " + StaticValue.getStandarVarName() + " " + StaticValue.getOperator() + " " + StaticValue.getStandarVarName() + ";\n"
                + "        b = " + StaticValue.getStandarVarName() + " " + StaticValue.getOperator() + " " + StaticValue.getStandarVarName() + ";\n"
                + "        c = " + StaticValue.getStandarVarName() + " " + StaticValue.getOperator() + " " + StaticValue.getStandarVarName() + ";\n"
                + "        System.out.println(" + StaticValue.getStandarVarName() + ");";
        return StaticValue.psvm(code);
    }
}
