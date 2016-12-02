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
    public partial class ModPwd : System.Web.UI.Page
    {
        public string pwd = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                GetPwd();
            }
        }

        private void GetPwd()
        {
            if (Session[Config.SessionName] != null && !String.IsNullOrEmpty(Session[Config.SessionName].ToString()))
            {
                Sys_UserInfoEntity UserInfoEntity = (Sys_UserInfoEntity)Session[Config.User];
                pwd = UserInfoEntity.Password;
            }
        }

    }
}