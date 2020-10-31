<%@ Page Title="新增藥品" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="NewMedicine.aspx.cs" Inherits="PrescriptionManual.NewMedicine" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class='alert alert-warning alert-stick-top' id="unsaved_warning_alert" style="display: none;">
    </div>
    <div class="jumbotron">

        <h1><%= Title %></h1>
        <h3 id="editing_title" runat="server"><span class='label label-info'>新增</span></h3>
    </div>

    <div runat="server" id="info_container_control"></div>
    <div class="row" id="info_container">
        <div class="col-md-12">
            <div class="panel panel-primary">
                <div class="panel-heading">
                    藥品基本資訊
                </div>
                <div class="panel-body">
                    <div id="medicineMCategoryContainer" class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="category_select">藥品類別：</label>
                                <select id="category_select" runat="server" clientidmode="Static" class="form-control" onchange="update_subcategory_select_updateMedicine()">
                                </select>
                                <div id="categorySelectOriginal" clientidmode="Static" class="hidden" runat="server"></div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="subcategory_select">藥品次類別：</label>
                                <select id="subcategory_select" runat="server" clientidmode="Static" class="form-control" onmousedown="update_subcategory_select_updateMedicine()">
                                </select>
                                <div id="subcategorySelectOriginal" clientidmode="Static" class="hidden" runat="server"></div>
                            </div>
                        </div>
                    </div>
                    <div id="medicineIDContainer" class="row">
                        <div class="col-md-12">
                            <div class="form-inline">
                                <div class="form-group">
                                    <label for="medicineID">藥品ID (可括號註記)：</label>
                                    <asp:TextBox runat="server" TextMode="Number" ID="medicineID" ClientIDMode="Static" CssClass="form-control width-full" placeholder="輸入藥品ID" />
                                    <asp:LinkButton runat="server" ID="medicineIDAutoFill" ClientIDMode="Static" CssClass="btn btn-default" data-toggle="tooltip" data-placement="top" title="" data-original-title="自動填入" OnClick="AutoFillClicked">
                                        <span class="glyphicon glyphicon-flash"></span>
                                    </asp:LinkButton>
                                    <div id="medicineIDControl" class="hidden" runat="server"></div>
                                </div>
                                <div class="form-group">
                                    <div class="input-group">
                                        <span class="input-group-addon">(</span>
                                        <asp:TextBox runat="server" ID="medicineIDNote" ClientIDMode="Static" CssClass="form-control width-full" placeholder="備註(可留空)" />
                                        <span class="input-group-addon">)</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div id="medicineNameContainer" class="row" style="margin-top: 4px">
                        <div class="col-md-12">
                            <div class="form-inline">
                                <div class="form-group">
                                    <label for="searchbar">藥品名稱 (可括號註明常用商品名...等)：</label>
                                    <asp:TextBox runat="server" ID="medicineName" ClientIDMode="Static" CssClass="form-control width-full" placeholder="輸入藥品名稱" />
                                </div>
                                <div class="form-group">
                                    <div class="input-group">
                                        <span class="input-group-addon">(</span>
                                        <asp:TextBox runat="server" ID="medicineName2" ClientIDMode="Static" CssClass="form-control width-full" placeholder="輸入其他名稱(可留空)" />
                                        <span class="input-group-addon">)</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <hr />
                    <h3>Dosage Form:
                        <a id="AddDosageForm" class="btn btn-default btn-sm" onclick="AddDosageForm()">新增欄位</a>
                        <a id="AddDosageFormNote" class="btn btn-default btn-sm" onclick="AddDosageFormNote()">新增/刪除註解</a>
                    </h3>
                    <asp:Label runat="server" CssClass="hidden" ClientIDMode="Static" ID="DF_Count" Text="0" />
                    <asp:Textbox runat="server" CssClass="hidden" ClientIDMode="Static" ID="medicineMID" Text="" />
                    <asp:Textbox runat="server" CssClass="hidden" ClientIDMode="Static" ID="medicineSubName1" Text="" />
                    <asp:Textbox runat="server" CssClass="hidden" ClientIDMode="Static" ID="medicineSubName2" Text="" />
                    <asp:Textbox runat="server" CssClass="hidden" ClientIDMode="Static" ID="medicineDosage" Text="" />
                    <asp:Textbox runat="server" CssClass="hidden" ClientIDMode="Static" ID="medicineForm" Text="" />
                    <asp:Textbox runat="server" CssClass="hidden" ClientIDMode="Static" ID="medicineDFNote" Text="" />
                    <div id="DosageFormContainer" runat="server"></div>
                    <!--<div id="DosageFormContainer1" runat="server">
                        <div class="row" id='DosageFormRow_0">
                            <div class="form-inline col-md-12">
                                <div class="form-group">
                                    <div class="input-group">
                                        <span class="input-group-addon">1.</span>
                                        <asp:TextBox runat="server" ID="medicineMID_1" ClientIDMode="Static" CssClass="form-control width-full" Width="110" placeholder="電腦代碼" />
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="input-group">
                                        <asp:TextBox runat="server" ID="medicineSubName1_1" ClientIDMode="Static" CssClass="form-control width-full" Width="130" placeholder="統一藥名" />
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="input-group">
                                        <span class="input-group-addon">(</span>
                                        <asp:TextBox runat="server" ID="medicineSubName2_1" ClientIDMode="Static" CssClass="form-control width-full" Width="100" placeholder="(可留空)" />
                                        <span class="input-group-addon">)</span>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="input-group">
                                        <asp:TextBox runat="server" ID="medicineDosage_1" ClientIDMode="Static" CssClass="form-control width-full" placeholder="藥品規格" />
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="input-group">
                                        <select id="medicineForm_1" runat="server" class="form-control">
                                            <option value="">單位</option>
                                            <option value="Amp.">Amp.</option>
                                            <option value="Btl.">Btl.</option>
                                            <option value="Cap.">Cap.</option>
                                            <option value="Supp.">Supp.</option>
                                            <option value="Tab.">Tab.</option>
                                            <option value="Vial.">Vial.</option>
                                            <option value="mL.">mL.</option>
                                            <option value="Bag">Bag</option>
                                            <option value="Film">Film</option>
                                            <option value="Pack">Pack</option>
                                            <option value="Patch">Patch</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="input-group">
                                        <asp:TextBox runat="server" ID="medicineDFNote_1" ClientIDMode="Static" CssClass="form-control width-full" placeholder="註解(可留空)" />
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="input-group">
                                        <asp:Button runat="server" Text="刪除" CssClass="btn btn-danger btn-sm" />
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>-->
                    <div id="DosageFormNoteContainer" style="display: none;">
                        <asp:TextBox runat="server" ID="DosageFormNote" ClientIDMode="Static" CssClass="form-control width-full" placeholder="輸入整體註解 (可留空)" />
                    </div>
                    <hr />
                    <h3>Usual Dose:
                        <a class="btn btn-sm btn-default" data-toggle="tooltip" data-placement="top" title="" data-original-title="加粗體" onclick="insert('{', '}')"><span class="glyphicon glyphicon-bold"></span></a>
                        <a class="btn btn-sm btn-default" data-toggle="tooltip" data-placement="top" title="" data-original-title="加斜體" onclick="insert('<<', '>>')"><span class="glyphicon glyphicon-italic"></span></a>
                        <a class="btn btn-sm btn-default" data-toggle="tooltip" data-placement="top" title="" data-original-title="加方括號" onclick="insert('[', ']')">[ ]</a>
                    </h3>
                    <div id="UsualDoseContainer">
                        <div class="form-group">
                            <asp:TextBox CssClass="form-control" ClientIDMode="Static" ID="UsualDose" TextMode="multiline" Rows="7" runat="server" />
                            <span class="help-block">也可以手動輸入：<br />
                                &lt;&lt;Text&gt;&gt;表示斜體<i>Text</i><br />
                                {Text}表示粗體<b>Text</b><br />
                                [DosageForm]表示不同的<b>[Dosage Form]</b></span>
                        </div>
                    </div>
                    <hr />

                    <div id="medicineCategoryContainer" class="form-inline">
                        <h3 style="display: inline">Category: </h3>
                        <div class="form-group">
                            <div class="input-group">
                                <select id="medicineCategory" runat="server" class="form-control" onchange="checkOthers();">
                                    <option value=""></option>
                                    <option value="A">A</option>
                                    <option value="B">B</option>
                                    <option value="C">C</option>
                                    <option value="D">D</option>
                                    <option value="X">X</option>
                                    <option value="Others">其他</option>
                                </select>
                            </div>
                            <div class="input-group">
                                <asp:TextBox runat="server" ID="medicineCategoryNote" ClientIDMode="Static" CssClass="form-control width-full" Width="400" placeholder="備註(可留空)" />
                            </div>
                        </div>
                    </div>
                    <hr />
                    <h3>Note:</h3>
                    <div id="NoteContainer">
                        <div class="form-group">
                            <asp:TextBox CssClass="form-control" ClientIDMode="Static" ID="medicineNote" TextMode="multiline" Rows="4" runat="server" />
                            <span class="help-block">輸入注意事項，包括儲存、安定性、泡製方式與藥效等。</span>
                        </div>
                    </div>
                    <hr />
                    <div class="row">
                        <div class="col-md-12">
                            <a class="btn btn-info" data-toggle="modal" data-target="#previewWindow" onclick="updatePreviewWindow();">預覽</a>
                            <asp:Button runat="server" CssClass="btn btn-success" Text="新增" OnClick="InsertMedicine" />
                            <a class="btn btn-danger" href="NewMedicine.aspx">捨棄</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div id="previewWindow" class="modal fade" role="dialog">
        <div class="modal-dialog" style="max-width: 1200px; width: 90%;">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title">預覽</h4>
                </div>
                <div class="modal-body">


                    <div class="row" style="margin-top: 20px">
                        <div class="col-md-1">
                            <a class="btn btn-primary" data-dismiss="modal">返回</a>
                        </div>
                        <div class="col-md-11">
                            <ul class="breadcrumb">
                                <li><a href="#" id="previewMCategory">cat</a></li>
                                <li id="previewMSubCategoryContainer"><a href="#" id="previewMSubCategory">subcat</a></li>
                                <li class="active"><span id="previewID">1230</span>. <span id="previewIDNote">(IDNote)</span> <span id="previewNameTop">Medi</span></li>
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
                                        <strong id="previewName">Name</strong> <span id="previewName2">(Name2)</span>
                                    </h2>
                                    <h3>Dosage Form:</h3>
                                    <div id="previewDFContainer">
                                        <h3 class="margin-2">
                                            <u>mID</u>
                                            <strong>subname <span class="smaller">(subname2)</span>
                                            </strong>
                                            DF_dosage[i]<span class='fr'>FORM</span>
                                        </h3>
                                        <h4 class='display-4 margin-2'>(NOTE)</h4>
                                    </div>
                                    <h4 class='display-4 margin-2' id="previewDosFormNote"></h4>

                                    <h3>Usual Dose:</h3>
                                    <h3 style="margin-left: 2em; line-height: 1.4" id="previewUsualDose">This is Usual Dose
                                    </h3>

                                    <div id="previewCategoryContainer">
                                        <h3>Category: <span id="previewCategory"></span></h3>
                                    </div>
                                    <h3 class='margin-2' id="previewCategoryNote">Category Note</h3>

                                    <div id="previewNoteContainer">
                                        <h3>Note:</h3>
                                        <h3 class='margin-2' id="previewNote">complete note</h3>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <a class="btn btn-default" data-dismiss="modal">關閉預覽</a>
                    <asp:Button runat="server" CssClass="btn btn-success" Text="新增" OnClick="InsertMedicine" />
                </div>
            </div>
        </div>
    </div>
    <script src="Scripts/custom-scripts.js"></script>
    <script>
        $('#medicineID').change(function () {
            verifyID(false);
        })

        /*$(document).ready(function () {
            $('#category_select').val($('#categorySelectOriginal').html().replace('&amp;', '&'));
            $('#subcategory_select').val($('#subcategorySelectOriginal').html().replace('&amp;', '&'));
        })

        $('#medicineIDAutoFill').mousedown(function () {
            $('#categorySelectOriginal').html($('#category_select').val());
            $('#subcategorySelectOriginal').html($('#subcategory_select').val());
        })*/

        //update_subcategory_select_updateMedicine();
    </script>

    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:PrescriptionManual %>" DeleteCommand="DELETE FROM [Medicines] WHERE [InternalID] = @InternalID" InsertCommand="INSERT INTO [Medicines] ([MCategoryID], [MSubCategoryID], [ID], [IDNote], [Name], [Name2], [DF_mID], [DF_subname], [DF_subname2], [DF_dosage], [DF_form], [DF_note], [DosFormNote], [UsualDose], [Category], [CategoryNote], [Note], [ImagePaths]) VALUES (@MCategoryID, @MSubCategoryID, @ID, @IDNote, @Name, @Name2, @DF_mID, @DF_subname, @DF_subname2, @DF_dosage, @DF_form, @DF_note, @DosFormNote, @UsualDose, @Category, @CategoryNote, @Note, @ImagePaths)" SelectCommand="SELECT [InternalID], [MCategoryID], [MSubCategoryID], [ID], [IDNote], [Name], [Name2], [DF_mID], [DF_subname], [DF_subname2], [DF_dosage], [DF_form], [DF_note], [DosFormNote], [UsualDose], [Category], [CategoryNote], [Note], [ImagePaths] FROM [Medicines]" UpdateCommand="UPDATE [Medicines] SET [MCategoryID] = @MCategoryID, [MSubCategoryID] = @MSubCategoryID, [ID] = @ID, [IDNote] = @IDNote, [Name] = @Name, [Name2] = @Name2, [DF_mID] = @DF_mID, [DF_subname] = @DF_subname, [DF_subname2] = @DF_subname2, [DF_dosage] = @DF_dosage, [DF_form] = @DF_form, [DF_note] = @DF_note, [DosFormNote] = @DosFormNote, [UsualDose] = @UsualDose, [Category] = @Category, [CategoryNote] = @CategoryNote, [Note] = @Note, [ImagePaths] = @ImagePaths WHERE [InternalID] = @InternalID">
            <DeleteParameters>
                <asp:Parameter Name="InternalID" Type="Int32" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="MCategoryID" Type="Int32" />
                <asp:Parameter Name="MSubCategoryID" Type="Int32" />
                <asp:Parameter Name="ID" Type="Int32" />
                <asp:Parameter Name="IDNote" Type="String" />
                <asp:Parameter Name="Name" Type="String" />
                <asp:Parameter Name="Name2" Type="String" />
                <asp:Parameter Name="DF_mID" Type="String" />
                <asp:Parameter Name="DF_subname" Type="String" />
                <asp:Parameter Name="DF_subname2" Type="String" />
                <asp:Parameter Name="DF_dosage" Type="String" />
                <asp:Parameter Name="DF_form" Type="String" />
                <asp:Parameter Name="DF_note" Type="String" />
                <asp:Parameter Name="DosFormNote" Type="String" />
                <asp:Parameter Name="UsualDose" Type="String" />
                <asp:Parameter Name="Category" Type="String" />
                <asp:Parameter Name="CategoryNote" Type="String" />
                <asp:Parameter Name="Note" Type="String" />
                <asp:Parameter Name="ImagePaths" Type="String" />
            </InsertParameters>
            <UpdateParameters>
                <asp:Parameter Name="MCategoryID" Type="Int32" />
                <asp:Parameter Name="MSubCategoryID" Type="Int32" />
                <asp:Parameter Name="ID" Type="Int32" />
                <asp:Parameter Name="IDNote" Type="String" />
                <asp:Parameter Name="Name" Type="String" />
                <asp:Parameter Name="Name2" Type="String" />
                <asp:Parameter Name="DF_mID" Type="String" />
                <asp:Parameter Name="DF_subname" Type="String" />
                <asp:Parameter Name="DF_subname2" Type="String" />
                <asp:Parameter Name="DF_dosage" Type="String" />
                <asp:Parameter Name="DF_form" Type="String" />
                <asp:Parameter Name="DF_note" Type="String" />
                <asp:Parameter Name="DosFormNote" Type="String" />
                <asp:Parameter Name="UsualDose" Type="String" />
                <asp:Parameter Name="Category" Type="String" />
                <asp:Parameter Name="CategoryNote" Type="String" />
                <asp:Parameter Name="Note" Type="String" />
                <asp:Parameter Name="ImagePaths" Type="String" />
                <asp:Parameter Name="InternalID" Type="Int32" />
            </UpdateParameters>
        </asp:SqlDataSource>

</asp:Content>
