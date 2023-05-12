package com.ecpbm.service;

import com.ecpbm.pojo.AdminInfo;

public interface AdminInfoService {

    AdminInfo login(AdminInfo ai);
    AdminInfo getAdminInfoAndFunctions(Integer id);
}
