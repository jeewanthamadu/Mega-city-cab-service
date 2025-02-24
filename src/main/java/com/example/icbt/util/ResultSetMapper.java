package com.example.icbt.util;

import java.lang.reflect.Field;
import java.sql.ResultSet;
import java.sql.SQLException;

public class ResultSetMapper {

    public static <T> T mapResultSetToEntity(ResultSet rs, Class<T> entityClass) throws SQLException {
        T entity = null;

        try {
            // Create a new instance of the entity class
            entity = entityClass.getDeclaredConstructor().newInstance();

            for (Field field : entityClass.getDeclaredFields()) {
                field.setAccessible(true); // Make private fields accessible

                // Get the column name that matches the field name in ResultSet
                try {
                    Object value = rs.getObject(field.getName());
                    field.set(entity, value); // Set the value to the entity object
                } catch (IllegalAccessException e) {
                    e.printStackTrace();
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return entity;
    }
}