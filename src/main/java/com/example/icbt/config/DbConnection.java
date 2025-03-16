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

    private static boolean testMode = false;
    private static Connection testConnection;

    private DbConnection() {
        if (testMode) {
            return;
        }

        try {
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

    public static void enableTestMode(Connection connection) {
        testMode = true;
        testConnection = connection;
        instance = null;
    }

    public static void disableTestMode() {
        testMode = false;
        if (testConnection != null) {
            try {
                testConnection.close();
            } catch (SQLException e) {
            }
            testConnection = null;
        }
        instance = null;
    }

    public static Connection getConnection() throws SQLException {
        if (testMode && testConnection != null) {
            return testConnection;
        }
        return dataSource.getConnection();
}


}
