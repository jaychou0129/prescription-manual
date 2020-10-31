<%@ Page Title="本院醫師處方須知" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Instructions.aspx.cs" Inherits="PrescriptionManual.Instructions" %>

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
        <h1>本院醫師處方須知</h1>
        <p class="description-hanging">一、本院醫師應依照本院處方集之藥品開立處方。</p>
        <p class="description-hanging">二、醫師需於處方箋蓋印職章或親簽全名，修改之處方箋亦需加蓋職章以示負責。</p>
        <p class="description-hanging">三、處方箋的藥品名稱以處方集登錄者為之，期間若因廠商停產或換藥時，依藥劑科公告為準。</p>
        <p class="description-hanging">四、處方藥品以本院現有成份相同藥品調劑之。</p>
        <p class="description-hanging">五、部分藥品有二種以上的劑量或劑型；因此，醫師處方時均應確認藥品的劑量、劑型與單位。</p>
        <p class="description-hanging">六、門診處方規定：</p>
        <ol class="description">
            <li>
                注射針劑，以院內使用為原則，且應開立注射處方單，提供注射室核對使用。
            </li>
            <li>
                處方第三/四級管制藥品，每次調劑不得超過一個月份量。連續處方箋或有特殊需要者，應符合相關法規。
            </li>
            <li>
                健保處方箋，應符合健保署之藥品使用規範。
            </li>
        </ol>
        <p class="description-hanging">七、住院處方注意事項：</p>
        <ol class="description">
            <li>
                需有病人的基本資料、病歷號碼、病 床號及處方日期。
            </li>
            <li>
                醫師端開立電腦處方箋應有職章，修改處方亦須加蓋職章以示負責。
            </li>
            <li>
                醫師端開立電腦處方箋時，應選擇適當之處方類別，例如立即使用(st)、需要時使用(prn)、首日量、UD或出院帶回用藥等。
            </li>
            <li>
                醫師端開立電腦處方時，應注意首日量之計算，新增或修正均自開立時間算起，應計算至下次UD服用前所需數量；或可自定起始用藥時間。
            </li>
            <li>
                特殊包裝藥品(例如多劑量包裝)、外用藥品以及特殊用法者(例如化學治療劑)，須開立臨時處方箋足量請領。
            </li>
        </ol>
        <p class="description-hanging">八、管制藥品處方規定：</p>
        <ol class="description">
            <li>
                醫師、牙醫師非領有管制藥品管理局核發之使用執照，不得開立管制藥品專用處方箋或是使用第一級至第三級管制藥品。
            </li>
            <li>
醫師、牙醫師處方第一級至第三級管制藥品(如下表)，應另行開立管制藥品專用處方箋。
            </li>
            <li>
第一級、第二級、第三級管制藥品專用處方箋，均以調劑一次為限。
            </li>
            <li>
                管制藥品專用處方箋應註明病人姓名、病歷號碼、診斷病名、身份證字號、年齡(出生年月日)、藥品名稱、每次劑量、用法、總劑量、處方年月日，並請開立醫師親簽名或蓋章且填上使用執照號碼。
            </li>
            <li>
                癌末居家治療使用第一/二級管制藥品，每次處方針劑7天、錠劑14日、貼片15日內為限；於再次處方時，應繳回使用過之針劑空瓶或貼片。
            </li>
            <li>
                非癌症之慢性頑固性疼痛病人，使用第一/二級管制藥品，連續使用多於14天或是三個月內累計多於28天(含)，請填寫『新個案列報表』並應於六天內完成會診，呈報〔管制藥品管理委員會〕討論後決議是否續用。
            </li>
            <li>
                第一/二/三級管制藥品注射劑，以專用處方箋且限於院內使用原則，使用完畢之空瓶需保留作為報銷證明。
            </li>
            <li>
                第一/二/三級管制藥品注射劑以開瓶報銷為原則，若殘液需丟棄，應有兩名護理人員於『管制藥品專用處方箋』簽名或蓋章，以證明之。
            </li>
        </ol>
        <img src="Images/drug-categorization.jpg" class="center" alt="Drug-categorization"/>
    </div>

    <div class="row">
        <div class="col-md-4">
            <!--<h2>本院醫師處方須知</h2>-->
            <p>
                <a class="btn btn-primary btn-lg" href="Default.aspx">查看序言 &raquo;</a>
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
