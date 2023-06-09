<%@ page language="java" import="java.util.*" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%
    if (session.getAttribute("admin") == null)
        response.sendRedirect("/ecpbm/admin_login.jsp");
%>

<html>
<head>

    <title>后台管理首页面</title>
    <link href="EasyUI/themes/default/easyui.css" rel="stylesheet"
          type="text/css" />
    <link href="EasyUI/themes/icon.css" rel="stylesheet" type="text/css" />
    <link href="EasyUI/demo/demo.css" rel="stylesheet" type="text/css" />
    <script src="EasyUI/jquery.min.js" type="text/javascript"></script>
    <script src="EasyUI/jquery.easyui.min.js" type="text/javascript"></script>
    <script src="EasyUI/easyui-lang-zh_CN.js" type="text/javascript"></script>
</head>

<body class="easyui-layout">
<%--<div data-options="region:'north',border:false"--%>
<%--     style="height: 60px; background: #B3DFDA; padding: 10px">--%>
<%--    <div align="left">--%>
<%--        <div style="font-family: Microsoft YaHei; font-size: 16px;">电商平台后台管理系统</div>--%>
<%--    </div>--%>
<%--    <div align="right">--%>
<%--        <font color="#00008b">${sessionScope.admin.name}的管理空间</font>--%>
<%--    </div>--%>
<%--</div>--%>
<div data-options="region:'west',split:true,title:'功能菜单'"
     style="width: 180px">
    <ul id="tt"></ul>
</div>
<div data-options="region:'south',border:false"
     style="height:30px; background: #A9FACD; padding: 10px; text-align: center">五月雨</div>
<div data-options="region:'center'">
    <div id="tabs" data-options="fit:true" class="easyui-tabs"
         style="width: 500px; height: 250px;"></div>
</div>
<script type="text/javascript">
    // 为tree指定数据
    $('#tt').tree({
        url : 'admininfo/getTree?adminid=${sessionScope.admin.id}'
    });
    $('#tt').tree({
        onClick : function(nodee) {
            if ("商品列表" == nodee.text) {
                if ($('#tabs').tabs('exists', '商品列表')) {
                    $('#tabs').tabs('select', '商品列表');
                } else {
                    $('#tabs').tabs('add', {
                        title : nodee.text,
                        href : 'productlist.jsp',
                        closable : true
                    });
                }
            } else if ("商品类型列表" == nodee.text) {
                if ($('#tabs').tabs('exists', '商品类型列表')) {
                    $('#tabs').tabs('select', '商品类型列表');
                } else {
                    $('#tabs').tabs('add', {
                        title : nodee.text,
                        href : 'typelist.jsp',
                        closable : true
                    });
                }
            } else if ("查询订单" == nodee.text) {
                if ($('#tabs').tabs('exists', '查询订单')) {
                    $('#tabs').tabs('select', '查询订单');
                } else {
                    $('#tabs').tabs('add', {
                        title : nodee.text,
                        href : 'searchorder.jsp',
                        closable : true
                    });
                }
            } else if ("创建订单" == nodee.text) {
                if ($('#tabs').tabs('exists', '创建订单')) {
                    $('#tabs').tabs('select', '创建订单');
                } else {
                    $('#tabs').tabs('add', {
                        title : nodee.text,
                        href : 'createorder.jsp',
                        closable : true
                    });
                }
            } else if ("客户列表" == nodee.text) {
                if ($('#tabs').tabs('exists', '客户列表')) {
                    $('#tabs').tabs('select', '客户列表');
                } else {
                    $('#tabs').tabs('add', {
                        title : nodee.text,
                        href : 'userlist.jsp',
                        closable : true
                    });
                }
            } else if ("退出系统" == nodee.text) {
                $.ajax({
                    url : 'admininfo/logout',
                    success : function(data) {
                        window.location.href = "admin_login.jsp";
                    }
                })
            }
        }
    });
</script>
</body>
</html>
