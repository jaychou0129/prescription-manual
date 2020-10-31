using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using PrescriptionManual.Models;

namespace PrescriptionManual
{
    public partial class UpdateCategory : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void lbInsert_Click(object sender, EventArgs e)
        {
            SqlDataSource1.InsertParameters["MCategoryID"].DefaultValue =
                ((TextBox)GridView1.FooterRow.FindControl("tbCategoryID")).Text;
            SqlDataSource1.InsertParameters["MCategoryName"].DefaultValue =
                ((TextBox)GridView1.FooterRow.FindControl("tbCategoryName")).Text;
            SqlDataSource1.Insert();
        }
    }
}