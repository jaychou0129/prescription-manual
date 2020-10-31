<%@ Page Title="序言" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="PrescriptionManual._Default" %>

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
        <h1>序言</h1>
        <p class="description">
            本版處方集收載新樓醫院目前使用藥品，全部為本院藥事委員會審查通過者，由藥劑科編輯。藥品經汰舊增新，品項與前版處方集相差甚多。
        </p>
        <p class="description">
            藥品分類係根據藥理作用及臨床用途，共分五十二章，為配合電腦排版及統計，每章均有藥性歸類號碼，以黑體字標示。目錄係依章節編碼排序，索引中並列藥性歸類及頁數。
        </p>
        <p class="description">
            每種藥品記載項目包括：
        </p>
        <p class="description-hanging">一、藥品：底線粗體字表一般名，( )標示表別名或縮寫或常見商品名。</p>
        <p class="description-hanging">二、Dosage Form：記載劑型、含量，底線為本院電腦代碼，粗體為本院統一藥名。</p>
        <p class="description-hanging">三、Usual Dose：記載劑量及使用方法。通常是指成人劑量，有些加入最大或小孩劑量。</p>
        <p class="description-hanging">四、Note：注意事項，包括儲存、安定性、泡製方式與藥效等。</p>
        <p class="description-hanging">五、Category：孕婦用藥安全分級，依據FDA(美)的建議分為 A、B、C、D、X 五級。</p>
        <p class="description">
            雖然，美國FDA自2016年5月建議，將孕婦用藥安全分級改為詳細的相關文字敘述；但是，提供簡潔且易懂的分級仍是必要的。因此，本處方集依舊提供傳統且易於辨識的孕婦用藥安全分級，供各位參考。
        </p>
        <p class="description"> A 級：證實對胎兒無危險性。</p>
        <p class="description"> B 級：目前尚未證實對胎兒有危險性。</p>
        <p class="description"> C 級：對胎兒的安全性尚未確定，此類藥品於治療效益大於胎兒之危險時才用。</p>
        <p class="description"> D 級：對胎兒有明確的危險性，除非孕婦不用此藥會危及生命，且無其他較為安全的藥物可取代者，方可勉強使用；必須明確告知。</p>
        <p class="description"> X 級：已證實會有「致畸胎」，孕婦絕對禁止使用。</p>
        <p class="description-hanging">
            六、Definitions of Breast Feeding Recommendations:
        </p>
        <p class="description-hanging">
            <strong>Compatible:</strong>
        </p>
        <p class="description">
            Either the drug is not excreted significant amounts into breast milk in clinically, or during lactation does, or is not expected to, cause toxicity in a nursing infant.
        </p>
        <p class="description-hanging">
            <strong>Hold Breast Feeding:</strong>
        </p>
        <p class="description">
            The drug may or may not be excreted into breast milk, but the maternal benefits of therapy far outweighs the benefits of breast milk to an infant. Breast-feed should be held until maternal therapy is completed and the drug has been eliminated (or had a low concentration) from mother’s system.
        </p>
        <p class="description-hanging">
            <strong>No (Limited) Human Data – Probably Compatible:</strong>
        </p>
        <p class="description">
                Either no human data or clinic data are limited. The available data of the drug suggest that there isn’t have a significant risk to a nursing infant in clinic use.
        </p>
        <p class="description-hanging">
            <strong>No (Limited) Human Data – Potential Toxicity:</strong>
        </p>
        <p class="description">
            Either no human data or clinic data are limited. The characteristics of this drug suggest that it could have a clinically significant risk to a nursing infant. Breast feeding is <strong>NOT</strong> recommended.
        </p>
        <p class="description-hanging">
            <strong>No (Limited) Human Data-Potential Toxicity (Mother):</strong>
        </p>
        <p class="description">
            Either no human data or clinic data are limited. The characteristics of this drug suggest that breastfeeding could have a clinically significant risk to the mother such as further loss of essential vitamins or nutrients. Breast feeding is <strong>NOT</strong> recommended.
        </p>
        <p class="description-hanging">
            <strong>Contraindicated:</strong>
        </p>
        <p class="description">
            There have may or may not be human experience, but the combined data (including animal data if available) suggest that this drug may cause severe toxicity in a nursing infant, or breast-feed is <strong>constraindicated</strong> because of the maternal condition for which the drug is indicated. Mother should not breast-feed if they are taking the drug or have the same conditions.
        </p>
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
