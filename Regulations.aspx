<%@ Page Title="門診/住院病人退藥規定" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Regulations.aspx.cs" Inherits="PrescriptionManual.Regulations" %>

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
        <h1>門診/住院病人退藥規定</h1>
        <p class="description-hanging">一、可退還藥品限由本院藥劑科發出之原封且保存良好之注射劑。</p>
        <p class="description-hanging">二、口服藥品除藥物過敏並經醫師診斷證明外，一律不接受退藥。</p>
        <p class="description-hanging">三、凡合乎退藥規定者：</p>
        <ol class="description">
            <li>
                門診病人須於藥品發出一週內辦理退藥，逾時概不接受退藥。
            </li>
            <li>
                住院病人停用之藥品，護理人員應每日開退藥單交書記入帳，並於交換UD車時，隨車退回藥劑科；藥劑科依據退藥統計表點收藥品[唯裸錠不點收]，出院時完全結清退藥。
            </li>
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
                <a class="btn btn-primary btn-lg" href="Default.aspx">查看序言 &raquo;</a>
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
