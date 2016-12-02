using DotNet.IService.Permission;
using DotNet.Model.Entities.Table;
using DotNet.ServiceFactory;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DotNet.WebFrom.Admin
{
    public partial class TaskToDo : System.Web.UI.Page
    {
        public string UserID = "";
        public string UserDeptID = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session[Config.SessionName] != null && !String.IsNullOrEmpty(Session[Config.SessionName].ToString()))
            {
                UserID = Session[Config.SessionName].ToString();
                UserDeptID = Session[Config.SessionDept].ToString();
            }
        }
    }
}