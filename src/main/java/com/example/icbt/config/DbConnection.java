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

    // Flag to indicate if we're in test mode
    private static boolean testMode = false;
    private static Connection testConnection;

    // Private constructor to enforce Singleton pattern
    private DbConnection() {
        if (testMode) {
            // In test mode, we'll use a direct connection instead of JNDI
            return;
        }

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

    // Enable test mode with a specific connection
    public static void enableTestMode(Connection connection) {
        testMode = true;
        testConnection = connection;
        // Reset the instance so it will be recreated with test settings
        instance = null;
    }

    // Disable test mode
    public static void disableTestMode() {
        testMode = false;
        if (testConnection != null) {
            try {
                testConnection.close();
            } catch (SQLException e) {
                // Log or handle the exception
            }
            testConnection = null;
        }
        // Reset the instance
        instance = null;
    }

    // Get a database connection
    public static Connection getConnection() throws SQLException {
        if (testMode && testConnection != null) {
            return testConnection;
        }
        return dataSource.getConnection();
}


}
