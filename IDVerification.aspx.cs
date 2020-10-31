using PrescriptionManual.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PrescriptionManual
{
    public partial class IDVerification : System.Web.UI.Page
    {
        int cat, subcat, originalID;
        protected void Page_Load(object sender, EventArgs e)
        {
            cat = Convert.ToInt32(Request.QueryString["category"]);
            subcat = Convert.ToInt32(Request.QueryString["subcategory"]);
            int id = Convert.ToInt32(Request.QueryString["id"]);
            originalID = Request.QueryString["originalID"] != "" ? Convert.ToInt32(Request.QueryString["originalID"]) : 0;
            CheckExisted(id);
            CheckIDOutOfRange(id);
        }
        protected void CheckIDOutOfRange(int id)
        {
            var left = (subcat == 0) ? cat : subcat;
            var right = GetRightBoundary(left);
            if (id <= left || id >= right)
            {
                Response.Write("藥品編號與類別不符！\n\r");
            }
        }
        protected int GetRightBoundary(int left)
        {
            if (left % 100 == 0) return left + 100;
            var _db = new PrescriptionManual.Models.MedicineContext();
            IQueryable<MSubCategory> query = _db.MSubCategories;
            query = query.OrderBy(MSubCategory => MSubCategory.MSubCategoryID);
            query = from q in query
                    where q.MSubCategoryID > left
                    select q;
            if (query.Count() == 0 || query.First().MSubCategoryID / 100 != left / 100) return ((int)((left + 100)/100)) * 100; // If the next subcategory is in a different category
            else return query.First().MSubCategoryID;
        }
        protected void CheckExisted(int id)
        {
            var result = SearchMedicineById(id);
            if (result.Count() != 0 && id != originalID)
            {
                Response.Write("此藥物編號已被" + result.First().Name + "使用！\n\r");
            }
        }
        public IQueryable<Medicine> SearchMedicineById(int ID)
        {
            var _db = new PrescriptionManual.Models.MedicineContext();
            IQueryable<Medicine> query = _db.Medicines;
            var result = from q in query
                         where q.ID == ID
                         select q;
            return result;
        }
    }
}