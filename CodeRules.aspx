<%@ Page Title="電腦取碼規則" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="CodeRules.aspx.cs" Inherits="PrescriptionManual.CodeRules" %>

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
        <h1>電腦取碼規則</h1>
        <p class="description-hanging">一、約定統一書寫藥名</p>
        <p class="description-hanging">二、取碼規則：</p>
        <ol class="description">
            <li>
                約定六碼，最前碼為用途識別碼，其中 O 為口服藥、I 為注射針劑、E 為外用藥、G 為眼耳鼻喉用藥；後五碼為藥品識別碼，取約定藥名為原則。
            </li>
            <li>
                藥品如有劑型用途、劑量不同時，將以最後一碼為劑量劑型碼。
            </li>
            <li>
                如上述方法仍無法區別時，以最後二碼為劑量劑型碼。
            </li>
            <li>
                特殊取碼：例如化學名辭、通俗簡寫、整瓶與小單位計價。
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
                <a class="btn btn-primary btn-lg" href="Regulations.aspx">門診/住院病人退藥規定 &raquo;</a>
            </p>
        </div>

        <div class="col-md-4">
            <!--<h2>電腦取碼規則</h2>-->
            <p>
                <a class="btn btn-primary btn-lg" href="Default.aspx">查看序言 &raquo;</a>
            </p>
        </div>
    </div>
</asp:Content>