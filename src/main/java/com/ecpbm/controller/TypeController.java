package com.ecpbm.controller;

import java.sql.SQLOutput;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ecpbm.pojo.Type;
import com.ecpbm.service.TypeService;

@Controller
@RequestMapping("/type")
public class TypeController {
    @Autowired
    private TypeService typeService;
    @RequestMapping("/getType/{flag}")
    @ResponseBody
    public List<Type> getType(@PathVariable("flag") Integer flag) {
        List<Type> typeList = typeService.getAll();
        if (flag == 1) {
            Type t = new Type();
            t.setId(0);
            t.setName("请选择...");
            typeList.add(0, t);
        }
        return typeList;
    }

    @RequestMapping(value = "/addType", produces = "text/html;charset=UTF-8")
    @ResponseBody
    public String addType(Type type) {
        try {
            typeService.addType(type);
            return "{\"success\":\"true\",\"message\":\"添加成功\"}";
        } catch (Exception e) {
            return "{\"success\":\"false\",\"message\":\"添加失败\"}";
        }
    }

    @RequestMapping(value = "/updateType", produces = "text/html;charset=UTF-8")
    @ResponseBody
    public String updateType(Type type) {
        System.out.println(type);

        try {
            typeService.updateType(type);
            return "{\"success\":\"true\",\"message\":\"修改成功\"}";
        } catch (Exception e) {
            return "{\"success\":\"false\",\"message\":\"修改失败\"}";
        }
    }



    @RequestMapping(value = "/deleteType", produces = "text/html;charset=UTF-8")
    @ResponseBody
    public String deleteProduct(@RequestParam(value = "id") String id) {
        System.out.println(id);
        String str = "";
        try {
            String substring = id.substring(0, id.length() - 1);
            System.out.println(substring);
            typeService.deleteSelect(substring);
            System.out.println("-----------------");
            str = "{\"success\":\"true\",\"message\":\"删除成功\"}";
        } catch (Exception e) {
            str = "{\"success\":\"false\",\"message\":\"删除失败\"}";
        }
        return str;
    }
}