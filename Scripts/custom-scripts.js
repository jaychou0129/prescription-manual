$(document).ready(function () {
    $('.treeview').treeView();

})
$(function () {
    $('[data-toggle="tooltip"]').tooltip()
})


$.expr[":"].contains = $.expr.createPseudo(function (arg) {
    return function (elem) {
        return $(elem).text().toUpperCase().indexOf(arg.toUpperCase()) >= 0;
    };
});
$('#view-search').on('keyup', function () {
    if ($('#view-search').val() != "") {
        $('.treeview').children().hide();
        var items = $('.treeview').find('.contains-items');
        items.find('ul').hide();
        items.removeClass('items-expanded');

        removeAllMarks();

        var searchTerm = $('#view-search').val();
        $parLi = $('li:contains("' + searchTerm + '")').closest('li.contains-items');
        $parLi.addClass('items-expanded');
        $parLi.find('>ul').show();
        $parLi.show();


        var term = $('#view-search').val();

        $('li:contains("' + term + '")')
            .contents().each(function () {
                // nodeType for text nodes is 3
                if (this.nodeType === 3 && this.textContent.includes(term)) {
                    var html = this.textContent.replace(term, '<mark>' + term + '</mark>');
                    // replace text node with html
                    $(this).replaceWith(html)
                }

            })
    } else {
        $('.treeview').children().show();
        $('.treeview').treeView('collapseAll');

        removeAllMarks();
    }

})

function update_subcategory_select() {
    if ($('#category_select').val() == "不限") {
        $("#subcategory_select").children().hide();
        $("#subcategory_select").children().first().show();
        $("#subcategory_select").val($("#subcategory_select").children().first().val()); // selects 不限
    } else {
        var category = $('#category_select').val().substring(0, 2);
        $("#subcategory_select").children().hide();
        $("#subcategory_select").children().first().show();
        $("#subcategory_select").val($("#subcategory_select").children().first().val());
        $("#subcategory_select").children("option[value^=" + category + "]").show();
    }
}

function update_subcategory_select_updateMedicine() {
    var category = $('#category_select').val().substring(0, 2);
    $("#subcategory_select").children().hide();
    $("#subcategory_select").children("option[value^=" + category + "]").show();
    if ($("#subcategory_select").children("option[value^=" + category + "]").length == 0)
        $("#subcategory_select").val("");
    else $("#subcategory_select").val($("#subcategory_select").children("option[value^=" + category + "]").first().val());
}

function toPrevious() {
    if (document.referrer.includes("View") || document.referrer == "") {
        window.close();
    } else {
        history.back();
    }
}

