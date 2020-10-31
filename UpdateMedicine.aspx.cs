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
    public partial class UpdateMedicine : System.Web.UI.Page
    {
        private const string DF_HtmlTemplate = @"
                <div class='row' id='DosageFormRow_{0}'>
                    <div class='form-inline col-md-12'>
                        <div class='form-group'>
                            <div class='input-group'>
                                <span class='input-group-addon'>{0}.</span>
                                <input type='text' runat='server' id='medicineMID_{0}' class='form-control width-full w-110' placeholder='電腦代碼' value='{1}' />
                            </div>
                        </div>
                        <div class='form-group'>
                            <div class='input-group'>
                                <input type='text' runat='server' id='medicineSubName1_{0}' class='form-control width-full w-130' placeholder='統一藥名' value='{2}' />
                            </div>
                        </div>
                        <div class='form-group'>
                            <div class='input-group'>
                                <span class='input-group-addon'>(</span>
                                <input type='text' runat='server' id='medicineSubName2_{0}' class='form-control width-full w-100' placeholder='(可留空)' value='{3}' />
                                <span class='input-group-addon'>)</span>
                            </div>
                        </div>
                        <div class='form-group'>
                            <div class='input-group'>
                                <input type='text' runat='server' id='medicineDosage_{0}' class='form-control width-full' placeholder='藥品規格' value='{4}' />
                            </div>
                        </div>
                        <div class='form-group'>
                            <div class='input-group'>
                                <select id='medicineForm_{0}' runat='server' class='form-control' >
                                    <option value=''>單位</option>
                                    <option value='Amp.'>Amp.</option>
                                    <option value='Btl.'>Btl.</option>
                                    <option value='Cap.'>Cap.</option>
                                    <option value='Supp.'>Supp.</option>
                                    <option value='Tab.'>Tab.</option>
                                    <option value='Vial.'>Vial.</option>
                                    <option value='mL.'>mL.</option>
                                    <option value='Bag'>Bag</option>
                                    <option value='Film'>Film</option>
                                    <option value='Pack'>Pack</option>
                                    <option value='Patch'>Patch</option>
                                </select>
                            </div>
                        </div>
                        <div class='form-group'>
                            <div class='input-group'>
                                <input type='text' runat='server' id='medicineDFNote_{0}' class='form-control width-full' placeholder='註解(可留空)' value='{5}' />
                            </div>
                        </div>
                        <div class='form-group'>
                            <div class='input-group'>
                                <a runat='server' class='btn btn-danger btn-sm' onclick='DeleteDosageForm({0})'>刪除</a>
                            </div>
                        </div>
                    </div>
                </div>";

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

                // load data if came with "id" parameter in URL
                if (Request.QueryString["id"] != null)
                {
                    ShowInfoContainer(false);
                    string query_ID = Request.QueryString["id"].ToString();
                    int search_id;
                    bool isNumeric = int.TryParse(query_ID, out search_id); // will successfully parse if search_name is in fact an int
                    if (isNumeric)
                    {
                        var result = SearchMedicineById(search_id);
                        if (result.Count() != 0) LoadData(result.First());
                        else
                        {
                            Response.Write("<script>alert('查無此藥物！');</script>");
                        }
                    }
                    else
                    {
                        Response.Write("<script>alert('查無此藥物！');</script>");
                    }
                }

                // delete if came with "mode=delete"
                if (Request.QueryString["mode"] == "delete" && Request.QueryString["deleteIID"] != null)
                {
                    DeleteMedicine(Request.QueryString["deleteIID"]);
                }
            }
            else if (updateMedicineSearch.Text != "")
            {
                ShowInfoContainer(false);
                RunSearch();
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

        protected void updateMedicineSearch_Clicked(object sender, EventArgs e)
        {
            if (updateMedicineSearch.Text != "")
            {
                RunSearch();
            }
        }
        protected void RunSearch()
        {
            string search_name = updateMedicineSearch.Text;
            int search_id;
            bool isNumeric = int.TryParse(search_name, out search_id); // will successfully parse if search_name is in fact an int
            IQueryable<Medicine> result;
            if (isNumeric)
            {
                result = SearchMedicineById(search_id);
            }
            else
            {
                result = SearchMedicine(search_name);
            }

            if (result.Count() == 0)
            {
                if (isNumeric)
                {
                    result_div.InnerHtml = "<h3>查無結果！<a href='NewMedicine.aspx?id=" + search_id + "'>按此新增此藥物！</a></h3>";
                }
                else
                {
                    result_div.InnerHtml = "<h3>查無結果！<a href='NewMedicine.aspx?name=" + search_name + "'>按此新增此藥物！</a></h3>";
                }
            }
            else if (result.Count() == 1)
            {
                LoadData(result.First());
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
                        LoadData(Item);
                        break;
                    }
                    result_div.InnerHtml += ("<p class='description'><a href='UpdateMedicine.aspx?id=" + shortID + "'> " + fullID + ". " + Item.Name);
                    if (Item.DF_subname != null)
                    {
                        result_div.InnerHtml += ("(" + Item.DF_subname.Replace("\\", ", ") + ")");
                    }
                    result_div.InnerHtml += "</a></p>";
                }
            }
        }
        public IQueryable<Medicine> SearchMedicine(string Name)
        {
            var _db = new PrescriptionManual.Models.MedicineContext();
            IQueryable<Medicine> query = _db.Medicines;
            var result = from q in query
                         where (q.DF_subname.Contains(Name) || q.DF_subname2.Contains(Name) || q.Name.Contains(Name) || q.Name2.Contains(Name) || q.DF_mID.Contains(Name))
                         orderby q.ID
                         select q;
            return result;
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
        public string GetMCategoryNameById(int ID)
        {
            var _db = new PrescriptionManual.Models.MedicineContext();
            IQueryable<MCategory> query = _db.MCategories;
            var result = from q in query
                         where q.MCategoryID == ID
                         select q;
            if (result.Count() != 0) return result.First().MCategoryName;
            return null;
        }

        public string GetMSubCategoryNameById(int ID)
        {
            var _db = new PrescriptionManual.Models.MedicineContext();
            IQueryable<MSubCategory> query = _db.MSubCategories;
            var result = from q in query
                         where q.MSubCategoryID == ID
                         select q;
            if (result.Count() != 0) return result.First().MSubCategoryName;
            return null;
        }
        protected void LoadData(Medicine Item)
        {
            VirtualSearchButton1.Enabled = false;
            string full_categoryID = (Item.MCategoryID.ToString().Length == 3) ? "0" + Item.MCategoryID.ToString() : Item.MCategoryID.ToString();
            string full_subcategoryID = (Item.MSubCategoryID.ToString().Length == 3) ? "0" + Item.MSubCategoryID.ToString() : Item.MSubCategoryID.ToString();
            string category = GetMCategoryNameById(Item.MCategoryID);
            string subcategory = GetMSubCategoryNameById(Item.MSubCategoryID);
            string full_ID = (Item.ID.ToString().Length == 3) ? "0" + Item.ID.ToString() : Item.ID.ToString();
            string[] DF_mID = Item.DF_mID.Split('\\');
            string[] DF_SubName = Item.DF_subname.Split('\\');
            string[] DF_SubName2 = Item.DF_subname2.Split('\\');
            string[] DF_Dosage = Item.DF_dosage.Split('\\');
            string[] DF_Form = Item.DF_form.Split('\\');
            string[] DF_Note = Item.DF_note.Split('\\');

            info_container_control.InnerHtml = @"<script>$(document).ready(function() {
                                $('#unsaved_warning_alert').show();
                                $('#unsaved_warning_alert').html('<strong>正在編輯：</strong>" + Item.Name + @"');
                            });</script>";
            editing_title.InnerHtml = "<span class='label label-warning'>編輯</span> " + EmptyOr(Item.Name);

            internalID.Text = Item.InternalID.ToString();
            category_select.Value = (category == null) ? "" : full_categoryID + ". " + category;
            subcategory_select.Value = (subcategory == null) ? "" : full_subcategoryID + ". " + subcategory;
            categorySelectOriginal.InnerHtml = category_select.Value;
            subcategorySelectOriginal.InnerHtml = subcategory_select.Value;
            medicineID.Text = full_ID;
            medicineIDOriginal.InnerHtml = full_ID;
            medicineIDNote.Text = EmptyOr(Item.IDNote);
            medicineName.Text = EmptyOr(Item.Name);
            medicineName2.Text = EmptyOr(Item.Name2);
            DosageFormNote.Text = EmptyOr(Item.DosFormNote);
            UsualDose.Text = EmptyOr(Item.UsualDose.Replace("\\n", "\n"));

            info_container_control.InnerHtml += "<script>$(document).ready(function(){if ( $(\"#MainContent_medicineCategory option[value='" + Item.Category + "']\").length == 0 ) {" +
                       "           $('#MainContent_medicineCategory').append(\"<option value='" + Item.Category + @"'>" + Item.Category + "</option>\");   " +
                     @"         }
                                $('#MainContent_medicineCategory').val('" + Item.Category + @"');
                                updateString();
                                });</script>";

            medicineCategoryNote.Text = EmptyOr(Item.CategoryNote);
            medicineNote.Text = EmptyOr(Item.Note);

            DosageFormContainer.InnerHtml = "";
            for (int i = 0; i < DF_mID.Length; i++)
            {
                DosageFormContainer.InnerHtml += String.Format(DF_HtmlTemplate, i + 1, DF_mID[i], DF_SubName[i], DF_SubName2[i], DF_Dosage[i], DF_Note[i]);
                info_container_control.InnerHtml += @"<script>$(document).ready(function() {
                                    $('#medicineForm_" + (i + 1) + @"').val('" + DF_Form[i] + @"');
                                });</script>";
                if (Item.DosFormNote != "" && Item.DosFormNote != null)
                {
                    // shows the NOTE
                    info_container_control.InnerHtml += @"<script>$(document).ready(function() {
                                $('#DosageFormNoteContainer').show();
                                });</script>";
                }
            }
            DF_Count.Text = DF_mID.Length.ToString();
            // show info container
            ShowInfoContainer(true);
        }

        protected string EmptyOr(string str)
        {
            return (str == null) ? "" : str;
        }

        protected void ShowInfoContainer(bool stat)
        {
            if (stat)
            {
                info_container_control.InnerHtml += @"<script>$(document).ready(function () {
                                                    $('#info_container').show();
                                                });</script>";
                result_div.InnerHtml = "";

            }
            else
            {
                info_container_control.InnerHtml = @"<script>$(document).ready(function () {
                                                    $('#info_container').hide();
                                                });</script>";
                editing_title.InnerHtml = "";
            }
        }
        protected void SaveChanges(object sender, EventArgs e)
        {
            SqlDataSource1.UpdateParameters["MCategoryID"].DefaultValue = category_select.Value.Substring(0, 4);
            SqlDataSource1.UpdateParameters["MSubCategoryID"].DefaultValue = (subcategory_select.Value == "") ? "0" : subcategory_select.Value.Substring(0, 4);
            SqlDataSource1.UpdateParameters["ID"].DefaultValue = medicineID.Text;
            SqlDataSource1.UpdateParameters["IDNote"].DefaultValue = medicineIDNote.Text;
            SqlDataSource1.UpdateParameters["Name"].DefaultValue = medicineName.Text;
            SqlDataSource1.UpdateParameters["Name2"].DefaultValue = medicineName2.Text;
            SqlDataSource1.UpdateParameters["DF_mID"].DefaultValue = (medicineMID.Text == "")? " " : medicineMID.Text;
            SqlDataSource1.UpdateParameters["DF_subname"].DefaultValue = (medicineSubName1.Text=="")? " " : medicineSubName1.Text;
            SqlDataSource1.UpdateParameters["DF_subname2"].DefaultValue = (medicineSubName2.Text=="")? " " : medicineSubName2.Text;
            SqlDataSource1.UpdateParameters["DF_dosage"].DefaultValue = (medicineDosage.Text=="")? " " : medicineDosage.Text;
            SqlDataSource1.UpdateParameters["DF_form"].DefaultValue = (medicineForm.Text=="")? " " : medicineForm.Text;
            SqlDataSource1.UpdateParameters["DF_note"].DefaultValue = (medicineDFNote.Text=="") ?" ": medicineDFNote.Text;
            SqlDataSource1.UpdateParameters["DosFormNote"].DefaultValue = DosageFormNote.Text;
            SqlDataSource1.UpdateParameters["UsualDose"].DefaultValue = (UsualDose.Text=="") ? " " : UsualDose.Text;
            SqlDataSource1.UpdateParameters["Category"].DefaultValue = medicineCategory.Value;
            SqlDataSource1.UpdateParameters["CategoryNote"].DefaultValue = medicineCategoryNote.Text;
            SqlDataSource1.UpdateParameters["Note"].DefaultValue = medicineNote.Text;
            SqlDataSource1.UpdateParameters["InternalID"].DefaultValue = internalID.Text;
            SqlDataSource1.UpdateParameters["ImagePaths"].DefaultValue = "";
            SqlDataSource1.Update();
            Response.Write("<script>alert('更新成功！');window.location.replace('UpdateMedicine.aspx?id="+ medicineID.Text + "');</script>");
        }
        protected void DeleteMedicine(string str)
        {
            SqlDataSource1.DeleteParameters["InternalID"].DefaultValue = str;
            SqlDataSource1.Delete();
            Response.Write("<script>alert('已刪除！');window.location.replace('UpdateMedicine.aspx');</script>");
        }
    }
}