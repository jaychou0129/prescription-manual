<%@ Page Title="藥品總覽" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="View.aspx.cs" Inherits="PrescriptionManual.View" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <link href="jquery.treeview.css" rel="stylesheet" type="text/css" />

    <div class="jumbotron">
        <h1>藥品總覽</h1>
    </div>

    <div class="row">
        <div class="btn-toolbar">
            <div class="btn-group mr-2">
                <a class="btn btn-primary" onclick="$('.treeview').treeView('collapseAll');">全部收起</a>
                <a class="btn btn-primary" onclick="$('.treeview').treeView('expandAll');">全部展開</a>
            </div>
            <div class="btn-group">
                <input type="text" class="form-control" id="view-search" size="50" placeholder="搜尋藥品/類別"/>
            </div>
            <div class="btn-group mr-2">
                <a class="btn btn-primary" onclick="clearSearch()">&times;清除搜尋</a>
            </div>

        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <h2>以下藥品依類別分類：</h2>
            <div id="MCategoryMenu">
                <ul class="treeview">
                    <%
                        var categories = GetMCategories();
                        foreach(var Item in categories)
                        {
                            // print out current category
                            PrintCategory(Item);
                            var subCategories = GetMSubCategories(Item.MCategoryID, Item.MCategoryID + 100); // Get all sub categories in this category
                            Response.Write("<ul>");

                            if (subCategories.Count() != 0)
                            {
                                foreach (var SubItem in subCategories)
                                {
                                    PrintSubCategory(SubItem);
                                    var medicinesInSubCategory = GetMedicine(Item.MCategoryID, SubItem.MSubCategoryID); // Get all medicine in this sub category
                                    if (medicinesInSubCategory.Count() != 0)
                                    {
                                        Response.Write("<ul>");
                                        foreach (var Med in medicinesInSubCategory)
                                        {
                                            PrintMedicine(Med);
                                        }
                                        Response.Write("</ul>");
                                    }
                                    Response.Write("</li>");
                                }
                            }
                            else
                            {
                                // print out medicines directly if there's no sub categories
                                var medicinesInCategory = GetMedicine(Item.MCategoryID);
                                foreach(var Med in medicinesInCategory)
                                {
                                    PrintMedicine(Med);
                                }
                            }
                            Response.Write("</ul>");
                            Response.Write("</li>");
                        }
                    %>
                </ul>
            </div>
        </div>
    </div>
    <script src="jquery.treeView.js"></script>
    <script src="Scripts/custom-scripts.js"></script>
    <script>
            $(document).ready(function () {
                if (GetURLParameter("expand") != null) {
                    var searchTerm = decodeURIComponent(GetURLParameter("expand"));
                    $parLi = $('li:contains("' + searchTerm + '")').closest('li.contains-items');
                    $parLi.addClass('items-expanded');
                    $parLi.find('>ul').show();
                }
            });
    </script>
</asp:Content>