function AddDosageForm() {
    $('#DF_Count').html(parseInt($('#DF_Count').html()) + 1);
    var n = parseInt($('#DF_Count').html());
    $('#MainContent_DosageFormContainer').append(" \
    <div class='row' id='DosageFormRow_" + n + "'> \
        <div class='form-inline col-md-12'> \
            <div class='form-group'> \
                <div class='input-group'> \
                    <span class='input-group-addon'>" + n + ".</span> \
                    <input type='text' runat='server' id='medicineMID_" + n + "' class='form-control width-full w-110' placeholder='電腦代碼' value='' /> \
                </div> \
            </div> \
            <div class='form-group'> \
                <div class='input-group'> \
                    <input type='text' runat='server' id='medicineSubName1_" + n + "' class='form-control width-full w-130' placeholder='統一藥名' value='' /> \
                </div> \
            </div> \
            <div class='form-group'> \
                <div class='input-group'> \
                    <span class='input-group-addon'>(</span> \
                    <input type='text' runat='server' id='medicineSubName2_" + n + "' class='form-control width-full w-100' placeholder='(可留空)' value='' /> \
                    <span class='input-group-addon'>)</span> \
                </div> \
            </div> \
            <div class='form-group'> \
                <div class='input-group'> \
                    <input type='text' runat='server' id='medicineDosage_" + n + "' class='form-control width-full' placeholder='藥品規格' value='' /> \
                </div> \
            </div> \
            <div class='form-group'> \
                <div class='input-group'> \
                    <select id='medicineForm_" + n + "' runat='server' class='form-control' > \
                        <option value=''>單位</option> \
                        <option value='Amp.'>Amp.</option> \
                        <option value='Btl.'>Btl.</option> \
                        <option value='Cap.'>Cap.</option> \
                        <option value='Supp.'>Supp.</option> \
                        <option value='Tab.'>Tab.</option> \
                        <option value='Vial.'>Vial.</option> \
                        <option value='mL.'>mL.</option> \
                        <option value='Bag'>Bag</option> \
                        <option value='Film'>Film</option> \
                        <option value='Pack'>Pack</option> \
                        <option value='Patch'>Patch</option> \
                    </select> \
                </div> \
            </div> \
            <div class='form-group'> \
                <div class='input-group'> \
                    <input type='text' runat='server' id='medicineDFNote_" + n + "' class='form-control width-full' placeholder='註解(可留空)' value='' /> \
                </div> \
            </div> \
            <div class='form-group'> \
                <div class='input-group'> \
                    <a runat='server' class='btn btn-danger btn-sm' onclick='DeleteDosageForm(" + n + ")'>刪除</a> \
                </div> \
            </div> \
        </div> \
    </div> \
    <script>$('input[id*=\"medicineMID_\"], input[id*=\"medicineSubName1_\"], input[id*=\"medicineSubName2_\"], input[id*=\"medicineDosage_\"], select[id*=\"medicineForm_\"], input[id*=\"medicineDFNote_\"]').on(\"change keyup\", updateString); \
        ");
    updateString();
    UpdateDosageFormDisplay();
}

function AddDosageFormNote() {
    $('#DosageFormNoteContainer').toggle();
    if ($('#DosageFormNoteContainer').is(':hidden')) {
        $('#DosageFormNote').val("");
    }
}

function DeleteDosageForm(n) {
    if ($('#DosageFormRow_' + n.toString()).length > 0) {
        $('#DosageFormRow_' + n.toString()).remove();
        UpdateDosageFormDisplay();
        $('#DF_Count').html(parseInt($('#DF_Count').html()) - 1);
        updateString();
    }
}

function UpdateDosageFormDisplay() {
    var n = 1;
    $("#MainContent_DosageFormContainer > div").each(function () {
        $(this).children().first().children().first().children().first().children().first().html(n.toString() + ".");
        n++;
    });
}

function insert(a, b) {
    var textarea = document.getElementById("UsualDose");
    if ('selectionStart' in textarea) {
        // check whether some text is selected in the textarea
        if (textarea.selectionStart != textarea.selectionEnd) {
            var newText = textarea.value.substring(0, textarea.selectionStart) +
                a + textarea.value.substring(textarea.selectionStart, textarea.selectionEnd) + b +
                textarea.value.substring(textarea.selectionEnd);
            textarea.value = newText;
        } else {
            var cursorPos = textarea.selectionStart;
            var newText = textarea.value.substring(0, textarea.selectionStart) +
                a + textarea.value.substring(textarea.selectionStart, textarea.selectionEnd) + b +
                textarea.value.substring(textarea.selectionEnd);
            textarea.value = newText;
            textarea.focus();
            textarea.selectionEnd = cursorPos + a.length;
        }
    }
    else {  // Internet Explorer before version 9
        // create a range from the current selection
        var textRange = document.selection.createRange();
        // check whether the selection is within the textarea
        var rangeParent = textRange.parentElement();
        if (rangeParent === textarea) {
            textRange.text = left + textRange.text + right;
        }
    }
}

function checkOthers() {
    var obj = $('#MainContent_medicineCategory');
    if (obj.val() == "Others") {
        var str = prompt("請輸入Category：");
        if (str != "" && str != null) {
            obj.append("<option value='" + str + "'>" + str + "</option>");
            obj.val(str);
        } else {
            obj.val("");
        }
    }
}

