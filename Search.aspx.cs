using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Windows.Forms;
using PrescriptionManual.Models;

namespace PrescriptionManual
{
    public partial class Search : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                var bs = new BindingSource();
                bs.Add("不限");
                foreach(var Item in GetAllCategories()){
                    var MCategoryID = (Item.MCategoryID.ToString().Length == 3) ? "0" + Item.MCategoryID.ToString() : Item.MCategoryID.ToString();
                    bs.Add(MCategoryID + ". " + Item.MCategoryName);
                }
                category_select.DataSource = bs; 
                category_select.DataBind();

                bs = new BindingSource();
                bs.Add("不限");
                foreach (var Item in GetAllSubCategories())
                {
                    var MSubCategoryID = (Item.MSubCategoryID.ToString().Length == 3) ? "0" + Item.MSubCategoryID.ToString() : Item.MSubCategoryID.ToString();
                    bs.Add(MSubCategoryID + ". " + Item.MSubCategoryName);
                }
                subcategory_select.DataSource = bs;
                subcategory_select.DataBind();
            }
            if (category_select.Value!="不限" || subcategory_select.Value != "不限" || searchbar.Text != "")
            {
                RunSearch();
            }
        }
        protected void SearchBtn_Clicked(object sender, EventArgs e)
        {
            if (category_select.Value != "不限" || subcategory_select.Value != "不限" || searchbar.Text != "")
            {
                RunSearch();
            }
        }
        protected void RunSearch()
        {
            int category = (category_select.Value == "不限") ? 0 : Convert.ToInt32(category_select.Value.Substring(0, 4));
            int subcategory = (subcategory_select.Value == "不限") ? 0 : Convert.ToInt32(subcategory_select.Value.Substring(0, 4));
            string search_name = searchbar.Text;
            var result = SearchMedicine(category, subcategory, search_name);
            if (result.Count() == 0)
            {
                result_div.InnerHtml = "<div class='mx-auto'><h1>查無結果！請確認名稱/類別皆正確</h1></div>";
            }
            else
            {
                result_div.InnerHtml = "<h3>共找到" + result.Count() + "筆結果！</h3>";
                foreach (var Item in result)
                {
                    var shortID = Item.ID.ToString();
                    var fullID = shortID.Length == 3 ? "0" + Item.ID.ToString() : Item.ID.ToString();
                    if (result.Count() == 1)
                    {
                        Response.Redirect("ViewMedicine.aspx?id=" + shortID);
                    }
                    result_div.InnerHtml += ("<p class='description'><a href='ViewMedicine.aspx?id="+shortID+"'>" + fullID + ". " + Item.Name);
                    if (Item.DF_subname != null && Item.DF_subname != "" && Item.DF_subname != " ")
                    {
                        result_div.InnerHtml += ("(" + Item.DF_subname.Replace("\\", ", ") + ")");
                    }
                    result_div.InnerHtml += "</a></p>";
                }
            }
        }

        public IQueryable<MCategory> GetAllCategories()
        {
            var _db = new PrescriptionManual.Models.MedicineContext();
            IQueryable<MCategory> query = _db.MCategories;
            query = query.OrderBy(MCategory => MCategory.MCategoryID);
            return query;
        }

        public IQueryable<MSubCategory> GetAllSubCategories()
        {
            var _db = new PrescriptionManual.Models.MedicineContext();
            IQueryable<MSubCategory> query = _db.MSubCategories;
            query = query.OrderBy(MSubCategory => MSubCategory.MSubCategoryID);
            return query;
        }

        public IQueryable<Medicine> SearchMedicine(int Category, int SubCategory, string Name)
        {
            var _db = new PrescriptionManual.Models.MedicineContext();
            IQueryable<Medicine> query = _db.Medicines;
            var result = from q in query
                     where q.DF_subname.Contains(Name) || q.DF_subname2.Contains(Name) || q.Name.Contains(Name) || q.Name2.Contains(Name) || q.DF_mID.Contains(Name) || q.ID.ToString().Contains(Name) || Name.Contains(q.ID.ToString())
                     orderby q.ID
                     select q;
            if (Category != 0)
            {
                result = from q in result
                         where q.MCategoryID == Category
                         orderby q.ID
                         select q;
            }
            if (SubCategory != 0)
            {
                result = from q in result
                         where q.MSubCategoryID == SubCategory
                         orderby q.ID
                         select q;
            }
            return result;
        }
    }
}