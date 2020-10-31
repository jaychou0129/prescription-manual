<%@ Page Title="藥品查詢" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Search.aspx.cs" Inherits="PrescriptionManual.Search" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <div class="jumbotron">
        <h1>藥品查詢</h1>
        <div class="form-group">
            <label for="category_select">藥品類別：</label>
            <select id="category_select" runat="server" ClientIDMode="Static" class="form-control" onchange="update_subcategory_select()">
            </select>
        </div>
        <div class="form-group">
            <label for="subcategory_select">藥品次類別：</label>
            <select id="subcategory_select" runat="server" ClientIDMode="Static" class="form-control" onmousedown="update_subcategory_select()">
            </select>
        </div>
        <div class="form-group">
            <label for="searchbar">藥品名稱/商品名：</label>
            <div class="input-group">
                <asp:TextBox runat="server" ID="searchbar" ClientIDMode="Static" CssClass="form-control width-full" placeholder="輸入藥品名稱"/>
                <span class="input-group-btn">
                    <asp:LinkButton runat="server" ID="SearchBtn" OnClick="SearchBtn_Clicked" CssClass="btn btn-primary">
                        <span class="glyphicon glyphicon-search"></span>
                    </asp:LinkButton>
                </span>
            </div>
        </div>

    </div>

    <div class="row" runat="server" id="result_div">

    </div>
    <script src="Scripts/custom-scripts.js"></script>
    <script>
        update_subcategory_select();
    </script>
</asp:Content>