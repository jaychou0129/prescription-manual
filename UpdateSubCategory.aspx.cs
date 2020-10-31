using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PrescriptionManual
{
    public partial class UpdateSubCategory : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void lbInsert_Click(object sender, EventArgs e)
        {
            SqlDataSource1.InsertParameters["MSubCategoryID"].DefaultValue =
                ((TextBox)GridView1.FooterRow.FindControl("tbSubCategoryID")).Text;
            SqlDataSource1.InsertParameters["MSubCategoryName"].DefaultValue =
                ((TextBox)GridView1.FooterRow.FindControl("tbSubCategoryName")).Text;
            SqlDataSource1.Insert();
        }
    }
}