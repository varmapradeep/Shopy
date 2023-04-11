/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package shoppackages;

import java.sql.Connection;
import java.sql.DriverManager;

/**
 *
 * @author VARMA PRADEEP
 */
public class ShopClass {

    public static Connection getCon() {
        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/dbshop", "root", "");
            return con;
        } catch (Exception e) {
            System.out.println(e);
            return null;

        }
    }
}
