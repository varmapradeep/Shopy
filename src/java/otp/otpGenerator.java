package otp;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
import java.util.Random;

/**
 *
 * @author VARMA PRADEEP
 */
public class otpGenerator {
    public static String generateOTP() {
        int otpLength = 6; // Change the length as per your requirement
        String numbers = "0123456789";
        Random random = new Random();
        StringBuilder otp = new StringBuilder(otpLength);

        for (int i = 0; i < otpLength; i++) {
            otp.append(numbers.charAt(random.nextInt(numbers.length())));
        }

        return otp.toString();
    }
}