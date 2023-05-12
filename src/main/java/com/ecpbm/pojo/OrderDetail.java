package com.ecpbm.pojo;
//用于封装订单明细信息
public class OrderDetail {
    private int id;
    private int oid;
    private OrderInfo oi;
    private int pid;
    private ProductInfo pi;
    private int num;
    private double price;
    private double totalprice;

    public OrderDetail() {
    }

    public OrderDetail(int id, int oid, OrderInfo oi, int pid, ProductInfo pi, int num, double price, double totalprice) {
        this.id = id;
        this.oid = oid;
        this.oi = oi;
        this.pid = pid;
        this.pi = pi;
        this.num = num;
        this.price = price;
        this.totalprice = totalprice;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getOid() {
        return oid;
    }

    public void setOid(int oid) {
        this.oid = oid;
    }

    public OrderInfo getOi() {
        return oi;
    }

    public void setOi(OrderInfo oi) {
        this.oi = oi;
    }

    public int getPid() {
        return pid;
    }

    public void setPid(int pid) {
        this.pid = pid;
    }

    public ProductInfo getPi() {
        return pi;
    }

    public void setPi(ProductInfo pi) {
        this.pi = pi;
    }

    public int getNum() {
        return num;
    }

    public void setNum(int num) {
        this.num = num;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public double getTotalprice() {
        return totalprice;
    }

    public void setTotalprice(double totalprice) {
        this.totalprice = totalprice;
    }

    @Override
    public String toString() {
        return "OrderDetail{" +
                "id=" + id +
                ", oid=" + oid +
                ", oi=" + oi +
                ", pid=" + pid +
                ", pi=" + pi +
                ", num=" + num +
                ", price=" + price +
                ", totalprice=" + totalprice +
                '}';
    }
}
