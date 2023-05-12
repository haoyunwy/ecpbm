package com.ecpbm.pojo;
//封装权限信息
public class Power {
    private  AdminInfo ai;
    private Functions f;

    public AdminInfo getAi() {
        return ai;
    }

    public void setAi(AdminInfo ai) {
        this.ai = ai;
    }

    public Functions getF() {
        return f;
    }

    public void setF(Functions f) {
        this.f = f;
    }

    @Override
    public String toString() {
        return "Power{" +
                "ai=" + ai +
                ", f=" + f +
                '}';
    }
}
