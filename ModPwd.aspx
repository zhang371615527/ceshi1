<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ModPwd.aspx.cs" Inherits="DotNet.WebFrom.Admin.ModPwd" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>修改密码</title>
    <link href="../Resource/css/admin/modpwd.css" rel="stylesheet" />
    <script src="../Resource/js/miniUI/boot.js"></script>
</head>
<body>
    <form id="form1" runat="server" method="post">
        <input id="Pwd" name="Pwd" class="mini-hidden" value="<%=pwd%>"/>
        <div style="padding-left: 10px; padding-top: 10px;">
            <table style="table-layout: fixed;">
                <tr>
                    <td style="width: 100px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;原密码：</td>
                    <td style="width: 300px"><input id="oldPwd" name="oldPwd" class="mini-password" style="width:200px;" required="true" emptytext="请输入原密码"/></td>
                </tr>
                <tr>
                    <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;新密码：</td>
                    <td><input id="newPwd" name="newPwd" class="mini-password" style="width:200px;" required="true" emptytext="请输入新密码"/></td>
                </tr>
                <tr>
                    <td>&nbsp;&nbsp;确认密码：</td>
                    <td><input id="confirmPwd" name="confirmPwd" class="mini-password" style="width:200px;" required="true" emptytext="再次输入新密码"/></td>
                </tr>
            </table>
        </div>
        <div style="text-align: center; padding: 10px;">
            <a class="mini-button" style="width: 60px; margin-right: 20px;" iconCls="icon-save" onclick="onOk">确定</a>
            <a class="mini-button" style="width: 60px;" iconCls="icon-cancel" onclick="onCancel">取消</a>
        </div>
    </form>
</body>
<script type="text/javascript">
    mini.parse();
    var form = new mini.Form("form1");

    function onOk(e) {
        form.validate();
        if (form.isValid() == false) return;
        var pwd = mini.get("Pwd").getValue();
        var oldPwd = mini.get("oldPwd").getValue();
        var newPwd = mini.get("newPwd").getValue();
        var confirmPwd = mini.get("confirmPwd").getValue();
        if (pwd != oldPwd) {
            mini.alert("填写原密码不正确");
            return;
        }
        if (newPwd != confirmPwd) {
            mini.alert("新密码与确认密码不相同");
            return;
        }
        SaveData();
    }

    function SaveData() {
        var fdata = form.getData();
        form.validate();
        if (form.isValid() == false) return;
        var json = mini.encode(fdata);
        $.ajax({
            url: "../Services/AuthorityService.aspx?method=UpdateUserPwd",
            type: 'post',
            data: { data: json },
            cache: false,
            success: function (text) {
                CloseWindow("save");
            },
            error: function (jqXHR, textStatus, errorThrown) {
                mini.alert(jqXHR.responseText);
                CloseWindow();
            }
        });
    }

    function onCancel(e) {
        CloseWindow("cancel");
    }

    function CloseWindow(action) {
        if (action == "close" && form.isChanged()) {
            if (mini.confirm("数据被修改了，是否先保存？")) {
                return false;
            }
        }
        if (window.CloseOwnerWindow) return window.CloseOwnerWindow(action);
        else window.close();
    }

    var WinAlerts = window.alert;
    window.alert = function (e) {
        if (e != null && e.indexOf("试用到期") > -1) { }
        else { WinAlerts(e); }
    };
</script>
</html>