function updatePreviewWindow() {
    $('#previewMCategory').html( $('#category_select').val().substring(6) );
    if ($('#subcategory_select').val() == "") $('#previewMSubCategoryContainer').hide();
    else {
        $('#previewMSubCategoryContainer').show();
        $('#previewMSubCategory').html($('#subcategory_select').val().substring(6));
    }
    $('#previewID').html(($('#medicineID').val().length == 3 ? "0" + $('#medicineID').val() : $('#medicineID').val()));
    if ($('#medicineIDNote').val() == "") $('#previewIDNote').html("");
    else $('#previewIDNote').html("(" + $('#medicineIDNote').val() + ")");
    $('#previewNameTop').html($('#medicineName').val());

    $('#previewName').html($('#medicineName').val());
    if ($('#medicineName2').val() == "") $('#previewName2').html("");
    else $('#previewName2').html("(" + $('#medicineName2').val() + ")");

    if ($('#DosageFormNote').val() == "") {
        $('#previewDosFormNote').html("");
    } else {
        $('#previewDosFormNote').html("(" + $('#DosageFormNote').val() + ")");
    }

    $('#previewUsualDose').html($('#UsualDose').val().replace(/<</g, "<i>").replace(/>>/g, "</i>")
        .replace(/\[/g, "{[").replace(/]/g, "]}")
        .replace(/{/g, "<strong>").replace(/}/g, "</strong>")
        .replace(/\n/g, "<br>").replace(/\r/g, "<br>"));

    if ($('#MainContent_medicineCategory').val() == "") $('#previewCategoryContainer').hide();
    else {
        $('#previewCategoryContainer').show();
        $('#previewCategory').html($('#MainContent_medicineCategory').val());
    }
    $('#previewCategoryNote').html($('#medicineCategoryNote').val());

    if ($('#medicineNote').val() == "") $('#previewNoteContainer').hide();
    else {
        $('#previewNoteContainer').show();
        $('#previewNote').html($('#medicineNote').val());
    }

    var total_DF = parseInt($('#DF_Count').html());
    var mID = Array.from(document.querySelectorAll('input[id*="medicineMID_"]'));
    var subname = Array.from(document.querySelectorAll('input[id*="medicineSubName1_"]'));
    var subname2 = Array.from(document.querySelectorAll('input[id*="medicineSubName2_"]'));
    var dosage = Array.from(document.querySelectorAll('input[id*="medicineDosage_"]'));
    var form = Array.from(document.querySelectorAll('select[id*="medicineForm_"]'));
    var note = Array.from(document.querySelectorAll('input[id*="medicineDFNote_"]'));
    $('#previewDFContainer').html("");
    for (var i = 0; i < total_DF; i++) {
        $('#previewDFContainer').append(`<h3 class="margin-2">
            <u>`+ mID[i].value + `</u>
            <strong>` + subname[i].value + ` <span class="smaller">` + ((subname2[i].value == "" || subname2[i].value == " ") ? "" : "(" + subname2[i].value + ")") + `</span>
            </strong>` + dosage[i].value + `<span class='fr'>` + form[i].value + `</span>
                                        </h3>`);
        if (note[i].value != "") {
            $('#previewDFContainer').append(`<h4 class='display-4 margin-2'>` + note[i].value + `</h4>`);
        }
    }
}

$('input[id*="medicineMID_"], input[id*="medicineSubName1_"], input[id*="medicineSubName2_"], input[id*="medicineDosage_"], select[id*="medicineForm_"], input[id*="medicineDFNote_"]').on("change keyup", updateString);

