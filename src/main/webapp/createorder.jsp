<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="java.text.SimpleDateFormat" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
            + path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <base href="<%=basePath%>">
    <title>My JSP 'createorder.jsp' starting page</title>
    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0">
    <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
    <meta http-equiv="description" content="This is my page">
    <!--
        <link rel="stylesheet" type="text/css" href="styles.css">
        -->
</head>

<body>

<!-- 定义table,用于创建easy ui的datagrid控件 -->
<table id="odbox"></table>

<!-- 创建datagrid控件的工具栏 -->

<div id="ordertb" style="padding: 2px 5px;">
    <a href="javascript:void(0)" class="easyui-linkbutton"
       iconCls="icon-add" plain="true" onclick="addOrderDetail();">添加订单</a>

    <a href="javascript:void(0)" class="easyui-linkbutton"
        iconCls="icon-save" plain="true" onclick="saveorder();">保存订单</a>

    <a href="javascript:void(0)" class="easyui-linkbutton"
        iconCls="icon-remove" plain="true" onclick="removeOrderDetail();">删除订单明细</a>
</div>

<!-- 创建订单主表录入布局 -->
<div id="divOrderInfo">
    <div style="padding: 3px">
        客户名称&nbsp;<input style="width: 115px;" id="create_uid"
                     class="easyui-combobox" name="create_uid" value="0"
                     data-options="valueField:'id',textField:'userName',url:'userinfo/getValidUser'">&nbsp;&nbsp;&nbsp;

        订单金额&nbsp;<input type="text" name="create_orderprice"
                             id="create_orderprice" class="easyui-textbox" readonly="readonly"
                             style="width: 115px" /> &nbsp;&nbsp;
    </div>
    <div style="padding: 3px">
        订单日期&nbsp;<input type="text" name="create_ordertime"
                             id="create_ordertime" class="easyui-datebox" style="width: 115px"
<%--                             value="<%=new Date().toLocaleString()%>" /> &nbsp;&nbsp;--%>
                             value="<%=new SimpleDateFormat("YYYY-MM-dd").format(new Date())%>" /> &nbsp;&nbsp;
        订单状态&nbsp;
        <select id="create_status" class="easyui-combobox"
                 name="create_status" style="width: 115px;">
        <option value="未付款" selected>未付款</option>
        <option value="已付款">已付款</option>
        <option value="待发货">待发货</option>
        <option value="已发货">已发货</option>
        <option value="已完成">已完成</option>
    </select>
    </div>
</div>

