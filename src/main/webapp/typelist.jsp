<%--
  Created by IntelliJ IDEA.
  User: ASUS
  Date: 2023/3/17
  Time: 15:44
  To change this template use File | Settings | File Templates.
--%>
<%--商品类型列表页--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>商品类型列表页面</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <link href="EasyUI/themes/default/easyui.css" rel="stylesheet" type="text/css" />
    <link href="EasyUI/themes/icon.css" rel="stylesheet" type="text/css" />
    <link href="EasyUI/demo/demo.css" rel="stylesheet" type="text/css" />
    <script src="EasyUI/jquery.min.js" type="text/javascript"></script>
    <script src="EasyUI/jquery.easyui.min.js" type="text/javascript"></script>
    <script src="EasyUI/easyui-lang-zh_CN.js" type="text/javascript"></script>
</head>
<body>
<table id="dg_Type" class="easyui-datagrid"></table>
<!-- 创建datagrid控件的工具栏 -->
<div id="tb_type" style="padding: 2px 5px;">
    <a href="javascript:void(0)" class="easyui-linkbutton"
       iconCls="icon-add" plain="true" onclick="addType();">添加</a>

    <a ref="javascript:void(0)" class="easyui-linkbutton"
       iconCls="icon-edit" plain="true" onclick="editType();">更新</a>

    <a href="javascript:void(0)" class="easyui-linkbutton"
       iconCls="icon-remove" onclick="deleteType();" plain="true">删除</a>

<%--    添加--%>
    <div id="dlg_type" class="easyui-dialog" title="商品类型"
         closed="true" style="width: 500px;">
        <div style="padding: 10px 60px 20px 60px">
            <%--       如果没有enctype则文件传不过去--%>
            <form id="ff_type" method="post"  enctype="multipart/form-data">
                <table cellpadding="5">

                    </tr>
                    <tr>
                        <td>商品类型:</td>
                        <td><input class="easyui-textbox" type="text" id="name"
                                   name="name" data-options="required:true"></input></td>
                    </tr>
                </table>
            </form>
            <div style="text-align: center; padding: 5px">
                <a href="javascript:void(0)" class="easyui-linkbutton"
                   onclick="saveType();">保存 </a>

                <a href="javascript:void(0)"
                   class="easyui-linkbutton" onclick="clearForm();">清空</a>
            </div>

        </div>

</div>
<script type="text/javascript">
    var urls;
    var data;

    // ----------------------------------------------查询
    $(function() {
        $('#dg_Type').datagrid({
            singleSelect : false, //设置datagrid为支持多选
            url : 'type/getType/0', //为datagrid设置数据源
            pagination : true, //启用分页
            pageSize : 10, //设置初始每页记录数（页大小）
            pageList : [ 10, 15, 20 ], //设置可供选择的页大小
            rownumbers : true, //显示行号
            fit : true, //设置自适应
            toolbar : '#tb_type', //为datagrid添加工具栏

            columns : [ [ { //编辑datagrid的列
                title : '序号',
                field : 'id',
                align : 'center',
                checkbox : true
            }, {
                field : 'name',
                title : '类型名称',
                width : 200
         }
         ] ]
        });
    });
// --------------------------------------------------添加
    function addType() {
        $('#dlg_type').dialog('open').dialog('setTitle', '新增类型');
        $('#dlg_type').form('clear');//每次打开都清空上一次的输入内容
        urls = 'type/addType';
    }

    function saveType() {
        $("#ff_type").form("submit", {
            url : urls, //使用参数
            success : function(result) {
                var result = eval('(' + result + ')');
                if (result.success == 'true') {
                    $("#dg_Type").datagrid("reload");//保存后重新加载数据
                    $("#dlg_type").dialog("close");
                }
                $.messager.show({
                    title : "提示信息",
                    msg : result.message
                });
            }
        });
    }
    // ---------------------------------------------更新

    function clearForm() {
        $('#ff_type').form('clear');
    }

    function editType() {//如果点击修改，则先判断是否有选中
        var rows = $("#dg_Type").datagrid('getSelections');

        if (rows.length > 0) {
            var row = $("#dg_Type").datagrid("getSelected");

            if (row) {
                $("#dlg_type").dialog("open").dialog('setTitle',
                    '修改商品信息');
                $("#ff_type").form("load", {//重新调用form表单
                    //下面的数据是写回表单的内容
                    "name" : row.name,
                });
                urls = "type/updateType?id="+row.id;
            }
        } else {
            $.messager.alert('提示', '请选择要修改的行', 'info');
        }
    }
// ----------------------------------------删除
    function deleteType() {
        var rows = $("#dg_Type").datagrid('getSelections');//所有对象的集合
        if (rows.length > 0) {
            $.messager.confirm('Confirm', '确认要删除么?', function(r) {
                if (r) {
                    var ids = "";
                    for (var i = 0; i < rows.length; i++) {//为多选
                        ids += rows[i].id + ",";//每个对象的id拼接成字符串
                    }
                    $.post('type/deleteType', {//请求体
                            id : ids,
                        },
                        function(result) {
                            if (result.success == 'true') {
                                $("#dg_Type").datagrid('reload');
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
    </script>
    </body>
</html>
