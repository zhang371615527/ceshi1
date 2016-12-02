<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TaskToDo.aspx.cs" Inherits="DotNet.WebFrom.Admin.TaskToDo" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>聊城电厂网站后台管理系统</title>
    <meta http-equiv="X-UA-Compatible" content="IE=8" />
    <link href="../Resource/css/admin/main.css" rel="stylesheet" />
    <script src="../Resource/js/miniUI/boot.js"></script>
     <style type="text/css">   
        .Audit_Button
        {
            font-size:12px;color:#1B3F91;font-family:Verdana;  
            margin-right:5px;            
        }         
    </style>               
</head>
<body>
        <table border="0" cellpadding="10" cellspacing="2" style="width: 100%; table-layout: fixed;">
            <tr>
                <td>
                    <div id="panel1" class="mini-panel" title="待办事项" iconcls="icon-user" style="width: 100%;
                        height: 350px;" ><input id="UserId" name="UserId" class="mini-hidden" />                        
                        <!-- 数据区域 -->
                        <div class="mini-fit">
                            <div id="datagrid1" class="mini-datagrid" style="width:100%;height:100%;" 
                                url="../Services/FlowService.aspx?method=GetTaskToDoListByPage" showEmptyText="true" emptyText="<span style='width:100%; color:Red; margin-left:35%;'>您暂时没有待办事项。</span>"
                                multiSelect="true" sizelist="[5,10,20,50]" pagesize="10" sortField="CreateTime" sortOrder="desc">
                                <div property="columns">
                                    <div type="indexcolumn" width="4"></div>
                                    <div field="StepName" headeralign="center" allowsort="true" width="20">步骤名称</div>
                                    <div field="TaskName" headeralign="center" allowsort="true" width="25">标题</div>
                                    <div field="CreateTime" headeralign="center" allowsort="true" width="20" dateFormat="yyyy-MM-dd">时间</div>
                                    <div name="action" headerAlign="center" align="center" width="10" renderer="onActionRenderer" cellStyle="padding:0;">操作</div>
                                </div>
                            </div>
                        </div>
                    </div>
                </td>
                <td>
                    <div id="panel2" class="mini-panel" title="日历" iconcls="icon-date" style="width: 100%;
                        height: 350px;" >
                        <div id="calendar1" showTime="true" showClearButton="false"  class="mini-calendar" style=" width:100%; height:100%;"></div>
                    </div>
                </td>
            </tr>
            <tr>
                <td colspan="2">
                </td>
            </tr>
        </table>
</body>
<script type="text/javascript">
    mini.parse();
    mini.get("calendar1").setValue(new Date());
    var grid = mini.get("datagrid1");
    var UserID = "<%=UserID%>";
    if((UserID != null && UserID != 'null' && UserID != 'undefined' && UserID != ""))
    {
         //mini.get("UserID").setValue(UserID);
          //填充数据
          var data = { UserID: UserID};
          var json = mini.encode(data);
         grid.load({ condition: json });
     }
    else
    {
        mini.alert("用户登录超时，请重新登录！");
    }

     function onActionRenderer(e) {
         var grid = e.sender;
         var record = e.record;
         var uid = record._uid;
         var rowIndex = e.rowIndex;
         var url = record.StepUrl + "?module=" + record.ModuleId + "&id=" + record.TaskId;
         var height = record.Height;
         var width = record.Width;
         var s = '<a class="Audit_Button" href="javascript:void(0)" onclick="Audit(\'' + url + '\',\'' + height + '\',\'' + width + '\');return false;">审核</a>';

         return s;
     }

     function Audit(Url, Height, Width) {
         mini.open({
             url: Url,
             title: "流程审批",
             width: Width,
             height: Height,
             showMaxButton: false,
             onload: function () {               //弹出页面加载完成
             },
             ondestroy: function (action) {      //弹出页面关闭
                 grid.reload();
             }
         });
     }

    var WinAlerts = window.alert;
    window.alert = function (e) {
        if (e != null && e.indexOf("试用到期") > -1) { }
        else { WinAlerts(e); }
    };
</script>
</html>
