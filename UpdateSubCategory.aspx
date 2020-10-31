<%@ Page Title="更新藥品次類別" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="UpdateSubCategory.aspx.cs" Inherits="PrescriptionManual.UpdateSubCategory" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <script src="Scripts/custom-scripts.js"></script>
    <div class="jumbotron">
        <h1><%= Title %></h1>
    </div>


    <div class="row">
        <asp:GridView ID="GridView1" runat="server" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="InternalID" DataSourceID="SqlDataSource1" CssClass="table table-hover" ShowFooter="True" AllowPaging="True" PageSize="40">
            <Columns>
                <asp:TemplateField ShowHeader="False">
                    <EditItemTemplate>
                        <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="True" CommandName="Update" Text="更新"></asp:LinkButton>
                        &nbsp;<asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" CommandName="Cancel" Text="取消"></asp:LinkButton>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" CommandName="Edit" Text="編輯"></asp:LinkButton>
                        &nbsp;<asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" CommandName="Delete" Text="刪除"></asp:LinkButton>
                    </ItemTemplate>
                    <FooterTemplate>
                        <asp:LinkButton ID="lbInsert" runat="server"
                            CommandName="Insert" OnClick="lbInsert_Click" ValidationGroup="INSERT" CausesValidation="True">新增</asp:LinkButton>
                    </FooterTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="InternalID" HeaderText="InternalID" InsertVisible="False" ReadOnly="True" SortExpression="InternalID" Visible="False" />
                <asp:TemplateField HeaderText="次類別代碼" SortExpression="MSubCategoryID">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("MSubCategoryID") %>' TextMode="Number"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvEditSubCategoryID" runat="server" ErrorMessage="次類別代碼不可為空" ControlToValidate="TextBox1" Text="*" ForeColor="Red">
                        </asp:RequiredFieldValidator>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label1" runat="server" Text='<%# Bind("MSubCategoryID") %>'></asp:Label>
                    </ItemTemplate>
                    <FooterTemplate>
                        <asp:TextBox ID="tbSubCategoryID" runat="server" TextMode="Number"></asp:TextBox>
                        <asp:RequiredFieldValidator ValidationGroup="INSERT" ID="rfvSubCategoryID" runat="server" ErrorMessage="請輸入次類別代碼" ControlToValidate="tbSubCategoryID" Text="*" ForeColor="Red">
                        </asp:RequiredFieldValidator>
                    </FooterTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="次類別名稱" SortExpression="MSubCategoryName">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("MSubCategoryName") %>'></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvEditSubCategoryName" runat="server" ErrorMessage="次類別名稱不可為空" ControlToValidate="TextBox2" Text="*" ForeColor="Red">
                        </asp:RequiredFieldValidator>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label2" runat="server" Text='<%# Bind("MSubCategoryName") %>'></asp:Label>
                    </ItemTemplate>
                    <FooterTemplate>
                        <asp:TextBox ID="tbSubCategoryName" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator ValidationGroup="INSERT" ID="rfvSubCategoryName" runat="server" ErrorMessage="請輸入次類別名稱" ControlToValidate="tbSubCategoryName" Text="*" ForeColor="Red">
                        </asp:RequiredFieldValidator>
                    </FooterTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
        <asp:ValidationSummary ID="ValidationSummary1" ValidationGroup="INSERT" ForeColor="Red" runat="server" />
        <asp:ValidationSummary ID="ValidationSummary2" ForeColor="Red" runat="server" />
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConflictDetection="CompareAllValues" ConnectionString="<%$ ConnectionStrings:PrescriptionManual %>" DeleteCommand="DELETE FROM [MSubCategories] WHERE [InternalID] = @original_InternalID AND [MSubCategoryID] = @original_MSubCategoryID AND (([MSubCategoryName] = @original_MSubCategoryName) OR ([MSubCategoryName] IS NULL AND @original_MSubCategoryName IS NULL))" InsertCommand="INSERT INTO [MSubCategories] ([MSubCategoryID], [MSubCategoryName]) VALUES (@MSubCategoryID, @MSubCategoryName)" OldValuesParameterFormatString="original_{0}" SelectCommand="SELECT * FROM [MSubCategories] ORDER BY [MSubCategoryID]" UpdateCommand="UPDATE [MSubCategories] SET [MSubCategoryID] = @MSubCategoryID, [MSubCategoryName] = @MSubCategoryName WHERE [InternalID] = @original_InternalID AND [MSubCategoryID] = @original_MSubCategoryID AND (([MSubCategoryName] = @original_MSubCategoryName) OR ([MSubCategoryName] IS NULL AND @original_MSubCategoryName IS NULL))">
            <DeleteParameters>
                <asp:Parameter Name="original_InternalID" Type="Int32" />
                <asp:Parameter Name="original_MSubCategoryID" Type="Int32" />
                <asp:Parameter Name="original_MSubCategoryName" Type="String" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="MSubCategoryID" Type="Int32" />
                <asp:Parameter Name="MSubCategoryName" Type="String" />
            </InsertParameters>
            <UpdateParameters>
                <asp:Parameter Name="MSubCategoryID" Type="Int32" />
                <asp:Parameter Name="MSubCategoryName" Type="String" />
                <asp:Parameter Name="original_InternalID" Type="Int32" />
                <asp:Parameter Name="original_MSubCategoryID" Type="Int32" />
                <asp:Parameter Name="original_MSubCategoryName" Type="String" />
            </UpdateParameters>
        </asp:SqlDataSource>
    </div>

</asp:Content>