function updateString() {
    var total_DF = parseInt($('#DF_Count').html());
    var mID = Array.from(document.querySelectorAll('input[id*="medicineMID_"]'));
    var subname = Array.from(document.querySelectorAll('input[id*="medicineSubName1_"]'));
    var subname2 = Array.from(document.querySelectorAll('input[id*="medicineSubName2_"]'));
    var dosage = Array.from(document.querySelectorAll('input[id*="medicineDosage_"]'));
    var form = Array.from(document.querySelectorAll('select[id*="medicineForm_"]'));
    var note = Array.from(document.querySelectorAll('input[id*="medicineDFNote_"]'));
    $('#medicineMID').val("");
    $('#medicineSubName1').val("");
    $('#medicineSubName2').val("");
    $('#medicineDosage').val("");
    $('#medicineForm').val("");
    $('#medicineDFNote').val("");
    for (var i = 0; i < total_DF - 1; i++) {
        $('#medicineMID').val($('#medicineMID').val() + mID[i].value + "\\");
        $('#medicineSubName1').val($('#medicineSubName1').val() + subname[i].value + "\\");
        $('#medicineSubName2').val($('#medicineSubName2').val() + subname2[i].value + "\\");
        $('#medicineDosage').val($('#medicineDosage').val() + dosage[i].value + "\\");
        $('#medicineForm').val($('#medicineForm').val() + form[i].value + "\\");
        $('#medicineDFNote').val($('#medicineDFNote').val() + note[i].value + "\\");
    }
    if (total_DF >= 1) {
        $('#medicineMID').val($('#medicineMID').val() + mID[i].value);
        $('#medicineSubName1').val($('#medicineSubName1').val() + subname[i].value);
        $('#medicineSubName2').val($('#medicineSubName2').val() + subname2[i].value);
        $('#medicineDosage').val($('#medicineDosage').val() + dosage[i].value);
        $('#medicineForm').val($('#medicineForm').val() + form[i].value);
        $('#medicineDFNote').val($('#medicineDFNote').val() + note[i].value);
    }
}

$('#DeleteBtn').click(function () {
    if (confirm("你確定要刪除這筆資料嗎？")) {
        window.location.replace('UpdateMedicine.aspx?mode=delete&deleteIID=' + $('#internalID').html());
    }
})

function verifyID(useOriginalID) {
    var http = new XMLHttpRequest();
    var url = 'IDVerification.aspx';
    var category = $("#category_select").val().substring(0, 4);
    var subcategory = $("#subcategory_select").val() != "" ? $("#subcategory_select").val().substring(0, 4) : "0";
    var id = $('#medicineID').val();
    var originalid = useOriginalID ? $('#medicineIDOriginal').html() : "";

    if (id.length != 0) {
        var xhttp = new XMLHttpRequest();
        xhttp.onreadystatechange = function () {
            if (this.readyState == 4 && this.status == 200) {
                if (this.responseText != "") {
                    alert(this.responseText);
                    $('#medicineID').val(originalid);
                    /*if (useOriginalID) {

                        $('#category_select').val($('#categorySelectOriginal').html().replace("&amp;", "&"));
                        $('#subcategory_select').val($('#subcategorySelectOriginal').html().replace("&amp;", "&"));
                    }*/
                    $('#medicineID').focus();
                }
            }
        };
        xhttp.open("GET", "IDVerification.aspx?category=" + category + "&subcategory=" + subcategory + "&id=" + id + "&originalID=" + originalid, true);
        xhttp.send();
    }
}

function GetURLParameter(sParam) {
    var sPageURL = window.location.search.substring(1);
    var sURLVariables = sPageURL.split('&');
    for (var i = 0; i < sURLVariables.length; i++) {
        var sParameterName = sURLVariables[i].split('=');
        if (sParameterName[0] == sParam) {
            return sParameterName[1];
        }
    }
    return null;
}

function clearSearch() {
    removeAllMarks();
    $('.treeview').children().show();
    $('#view-search').val('');
    $('.treeview').treeView('collapseAll');


}

function removeAllMarks() {
    var parent = $('.treeview').find('mark').parent();
    $('.treeview').find('mark').contents().unwrap();
    parent.html(function (i, html) {
        return html;
    });

    // expand items which have something
    $('.treeview').find('.contains-items').off("click");
    $('.treeview').find('.contains-items').on('click', function (event) {
        if ($(event.target).hasClass('contains-items')) {
            // expand icon
            $(this).toggleClass('items-expanded');
            // the inner list
            var $a = $(this).find('>ul');
            // slide effect
            $a.slideToggle();
            // stop propagation of inner elements
            event.stopPropagation();
        }
    });
}