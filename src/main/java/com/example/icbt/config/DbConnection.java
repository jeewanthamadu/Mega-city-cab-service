package com.example.icbt.config;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;
import java.sql.*;

public class DbConnection {
    // Singleton instance
    private static DbConnection instance;
    private static DataSource dataSource;

    // Private constructor to enforce Singleton pattern
    private DbConnection() {
        try {
            // Look up the DataSource from JNDI
            Context context = new InitialContext();
            dataSource = (DataSource) context.lookup("java:comp/env/jdbc/CabServiceDB");
        } catch (NamingException e) {
            throw new RuntimeException("Failed to lookup DataSource from JNDI", e);
        }
    }

    // Singleton instance getter
    public static DbConnection getInstance() {
        if (instance == null) {
            synchronized (DbConnection.class) {
                if (instance == null) {
                    instance = new DbConnection();
                }
            }
        }
        return instance;
    }

    // Get a database connection
    public static Connection getConnection() throws SQLException {
        return dataSource.getConnection();
}

}
