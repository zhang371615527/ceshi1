using DotNet.IService.Permission;
using DotNet.Model.Entities.Table;
using DotNet.ServiceFactory;
using DotNet.Utilities.Message;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DotNet.WebFrom.Admin
{
    public partial class Main : System.Web.UI.Page
    {
        public string UserName = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                GetLgUser();
            }
        }

	private void GetLgUser123()
        {
            
        }

        private void GetLgUser()
        {
            if (Session[Config.SessionName] != null && !String.IsNullOrEmpty(Session[Config.SessionName].ToString()))
            {
                Sys_UserInfoEntity UserInfoEntity = (Sys_UserInfoEntity)Session[Config.User];
                UserName = UserInfoEntity.UserName;
            }
            else
            {
                //MessageBox.ShowMessage(this, "用户登录超时！"); 
                Response.Write("<script language='javascript'>alert('用户登录超时！');</script>");
                Response.Write("<script language='javascript'>window.location.href = 'Login.aspx';</script>");
                //Response.Redirect("Login.aspx");
            }
        }

    }
}