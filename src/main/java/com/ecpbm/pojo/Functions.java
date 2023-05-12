package com.ecpbm.pojo;
//封装系统功能信息
import java.util.HashSet;
import java.util.Set;

public class Functions implements Comparable<Functions>{

    private int id;
    private String name;
    private int parentid;//父节点id
    private boolean isleaf;//是否为叶子结点
    private Set ais= new HashSet();

    public Functions() {
    }

    public Functions(int id, String name, int parentid, boolean isleaf, Set ais) {
        this.id = id;
        this.name = name;
        this.parentid = parentid;
        this.isleaf = isleaf;
        this.ais = ais;
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

    public int getParentid() {
        return parentid;
    }

    public void setParentid(int parentid) {
        this.parentid = parentid;
    }

    public boolean isIsleaf() {
        return isleaf;
    }

    public void setIsleaf(boolean isleaf) {
        this.isleaf = isleaf;
    }

    public Set getAis() {
        return ais;
    }

    public void setAis(Set ais) {
        this.ais = ais;
    }

    @Override
    public int compareTo(Functions o) {

      //  return  ((Integer)this.getId()).compareTo((Integer)o.getId()));
        int i = ((Integer) this.getId()).compareTo((Integer) o.getId());
        return i;
    }
}