<script type="text/javascript">
    var $odbox = $('#odbox');
    $(function() {
        $odbox.datagrid({
            rownumbers : true,
            singleSelect : false,
            fit : true,
            toolbar : '#ordertb',//把订单放在下方
            header : '#divOrderInfo',//把用户明细方在上方
            columns : [ [ {
                title : '序号',
                field : '',
                align : 'center',
                checkbox : true
            }, {
                field : 'pid',
                title : '商品名称',
                width : 300,
                editor : {
                    type : 'combobox',
                    options : {//下拉菜单
                        valueField : 'id',
                        textField : 'name',
                        url : 'productinfo/getOnSaleProduct',

                        //当下拉菜单的数据发生改变后
                        onChange: function (newValue, oldValue) {

                            var rows = $odbox.datagrid('getRows');
                            var orderprice=0;
                            for (var i = 0; i < rows.length; i++) {
                                //封装一个以i为键，pid为值的对象
                                var pidEd = $('#odbox').datagrid('getEditor', {
                                    index: i,
                                    field: 'pid'
                                });
                                var priceEd = $('#odbox').datagrid('getEditor', {
                                    index: i,
                                    field: 'price'
                                });
                                var totalpriceEd = $('#odbox').datagrid('getEditor', {
                                    index: i,
                                    field: 'totalprice'
                                });
                                var numEd = $('#odbox').datagrid('getEditor', {
                                    index: i,
                                    field: 'num'
                                });

                                if (pidEd != null){//pidEd是商品名称那一列
                                    var pid=$(pidEd.target).combobox('getValue');//拿到产品id

                                    $.ajax({
                                        type: 'POST',
                                        url: 'productinfo/getPriceById',
                                        data: {pid : pid},//看似是请求体，但通过浏览器发f12发现是表单提交
                                        success:  function(result) {
                                            $(priceEd.target).numberbox('setValue',result);//给单价这个框填入查询出的值
                                            $(totalpriceEd.target).numberbox('setValue',result * $(numEd.target).numberbox('getValue'));//单价乘数量的值得到的总值给总计框
                                            orderprice=Number(orderprice)+Number($(totalpriceEd.target).numberbox('getValue'));//求总值（把各行的totalprice加起来）
                                        },
                                        dataType: 'json',
                                        async : false
                                    });
                                }
                            }
                            $("#create_orderprice").textbox("setValue",orderprice);
                        }
                    }
                }
            }, {
                field : 'price',
                title : '单价',
                width : 80,
                editor: {
                    type : "numberbox",
                    options: {
                        editable : false
                    }
                }
            } , {
                field : 'num',
                title : '数量',
                width : 50,
                editor : {
                    type : 'numberbox',
                    options :{
                        onChange: function (newValue, oldValue) {

                            var rows = $odbox.datagrid('getRows');
                            var orderprice=0;
                            for (var i = 0; i < rows.length; i++) {
                                var priceEd = $('#odbox').datagrid('getEditor', {
                                    index: i,
                                    field: 'price'
                                });
                                var totalpriceEd = $('#odbox').datagrid('getEditor', {
                                    index: i,
                                    field: 'totalprice'
                                });
                                var numEd = $('#odbox').datagrid('getEditor', {
                                    index: i,
                                    field: 'num'
                                });
                                $(totalpriceEd.target).numberbox('setValue',$(priceEd.target).numberbox('getValue') * $(numEd.target).numberbox('getValue'));
                                orderprice=Number(orderprice)+Number($(totalpriceEd.target).numberbox('getValue'));
                            }
                            $("#create_orderprice").textbox("setValue",orderprice);
                        }
                    }
                }
            }, {
                field : 'totalprice',
                title : '小计',
                width : 100,
                editor: {
                    type : "numberbox",
                    options: {
                        editable : false
                    }
                }
            }  ] ]
        });
    });

    // datagrid中添加记录行
    function addOrderDetail() {
        $odbox.datagrid('appendRow', {
            num : '1',
            price : '0',
            totalprice : '0'
        });
        var rows = $odbox.datagrid('getRows');
        // 让添加的行处于可编辑状态
        $odbox.datagrid('beginEdit', rows.length - 1);
    }

    // datagrid中删除记录行
    function removeOrderDetail() {
        // 获取所选择的行记录
        var rows = $odbox.datagrid('getSelections');
        if (rows.length > 0) {
            // 获取“订单金额”文本域的值
            var create_orderprice =  $("#create_orderprice").textbox("getValue");
            // 遍历选中的行记录，以更新订单金额
            for (var i = 0; i < rows.length; i++) {
                var index = $odbox.datagrid('getRowIndex', rows[i]);
                var totalpriceEd = $('#odbox').datagrid('getEditor', {
                    index: index,
                    field: 'totalprice'
                });
                create_orderprice = create_orderprice - Number($(totalpriceEd.target).numberbox('getValue'));
                $odbox.datagrid('deleteRow', index);
            }
            $("#create_orderprice").textbox("setValue",create_orderprice);
        } else {
            $.messager.alert('提示', '请选择要删除的行', 'info');
        }
    }

    // 保存订单
    function saveorder() {
        // 获取订单客户
        var uid = $("#create_uid").combobox("getValue");
        if(uid==0){
            $.messager.alert('提示', '请选择客户名称', 'info');
        } else {
            // 取消datagrid控件的行编辑状态
            create_endEdit();
            // 定义orderinfo存放订单主表数据
            var orderinfo = [];
            // 获取订单时间
            var ordertime = $("#create_ordertime").datebox("getValue");
            // 获取订单状态
            var status = $("#create_status").combobox("getValue");
            // 获取订单金额
            var orderprice = $("#create_orderprice").textbox("getValue");
            orderinfo.push({
                ordertime : ordertime,
                uid : uid,
                status : status,
                orderprice : orderprice
            });
            // 获取订单明细（即datagrid控件中的记录）
            if ($odbox.datagrid('getChanges').length) {
                // 获取datagrid控件中插入的记录行
                var inserted = $odbox.datagrid('getChanges', "inserted");
                // 获取datagrid控件中删除的记录行
                var deleted = $odbox.datagrid('getChanges', "deleted");
                // 获取datagrid控件中更新的记录行
                var updated = $odbox.datagrid('getChanges', "updated");
                // 定义effectRow,保存inserted和orderinfo
                var effectRow = new Object();
                if (inserted.length) {
                    effectRow["inserted"] = JSON.stringify(inserted);
                }
                effectRow["orderinfo"] = JSON.stringify(orderinfo);
                // 提交请求
                $.post(//不是axios
                    "orderinfo/commitOrder",
                    effectRow,
                    function(data) {
                        if (data == 'success') {
                            $.messager.alert("提示", "创建成功！");
                            $odbox.datagrid('acceptChanges');
                            if ($('#tabs').tabs('exists', '创建订单')) {
                                $('#tabs').tabs('close', '创建订单');
                            }
                            $("#orderDg").datagrid('reload');//查询订单
                        } else {
                            $.messager.alert("提示", "创建失败！");
                        }
                    });
            }
        }

    }

    // 取消datagrid控件的行编辑状态
    function create_endEdit() {
        var rows = $odbox.datagrid('getRows');
        for (var i = 0; i < rows.length; i++) {
            $odbox.datagrid('endEdit', i);
        }
    }
</script>

</body>
</html>
