<%--<%@ page language="java" import="java.util.*"--%>
<%--         contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <title>商品列表页</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <link href="EasyUI/themes/default/easyui.css" rel="stylesheet" type="text/css" />
    <link href="EasyUI/themes/icon.css" rel="stylesheet" type="text/css" />
    <link href="EasyUI/demo/demo.css" rel="stylesheet" type="text/css" />
    <script src="EasyUI/jquery.min.js" type="text/javascript"></script>
    <script src="EasyUI/jquery.easyui.min.js" type="text/javascript"></script>
    <script src="EasyUI/easyui-lang-zh_CN.js" type="text/javascript"></script>
</head>
<body>
<!-- 定义table, 用于创建easy ui的datagrid控件 -->
<table id="dg_productinfo" class="easyui-datagrid"></table>

<%--<!-- 创建datagrid控件的工具栏 -->--%>
<div id="tb_productinfo" style="padding: 2px 5px;">
    <a href="javascript:void(0)" class="easyui-linkbutton"
       iconCls="icon-add" plain="true" onclick="addProduct();">添加</a>

    <a ref="javascript:void(0)" class="easyui-linkbutton"
       iconCls="icon-edit" plain="true" onclick="editProduct();">修改</a>

    <a href="javascript:void(0)" class="easyui-linkbutton"
       iconCls="icon-remove" onclick="removeProduct();" plain="true">删除</a>
</div>

<!-- 创建查询工具栏 -->
<div id="searchtb_productinfo" style="padding: 2px 5px;">
    <form id="searchForm_productinfo" method="post">
        <div style="padding: 3px">
            编号&nbsp;<input class="easyui-textbox"
                       name="productinfo_search_code" id="productinfo_search_code"
                       style="width: 60px" />



           名称
            <input class="easyui-textbox"
                   name="productinfo_search_name" id="productinfo_search_name"
                   style="width: 60px" />

            类型
            <input
                    style="width: 90px;" id="productinfo_search_tid"
                    class="easyui-combobox" name="productinfo_search_tid"
                    data-options="valueField:'id',textField:'name',url:'type/getType/1'"
                    value="0"/>

           品牌
            <input
                    class="easyui-textbox" name="productinfo_search_brand"
                    id="productinfo_search_brand" style="width:60px" />

            &nbsp;价格:
            <input class="easyui-numberbox"
                   name="productinfo_search_priceFrom"
                   id="productinfo_search_priceFrom" style="width: 30px;" />
            ~ <input
                class="easyui-numberbox" name="productinfo_search_priceTo"
                id="productinfo_search_priceTo" style="width: 30px;" />


            <a href="javascript:void(0)" class="easyui-linkbutton"
               iconCls="icon-search" plain="true" onclick="searchProduct()">查找</a>
        </div>

    </form>

</div>

<%--<!-- 添加商品信息对话框 -->--%>
<div id="dlg_productinfo" class="easyui-dialog" title="添加商品"
     closed="true" style="width: 500px;">
    <div style="padding: 10px 60px 20px 60px">
<%--       如果没有enctype则文件传不过去--%>
        <form id="ff_productinfo" method="post"  enctype="multipart/form-data">
            <table cellpadding="5">
                <tr>
                    <td>商品状态:</td>
                    <td><select id="status" class="easyui-combobox" name="status"
                                style="width: 150px;">
                        <option value="1">在售</option>
                        <option value="0">下架</option>
                    </select></td>
                </tr>
                <tr>
                    <td>商品类型:</td>
                    <td><input style="width: 150px;"
                               id="type.id" class="easyui-combobox"
                               name="type.id"

          data-options="valueField:'id',textField:'name',url:'type/getType/0'">
                    </input>
                    </td>
                </tr>
                <tr>
                    <td>商品名称:</td>
                    <td><input class="easyui-textbox" type="text" id="name"
                               name="name" data-options="required:true"></input></td>
                </tr>
                <tr>
                    <td>商品编码:</td>
                    <td><input class="easyui-textbox" type="text" id="code"
                               name="code" data-options="required:true"></input></td>
                </tr>
                <tr>
                    <td>商品品牌:</td>
                    <td><input class="easyui-textbox" type="text" id="brand"
                               name="brand" data-options="required:true"></input></td>
                </tr>
                <tr>
                    <td>商品数量:</td>
                    <td><input class="easyui-textbox" type="text" id="num"
                               name="num" data-options="required:true"></input></td>
                </tr>
                <tr>
                    <td>商品价格:</td>
                    <td><input class="easyui-textbox" type="text" id="price"
                               name="price" data-options="required:true"></input></td>
                </tr>
                <tr>
                    <td>商品描述:</td>
                    <td><input class="easyui-textbox" name="intro" id="intro"
                               data-options="multiline:true" style="height: 60px"></input></td>
                </tr>
                <tr>
                    <td>商品图片:</td>
                    <td><input class="easyui-filebox" id="file" name="file"
                               style="width: 200px" value="选择图片"></input></td>
                </tr>
            </table>
        </form>
        <div style="text-align: center; padding: 5px">
            <a href="javascript:void(0)" class="easyui-linkbutton"
               onclick="saveProduct();">保存 </a>

            <a href="javascript:void(0)"
               class="easyui-linkbutton" onclick="clearForm();">清空</a>
        </div>
    </div>
