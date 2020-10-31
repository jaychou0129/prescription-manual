using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using PrescriptionManual.Models;

namespace PrescriptionManual
{
    public partial class View : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        public IQueryable<MCategory> GetMCategories()
        {
            var _db = new PrescriptionManual.Models.MedicineContext();
            IQueryable<MCategory> query = _db.MCategories;
            query = query.OrderBy(MCategory => MCategory.MCategoryID);
            return query;
        }

        public IQueryable<MSubCategory> GetMSubCategories(int lower_bound, int upper_bound)
        {
            var _db = new PrescriptionManual.Models.MedicineContext();
            IQueryable<MSubCategory> query = _db.MSubCategories;
            query = query.OrderBy(MSubCategory => MSubCategory.MSubCategoryID);
            List<MSubCategory> result = new List<MSubCategory>();
            foreach(var SubItem in query)
            {
                if (SubItem.MSubCategoryID < lower_bound || SubItem.MSubCategoryID > upper_bound) continue;
                result.Add(SubItem);
            }
            return result.AsQueryable<MSubCategory>();
        }

        public IQueryable<Medicine> GetMedicine(int CategoryID, int SubCategoryID)
        {
            var _db = new PrescriptionManual.Models.MedicineContext();
            IQueryable<Medicine> query = _db.Medicines;
            query = query.OrderBy(Medicine => Medicine.ID);
            List<Medicine> result = new List<Medicine>();
            foreach(var Medicine in query)
            {
                if (Medicine.MCategoryID != CategoryID || Medicine.MSubCategoryID != SubCategoryID) continue;
                result.Add(Medicine);
            }
            return result.AsQueryable<Medicine>();
        }

        public IQueryable<Medicine> GetMedicine(int CategoryID)
        {
            var _db = new PrescriptionManual.Models.MedicineContext();
            IQueryable<Medicine> query = _db.Medicines;
            query = query.OrderBy(Medicine => Medicine.ID);
            List<Medicine> result = new List<Medicine>();
            foreach (var Medicine in query)
            {
                if (Medicine.MCategoryID != CategoryID) continue;
                result.Add(Medicine);
            }
            return result.AsQueryable<Medicine>();
        }

        public void PrintCategory(MCategory Item)
        {
            var ID = (Item.MCategoryID.ToString().Length == 3) ? "0" + Item.MCategoryID.ToString() : Item.MCategoryID.ToString();
            var Name = Item.MCategoryName;
            Response.Write("<li class='description bold'>" + ID + ". " + Name);
        }

        public void PrintSubCategory(MSubCategory Item)
        {
            var SubID = (Item.MSubCategoryID.ToString().Length == 3) ? "0" + Item.MSubCategoryID.ToString() : Item.MSubCategoryID.ToString();
            var SubName = Item.MSubCategoryName;
            Response.Write("<li>" + SubID + ". " + SubName);
        }

        public void PrintMedicine(Medicine Item)
        {
            var MedID = (Item.ID.ToString().Length == 3) ? "0" + Item.ID.ToString() : Item.ID.ToString();
            var MedName = Item.Name;
            var MedSubName = Item.DF_subname.Replace("\\", ", ");
            MedSubName = (MedSubName == "" || MedSubName == " ") ? "" : "(" + MedSubName + ")";
            Response.Write("<li><a target='_blank' href='ViewMedicine.aspx?id=" + Item.ID + "'>" + MedID + ". " + MedName + " " + MedSubName + "</a></li>");
        }
    }
}