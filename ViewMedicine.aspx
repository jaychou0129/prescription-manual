<%@ Page Title="藥品查詢" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ViewMedicine.aspx.cs" Inherits="PrescriptionManual.ViewMedicine" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    
    <script src="Scripts/custom-scripts.js"></script>
    <div class="row" style="margin-top: 20px">
        <div class="col-md-1">
            <a class="btn btn-primary" onclick="toPrevious();">返回</a>
        </div>
        <div class="col-md-11">
            <ul class="breadcrumb">
                <%
                    string full_CatID = (Category.MCategoryID.ToString().Length == 3) ? "0" + Category.MCategoryID.ToString() : Category.MCategoryID.ToString();
                    Response.Write("<li><a href='View?expand=" + full_CatID + "'>" + Category.MCategoryName + "</a></li>");
                    if (SubCategory != null)
                    {
                        string full_SubCatID = (SubCategory.MSubCategoryID.ToString().Length == 3) ? "0" + SubCategory.MSubCategoryID.ToString() : SubCategory.MSubCategoryID.ToString();
                        Response.Write("<li><a href='View?expand=" + full_SubCatID + "'>" + SubCategory.MSubCategoryName + "</a></li>");
                    }
                    var full_ID = (Medi.ID.ToString().Length == 3) ? "0" + Medi.ID.ToString() : Medi.ID.ToString();
                    Response.Write("<li class='active'>" + full_ID + ". ");
                    if (Medi.IDNote != null && Medi.IDNote != "") Response.Write("(" + Medi.IDNote + ") ");
                    Response.Write(Medi.Name + "</li>");
                %>
            </ul>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <div class="panel panel-primary">
                <div class="panel-heading">
                    藥品資訊
                </div>
                <div class="panel-body">
                    <h2 class="text-center underline">
                        <strong><%= Medi.Name %></strong>
                        <%
                            if (Medi.Name2 != null && Medi.Name2 != "")
                                Response.Write(" (" + Medi.Name2 + ")");
                        %>
                    </h2>
                    <h3>Dosage Form:</h3>
                        <%
                            for(int i = 0; i < DF_mID.Count(); i++)
                            {
                                Response.Write("<h3 class='margin-2'><u>" + DF_mID[i] + "</u>");
                                Response.Write("<strong> " + DF_subname[i] + " ");
                                if (DF_subname2[i] != "" && DF_subname2[i] != " ") Response.Write("<span class='smaller'>(" + DF_subname2[i] + ")</span>");
                                Response.Write(" </strong>" + DF_dosage[i] + "<span class='fr'>" + DF_form[i] + "</span>");
                                Response.Write("</h3>");
                                if (DF_note[i] != "") Response.Write("<h4 class='display-4 margin-2'>" + DF_note[i] + "</h4>");
                            }
                            if (Medi.DosFormNote != null && Medi.DosFormNote != "") Response.Write("<h4 class='display-4 margin-2'>(" + Medi.DosFormNote + ")</h4>");
                        %>
                    <h3>Usual Dose:</h3>
                    <h3 style="margin-left: 2em; line-height: 1.4">
                        <%
                            var usualDose = Medi.UsualDose.Replace("<<", "<i>").Replace(">>", "</i>")
                                            .Replace("[", "{[").Replace("]", "]}")
                                            .Replace("{", "<strong>").Replace("}", "</strong>")
                                            .Replace("\\n", "<br>").Replace("\r", "<br>");
                            Response.Write(usualDose);
                        %>
                    </h3>
                    <%
                        if (Medi.Category != null && Medi.Category != "")
                        {
                            Response.Write("<h3>Category: " + Medi.Category + "</h3>");
                        }
                        if (Medi.CategoryNote != null && Medi.CategoryNote != "")
                        {
                            Response.Write("<h3 class='margin-2'>" + Medi.CategoryNote.Replace("\n", "<br>") + "</h3>");
                        }

                        if (Medi.Note != null && Medi.Note != "")
                        {
                            Response.Write("<h3>Note:</h3>");
                            Response.Write("<h3 class='margin-2'>" + Medi.Note.Replace("\n", "<br>") + "</h3>");
                        }
                    %>

                </div>
            </div>
        </div>
    </div>

</asp:Content>