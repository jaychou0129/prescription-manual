<%@ Page Title="References" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="References.aspx.cs" Inherits="PrescriptionManual.References" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <div class="jumbotron">
        <h1>台灣基督長老教會新樓醫院 處方集</h1>
        <p class="lead">Sin Lau Christian Hospital Prescription Manual</p>
        <p>
            <a href="View.aspx" class="btn btn-primary btn-lg">藥品總覽</a>
            <a href="Search.aspx" class="btn btn-primary btn-lg">開始查詢</a>
        </p>
    </div>

    <div class="row">
        <h1>References</h1>
        <ol class="description">
            <li>Package leaflet</li>
            <li>MIMS</li>
            <li>Drug information Handbook</li>
            <li>Health Professional's Drug Guide</li>
            <li>Drugs in Pregnancy and Lactation (8th Edition)</li>
            <li>唐正乾: 臨床藥理學暨治療實務, 2018; 合記圖書出版社.</li>
        </ol>
    </div>

    <div class="row">
        <div class="col-md-4">
            <!--<h2>本院醫師處方須知</h2>-->
            <p>
                <a class="btn btn-primary btn-lg" href="Instructions.aspx">本院醫師處方須知 &raquo;</a>
            </p>
        </div>

        <div class="col-md-4">
            <!--<h2>門診/住院病人退藥規定</h2>-->
            <p>
                <a class="btn btn-primary btn-lg" href="Regulations.aspx">門診/住院病人退藥規定 &raquo;</a>
            </p>
        </div>

        <div class="col-md-4">
            <!--<h2>電腦取碼規則</h2>-->
            <p>
                <a class="btn btn-primary btn-lg" href="CodeRules.aspx">電腦取碼規則 &raquo;</a>
            </p>
        </div>
    </div>
</asp:Content>
