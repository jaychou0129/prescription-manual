using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using PrescriptionManual.Models;

namespace PrescriptionManual
{
    public partial class ViewMedicine : System.Web.UI.Page
    {
        public Medicine Medi;
        public MCategory Category;
        public MSubCategory SubCategory;

        public List<string> DF_mID, DF_subname, DF_subname2, DF_dosage, DF_form, DF_note;
        protected void Page_Load(object sender, EventArgs e)
        {
            string query_ID = (Request.QueryString["id"] == null) ? null : Request.QueryString["id"].ToString();
            int search_id;
            bool isNumeric = int.TryParse(query_ID, out search_id); // will successfully parse if search_name is in fact an int
            if (query_ID == null || query_ID == "" || !isNumeric)
            {
                Response.Redirect("Search.aspx");
            }
            
            Medi = GetMedicineById(search_id);
            if (Medi == null) // Medicine does not exist
            {
                Response.Redirect("Search.aspx");
            }
            else
            {
                Category = GetMCategoryById(Medi.MCategoryID);
                SubCategory = GetMSubCategoryById(Medi.MSubCategoryID);


                DF_mID = Medi.DF_mID.Split('\\').ToList();
                DF_subname = Medi.DF_subname.Split('\\').ToList();
                DF_subname2 = Medi.DF_subname2.Split('\\').ToList();
                DF_dosage = Medi.DF_dosage.Split('\\').ToList();
                DF_form = Medi.DF_form.Split('\\').ToList();
                DF_note = Medi.DF_note.Split('\\').ToList();
            }
        }

        public Medicine GetMedicineById(int ID)
        {
            var _db = new PrescriptionManual.Models.MedicineContext();
            IQueryable<Medicine> query = _db.Medicines;
            var result = from q in query
                         where q.ID == ID
                         select q;
            if (result.Count() != 0) return result.First();
            return null;
        }

        public MCategory GetMCategoryById(int ID)
        {
            var _db = new PrescriptionManual.Models.MedicineContext();
            IQueryable<MCategory> query = _db.MCategories;
            var result = from q in query
                         where q.MCategoryID == ID
                         select q;
            if (result.Count() != 0) return result.First();
            return null;
        }

        public MSubCategory GetMSubCategoryById(int ID)
        {
            var _db = new PrescriptionManual.Models.MedicineContext();
            IQueryable<MSubCategory> query = _db.MSubCategories;
            var result = from q in query
                         where q.MSubCategoryID == ID
                         select q;
            if(result.Count() != 0) return result.First();
            return null;
        }
    }
}