</div>
<script type="text/javascript">
    $(function() {
        $('#dg_productinfo').datagrid({
            singleSelect : false, //设置datagrid为支持多选
            url : 'productinfo/list', //为datagrid设置数据源
            pagination : true, //启用分页
            pageSize : 10, //设置初始每页记录数（页大小）
            pageList : [ 10, 15, 20 ], //设置可供选择的页大小
            rownumbers : true, //显示行号
            fit : true, //设置自适应
            toolbar : '#tb_productinfo', //为datagrid添加工具栏
            header : '#searchtb_productinfo', //为datagrid标头添加搜索栏
            columns : [ [ { //编辑datagrid的列
                title : '序号',
                field : 'id',
                align : 'center',
                checkbox : true
            }, {
                field : 'name',
                title : '商品名称',
                width : 200
            }, {

                field : 'type',
                title : '商品类型',
                formatter : function(value, row, index) {
                    if (row.type) {
                        return row.type.name;
                    } else {
                        return value;
                    }
                },
                width : 60
            }, {
                field : 'status',
                title : '商品状态',
                formatter : function(value, row, index) {
                    if (row.status == 1) {
                        return "在售";
                    } else {
                        return "下架";
                    }
                },
                width : 60
            }, {
                field : 'code',
                title : '商品编码',
                width : 100
            }, {
                field : 'brand',
                title : '品牌',
                width : 120
            }, {
                field : 'price',
                title : '价格',
                width : 50
            }, {
                field : 'num',
                title : '库存',
                width : 50
            }, {
                field : 'intro',
                title : '商品描述',
                width : 450
            } ] ]
        });
    });

    var urls;
    var data;

    // 删除商品(商品下架)
    function removeProduct() {
        var rows = $("#dg_productinfo").datagrid('getSelections');//所有对象的集合
        if (rows.length > 0) {
            $.messager.confirm('Confirm', '确认要删除么?', function(r) {
                if (r) {
                    var ids = "";
                    for (var i = 0; i < rows.length; i++) {//为多选
                        ids += rows[i].id + ",";//每个对象的id拼接成字符串
                    }
                    $.post('productinfo/deleteProduct', {//请求体
                        id : ids,
                        flag : 0
                    },
                        function(result) {
                        if (result.success == 'true') {
                            $("#dg_productinfo").datagrid('reload');
                            $.messager.show({
                                title : '提示信息',
                                msg : result.message
                            });
                        } else {
                            $.messager.show({
                                title : '提示信息',
                                msg : result.message
                            });
                        }
                    }, 'json');
                }
            });
        } else {
            $.messager.alert('提示', '请选择要删除的行', 'info');
        }
    }

    // 打开新增商品对话框
    function addProduct() {
        $('#dlg_productinfo').dialog('open').dialog('setTitle', '新增商品');
        $('#dlg_productinfo').form('clear');//每次打开都清空上一次的输入内容
          urls = 'productinfo/addProduct';
    }

    <%--    // 保存商品信息--%>
    function saveProduct() {
        $("#ff_productinfo").form("submit", {
            url : urls, //使用参数
            success : function(result) {
                var result = eval('(' + result + ')');
                if (result.success == 'true') {
                    $("#dg_productinfo").datagrid("reload");//保存后重新加载数据
                    $("#dlg_productinfo").dialog("close");
                }
                $.messager.show({
                    title : "提示信息",
                    msg : result.message
                });
            }
        });
    }

    function clearForm() {
       $('#ff_productinfo').form('clear');
    }

    // 打开修改商品对话框(与新增商品对话框共用)
    function editProduct() {
        var rows = $("#dg_productinfo").datagrid('getSelections');

        if (rows.length > 0) {
            var row = $("#dg_productinfo").datagrid("getSelected");

            if (row) {
                $("#dlg_productinfo").dialog("open").dialog('setTitle',
                    '修改商品信息');
                $("#ff_productinfo").form("load", {//重新调用form表单
                    //下面的数据是写回表单的内容
                    "type.id" : row.type.id,
                    "name" : row.name,
                    "code" : row.code,
                    "brand" : row.brand,
                    "num" : row.num,
                    "price" : row.price,
                    "intro" : row.intro,
                    "status" : row.status,
                });
                urls = "productinfo/updateProduct?id=" + row.id;
            }
        } else {
            $.messager.alert('提示', '请选择要修改的行', 'info');
        }
    }

    // 查询商品
    function searchProduct() {
        //拿到编号
        var productinfo_search_code = $('#productinfo_search_code').textbox("getValue");
        //拿到商品名
        var productinfo_search_name = $('#productinfo_search_name').textbox("getValue");
        //商品类型
        var productinfo_search_tid = $('#productinfo_search_tid').combobox("getValue");
        //商品品牌
        var productinfo_search_brand = $('#productinfo_search_brand').textbox("getValue");
        //商品价格 最低
        var productinfo_search_priceFrom;
        if ($("#productinfo_search_priceFrom").val() != null && $("#productinfo_search_priceFrom").val() != "") {
            productinfo_search_priceFrom = $('#productinfo_search_priceFrom').textbox("getValue");
        } else {
            productinfo_search_priceFrom = "0";
        }
        //商品价格 最高
        var productinfo_search_priceTo;
        if ($("#productinfo_search_priceTo").val() != null && $("#productinfo_search_priceTo").val() != "") {
            productinfo_search_priceTo = $('#productinfo_search_priceTo').textbox("getValue");
        } else {
            productinfo_search_priceTo = "0";
        }
        $("#dg_productinfo").datagrid('load', {//此处的load等价于productinfo/list,表名datagrid是同一个
            //下面这些都是请求参数
            "code" : productinfo_search_code,
            "name" : productinfo_search_name,
            "type.id" : productinfo_search_tid,
            "brand" : productinfo_search_brand,
            "priceFrom" : productinfo_search_priceFrom,
            "priceTo" : productinfo_search_priceTo
        });
    }
</script>
</body>
</html>