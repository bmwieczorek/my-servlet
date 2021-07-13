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

    public static class UserReview {
        private String username;
        private String review;

        public UserReview(String username, String review) {
            this.username = username;
            this.review = review;
        }

        public String getUsername() {
            return username;
        }

        public String getReview() {
            return review;
        }

        @Override
        public boolean equals(Object o) {
            if (this == o) return true;
            if (o == null || getClass() != o.getClass()) return false;
            UserReview that = (UserReview) o;
            return Objects.equals(username, that.username) &&
                    Objects.equals(review, that.review);
        }

        @Override
        public int hashCode() {
            return Objects.hash(username, review);
        }
    }

    public static final Map<String, Profile> LOGIN_PROFILE = new HashMap<>();
    public static final LinkedList<String> REVIEWS = new LinkedList<>();
    public static final List<UserReview> USER_REVIEWS = new LinkedList<>();

    public static final Map<String, byte[]> USER_PASSWORD_HASH = new HashMap<>();

    public static byte[] createHash(String username, String password) {
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-512");
            md.update(username.getBytes(StandardCharsets.UTF_8)); // salt
            return md.digest(password.getBytes(StandardCharsets.UTF_8));
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException(e);
        }
    }
}
