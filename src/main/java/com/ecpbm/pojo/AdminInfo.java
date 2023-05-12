package com.ecpbm.pojo;
import java.util.List;

//封装管理员信息
public class AdminInfo {
    private int id;
    private String name;
    private String pwd;
    private List<Functions> fs;

    public AdminInfo() {
    }

    public AdminInfo(int id, String name, String pwd, List<Functions> fs) {
        this.id = id;
        this.name = name;
        this.pwd = pwd;
        this.fs = fs;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPwd() {
        return pwd;
    }

    public void setPwd(String pwd) {
        this.pwd = pwd;
    }

    public List<Functions> getFs() {
        return fs;
    }

    public void setFs(List<Functions> fs) {
        this.fs = fs;
    }

    @Override
    public String toString() {
        return "AdminInfo{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", pwd='" + pwd + '\'' +
                ", fs=" + fs +
                '}';
    }
}
