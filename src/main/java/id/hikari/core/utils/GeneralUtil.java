/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package id.hikari.core.utils;

import com.itextpdf.text.Document;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.pdf.PdfWriter;
import id.hikari.core.constant.StaticValue;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;

/**
 *
 * @author admin
 */
public class GeneralUtil {

    public static int countOccurrences(String str, String word) {
        String a[] = str.split(" ");
        int count = 0;
        for (String a1 : a) {
            if (a1.startsWith(word)) {
                count++;
            }
        }
        return count;
    }

    public static void replaceAll(StringBuilder builder, String from, String to) {
        int index = builder.indexOf(from);
        while (index != -1) {
            builder.replace(index, index + from.length(), to);
            index += to.length(); // Move to the end of the replacement
            index = builder.indexOf(from, index);
        }
    }

    public static void generatePDF(String text, String filename) throws Exception {
        Document document = new Document();
        try {
            String path = "D:\\test\\hikari-jwt\\upload\\";
            try (FileOutputStream fos = new FileOutputStream(path + filename)) {
                PdfWriter writer = PdfWriter.getInstance(document, fos);
                document.open();
                document.add(new Paragraph(text));
                document.close();
                writer.close();
                fos.close();
            }
        } catch (DocumentException | FileNotFoundException e) {
            e.printStackTrace();
        }
    }

    public static void replaceRandomAll(StringBuilder sb) {
        replaceRandom(sb, ":value");
        replaceRandom(sb, ":compare");
        replaceRandom(sb, ":operator");
        replaceRandom(sb, ":output");
    }

    public static void replaceRandom(StringBuilder sb, String randomType) {

        int count = countOccurrences(sb.toString(), randomType);
        for (int j = 1; j <= count; j++) {
            String to = "";
            if (randomType.equals(":value")) {
                to = String.valueOf(StaticValue.getRandomValue(j-1));
            } else if (randomType.equals(":compare")) {
                to = StaticValue.getComparison();
            } else if (randomType.equals(":operator")) {
                to = StaticValue.getOperator();
            } else if (randomType.equals(":output")) {
                to = "\"" + StaticValue.getRandomOutput(j-1) + "\"";
            }
            replaceAll(sb, randomType + j+"", to);
        }
    }
}
