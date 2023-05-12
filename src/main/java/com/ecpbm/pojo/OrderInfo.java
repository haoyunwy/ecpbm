package com.ecpbm.pojo;
//封装订单信息
public class OrderInfo {
    private Integer id;
    private int uid;
    private UserInfo ui;
    private String status;
    private String ordertime;
    private double orderprice;
    private String orderTimeFrom;
    private String orderTimeTo;

    public OrderInfo() {
    }

    public OrderInfo(Integer id, int uid, UserInfo ui, String status, String ordertime, double orderprice, String orderTimeFrom, String orderTimeTo) {
        this.id = id;
        this.uid = uid;
        this.ui = ui;
        this.status = status;
        this.ordertime = ordertime;
        this.orderprice = orderprice;
        this.orderTimeFrom = orderTimeFrom;
        this.orderTimeTo = orderTimeTo;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public int getUid() {
        return uid;
    }

    public void setUid(int uid) {
        this.uid = uid;
    }

    public UserInfo getUi() {
        return ui;
    }

    public void setUi(UserInfo ui) {
        this.ui = ui;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getOrdertime() {
        return ordertime;
    }

    public void setOrdertime(String ordertime) {
        this.ordertime = ordertime;
    }

    public double getOrderprice() {
        return orderprice;
    }

    public void setOrderprice(double orderprice) {
        this.orderprice = orderprice;
    }

    public String getOrderTimeFrom() {
        return orderTimeFrom;
    }

    public void setOrderTimeFrom(String orderTimeFrom) {
        this.orderTimeFrom = orderTimeFrom;
    }

    public String getOrderTimeTo() {
        return orderTimeTo;
    }

    public void setOrderTimeTo(String orderTimeTo) {
        this.orderTimeTo = orderTimeTo;
    }

    @Override
    public String toString() {
        return "OrderInfo{" +
                "id=" + id +
                ", uid=" + uid +
                ", ui=" + ui +
                ", status='" + status + '\'' +
                ", ordertime='" + ordertime + '\'' +
                ", orderprice=" + orderprice +
                ", orderTimeFrom='" + orderTimeFrom + '\'' +
                ", orderTimeTo='" + orderTimeTo + '\'' +
                '}';
    }
}
