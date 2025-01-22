package com.bawi.servlet;

import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.*;

public class State {
    public static class Profile {
        public byte[] passMD5;
        public String csrfToken;
        public long csrfTokenExpiration;

        public Profile(byte[] passMD5, String csrfToken, long csrfTokenExpiration) {
            this.passMD5 = passMD5;
            this.csrfToken = csrfToken;
            this.csrfTokenExpiration = csrfTokenExpiration;
        }
    }

    public static final Map<String, Profile> LOGIN_PROFILE = new HashMap<>();
    public static final LinkedList<String> REVIEWS = new LinkedList<>();


    public static byte[] createHashWithSalt(String password, String salt) {
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-512");
            md.update(salt.getBytes(StandardCharsets.UTF_8)); // salt
            return md.digest(password.getBytes(StandardCharsets.UTF_8));
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException(e);
        }
    }
}
