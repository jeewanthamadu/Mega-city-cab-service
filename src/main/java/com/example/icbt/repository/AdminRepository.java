package com.example.icbt.repository;

import com.example.icbt.entity.Admin;
import com.example.icbt.util.CrudUtil;
import com.example.icbt.util.QueryUtil;
import com.example.icbt.util.ResultSetMapper;

import java.sql.ResultSet;

public class AdminRepository {

    public Admin findByUsername(String username) {
        try {
            ResultSet rs = CrudUtil.executeQuery(QueryUtil.SELECT_ALL_ADMIN_WHERE_USERNAME, username);
            if (rs.next()) {
                return ResultSetMapper.mapResultSetToEntity(rs, Admin.class);
            }
            System.out.println("No Admin found for this username:" + username);
        } catch (Exception e) {
            System.out.println(e.getLocalizedMessage());
            e.getStackTrace();
        }
        return null;
    }

}
