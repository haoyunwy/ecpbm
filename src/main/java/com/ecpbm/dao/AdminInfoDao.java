package com.ecpbm.dao;

import com.ecpbm.pojo.AdminInfo;
import org.apache.ibatis.annotations.Many;
import org.apache.ibatis.annotations.Result;
import org.apache.ibatis.annotations.Results;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.mapping.FetchType;

public interface AdminInfoDao {
    //根据登录名和密码登录，因为登录只需要name,和 pwd所以其他的不用赋值
    @Select("select * from admin_info where name=#{name} and pwd=#{pwd}")
    AdminInfo selectByNameAndPwd(AdminInfo ai);


    //根据管理员的id来查询他有哪些功能
@Select("select * from admin_info where id=#{id}")
@Results(
        {@Result(id=true,column = "id",property="id"),
                @Result(column = "name",property = "name"),
                @Result(column = "pwd",property = "pwd"),

                @Result(column = "id",property = "fs",many =
                @Many(select = "com.ecpbm.dao.FunctionDao.selectByAdminID",
                        fetchType = FetchType.EAGER))
        }
)
     AdminInfo selectById(Integer id);
}
