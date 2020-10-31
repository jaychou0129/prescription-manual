using PrescriptionManual.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Windows.Forms;

namespace PrescriptionManual
{
    public partial class NewMedicine : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            medicineIDControl.InnerHtml = "";
            if (!IsPostBack)
            {
                // fetch data to dropdown if empty
                if (category_select.Items.Count == 0 || subcategory_select.Items.Count == 0)
                {
                    var bs = new BindingSource();
                    foreach (var Item in GetAllCategories())
                    {
                        var MCategoryID = (Item.MCategoryID.ToString().Length == 3) ? "0" + Item.MCategoryID.ToString() : Item.MCategoryID.ToString();
                        bs.Add(MCategoryID + ". " + Item.MCategoryName);
                    }
                    category_select.DataSource = bs;
                    category_select.DataBind();

                    bs = new BindingSource();
                    bs.Add("");
                    foreach (var Item in GetAllSubCategories())
                    {
                        var MSubCategoryID = (Item.MSubCategoryID.ToString().Length == 3) ? "0" + Item.MSubCategoryID.ToString() : Item.MSubCategoryID.ToString();
                        bs.Add(MSubCategoryID + ". " + Item.MSubCategoryName);
                    }
                    if (bs.Count == 0) bs.Add("");
                    subcategory_select.DataSource = bs;
                    subcategory_select.DataBind();
                }

                // preload data if came with "id" parameter in URL
                if (Request.QueryString["id"] != null)
                {
                    string query_ID = Request.QueryString["id"].ToString();
                    int search_id;
                    bool isNumeric = int.TryParse(query_ID, out search_id); // will successfully parse if search_name is in fact an int
                    if (isNumeric)
                    {
                        // Refreshes if ID already used
                        CheckExisted(search_id);

                        medicineID.Text = (search_id.ToString().Length == 3) ? "0" + search_id.ToString() : search_id.ToString();
                    }
                    else
                    {
                        Response.Redirect("NewMedicine.aspx");
                    }
                }

                // preload data if came with "name" parameter in URL
                if (Request.QueryString["name"] != null)
                {
                    medicineName.Text = Request.QueryString["name"].ToString();
                }
            }
        }
        protected void CheckExisted(int id)
        {
            var result = SearchMedicineById(id);
            if (result.Count() != 0)
            {
                medicineIDControl.InnerHtml += "<script>alert('此藥物編號已被" + result.First().Name + "使用！'); $('#medicineID').val(''); $('#medicineID').focus();</script>";
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

        public IQueryable<Medicine> SearchMedicineById(int ID)
        {
            var _db = new PrescriptionManual.Models.MedicineContext();
            IQueryable<Medicine> query = _db.Medicines;
            var result = from q in query
                         where q.ID == ID
                         select q;
            return result;
        }

        protected void InsertMedicine(object sender, EventArgs e)
        {
            if (medicineID.Text == "") Response.Write("<script>alert('請輸入藥品編號！');</script>");
            if (medicineName.Text == "") Response.Write("<script>alert('請輸入藥品名稱！');</script>");
            else
            {
                SqlDataSource1.InsertParameters["MCategoryID"].DefaultValue = category_select.Value.Substring(0, 4);
                SqlDataSource1.InsertParameters["MSubCategoryID"].DefaultValue = (subcategory_select.Value == "") ? "0" : subcategory_select.Value.Substring(0, 4);
                SqlDataSource1.InsertParameters["ID"].DefaultValue = medicineID.Text;
                SqlDataSource1.InsertParameters["IDNote"].DefaultValue = medicineIDNote.Text;
                SqlDataSource1.InsertParameters["Name"].DefaultValue = medicineName.Text;
                SqlDataSource1.InsertParameters["Name2"].DefaultValue = medicineName2.Text;
                SqlDataSource1.InsertParameters["DF_mID"].DefaultValue = (medicineMID.Text == "") ? " " : medicineMID.Text;
                SqlDataSource1.InsertParameters["DF_subname"].DefaultValue = (medicineSubName1.Text == "") ? " " : medicineSubName1.Text;
                SqlDataSource1.InsertParameters["DF_subname2"].DefaultValue = (medicineSubName2.Text == "") ? " " : medicineSubName2.Text;
                SqlDataSource1.InsertParameters["DF_dosage"].DefaultValue = (medicineDosage.Text == "") ? " " : medicineDosage.Text;
                SqlDataSource1.InsertParameters["DF_form"].DefaultValue = (medicineForm.Text == "") ? " " : medicineForm.Text;
                SqlDataSource1.InsertParameters["DF_note"].DefaultValue = (medicineDFNote.Text == "") ? " " : medicineDFNote.Text;
                SqlDataSource1.InsertParameters["DosFormNote"].DefaultValue = DosageFormNote.Text;
                SqlDataSource1.InsertParameters["UsualDose"].DefaultValue = (UsualDose.Text == "") ? " " : UsualDose.Text;
                SqlDataSource1.InsertParameters["Category"].DefaultValue = medicineCategory.Value;
                SqlDataSource1.InsertParameters["CategoryNote"].DefaultValue = medicineCategoryNote.Text;
                SqlDataSource1.InsertParameters["Note"].DefaultValue = medicineNote.Text;
                SqlDataSource1.InsertParameters["ImagePaths"].DefaultValue = "";
                SqlDataSource1.Insert();
                Response.Write("<script>alert('資料新增成功！');window.location.replace('NewMedicine.aspx');</script>");
            }
        }

        protected IQueryable<Medicine> GetMedicinesInCategoryDescending(int CategoryID, int SubCategoryID)
        {
            var _db = new PrescriptionManual.Models.MedicineContext();
            IQueryable<Medicine> query = _db.Medicines;
            var result = from q in query
                         where q.MCategoryID == CategoryID && (SubCategoryID == 0 || q.MSubCategoryID == SubCategoryID)
                         orderby q.ID descending
                         select q;
            return result;
        }
        public int GetNextID(int CategoryID, int SubCategoryID)
        {
            var result = GetMedicinesInCategoryDescending(CategoryID, SubCategoryID);
            if (result.Count() == 0)
            {
                if (SubCategoryID == 0) return CategoryID + 1;
                else return SubCategoryID + 1;
            }
            return result.First().ID + 1; // In the descending list, First().ID is the largest ID present
        }

        public List<int> GetMissingIDs(int CategoryID, int SubCategoryID)
        {
            var result = GetMedicinesInCategoryDescending(CategoryID, SubCategoryID);
            List<int> missing = new List<int>();
            if (result.Count() > 0)
            {
                int counter = result.First().ID - 1;
                foreach(var med in result)
                {
                    if (med.ID == result.First().ID) continue; // skip the first item
                    if (med.ID == counter)
                    {
                        counter--;
                    }
                    else
                    {
                        while (counter > med.ID)
                        {
                            missing.Add(counter);
                            counter--;
                        }
                        counter--;
                    }
                }
                if (SubCategoryID != 0)
                {
                    while (counter > SubCategoryID)
                    {
                        missing.Add(counter);
                        counter--;
                    }
                } else {
                    while(counter > CategoryID)
                    {
                        missing.Add(counter);
                        counter--;
                    }
                }

            }
            missing.Reverse();
            return missing;
        }

        protected void AutoFillClicked(object sender, EventArgs e)
        {
            var original_cat_index = category_select.SelectedIndex;
            var original_subcat_index = subcategory_select.SelectedIndex;
            //categorySelectOriginal.InnerHtml = category_select.Value;
            //subcategorySelectOriginal.InnerHtml = subcategory_select.Value;
            var category = Convert.ToInt32(category_select.Value.Substring(0, 4));
            var subcategory = (subcategory_select.Value == "") ? 0 : Convert.ToInt32(subcategory_select.Value.Substring(0, 4));
            medicineID.Text = GetNextID(category, subcategory).ToString();

            var missingIDs = GetMissingIDs(category, subcategory);
            string missingIDsDisplay = "";
            foreach(var ID in missingIDs)
            {
                missingIDsDisplay += (ID + " ");
            }
            if(missingIDs.Count() > 0)
            {
                medicineIDControl.InnerHtml = @"<script>
                    var answer = confirm('以下藥品編號為空號，可考慮使用：\n\r" + missingIDsDisplay + @"\n\r是否要使用" + missingIDs.First() + @"作為藥品編號？');
                    if( answer ) {
                        $(document).ready(function() {
                            $('#medicineID').val('" + missingIDs.First()+@"');
                        });
                    }
                    </script>";
            } else
            {
                medicineIDControl.InnerHtml = "";
            }
            category_select.SelectedIndex = original_cat_index;
            subcategory_select.SelectedIndex = original_subcat_index;
        }
    }
}