<%@ Page Title="更新藥品類別" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="UpdateCategory.aspx.cs" Inherits="PrescriptionManual.UpdateCategory" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <script src="Scripts/custom-scripts.js"></script>
    <div class="jumbotron">
        <h1><%= Title %></h1>
    </div>


    <div class="row">
        <asp:GridView ID="GridView1" runat="server" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="InternalID" DataSourceID="SqlDataSource1" CssClass="table table-hover" ShowFooter="True">
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
                <asp:TemplateField HeaderText="類別代碼" SortExpression="MCategoryID">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("MCategoryID") %>' TextMode="Number"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvEditCategoryID" runat="server" ErrorMessage="類別代碼不可為空" ControlToValidate="TextBox1" Text="*" ForeColor="Red">
                        </asp:RequiredFieldValidator>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label1" runat="server" Text='<%# Bind("MCategoryID") %>'></asp:Label>
                    </ItemTemplate>
                    <FooterTemplate>
                        <asp:TextBox ID="tbCategoryID" runat="server" TextMode="Number"></asp:TextBox>
                        <asp:RequiredFieldValidator ValidationGroup="INSERT" ID="rfvCategoryID" runat="server" ErrorMessage="請輸入類別代碼" ControlToValidate="tbCategoryID" Text="*" ForeColor="Red">
                        </asp:RequiredFieldValidator>
                    </FooterTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="類別名稱" SortExpression="MCategoryName">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("MCategoryName") %>'></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvEditCategoryName" runat="server" ErrorMessage="類別名稱不可為空" ControlToValidate="TextBox2" Text="*" ForeColor="Red">
                        </asp:RequiredFieldValidator>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label2" runat="server" Text='<%# Bind("MCategoryName") %>'></asp:Label>
                    </ItemTemplate>
                    <FooterTemplate>
                        <asp:TextBox ID="tbCategoryName" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator ValidationGroup="INSERT" ID="rfvCategoryName" runat="server" ErrorMessage="請輸入類別名稱" ControlToValidate="tbCategoryName" Text="*" ForeColor="Red">
                        </asp:RequiredFieldValidator>
                    </FooterTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
        <asp:ValidationSummary ID="ValidationSummary1" ValidationGroup="INSERT" ForeColor="Red" runat="server" />
        <asp:ValidationSummary ID="ValidationSummary2" ForeColor="Red" runat="server" />
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConflictDetection="CompareAllValues" ConnectionString="<%$ ConnectionStrings:PrescriptionManual %>" DeleteCommand="DELETE FROM [MCategories] WHERE [InternalID] = @original_InternalID AND [MCategoryID] = @original_MCategoryID AND (([MCategoryName] = @original_MCategoryName) OR ([MCategoryName] IS NULL AND @original_MCategoryName IS NULL))" InsertCommand="INSERT INTO [MCategories] ([MCategoryID], [MCategoryName]) VALUES (@MCategoryID, @MCategoryName)" OldValuesParameterFormatString="original_{0}" SelectCommand="SELECT * FROM [MCategories] ORDER BY [MCategoryID]" UpdateCommand="UPDATE [MCategories] SET [MCategoryID] = @MCategoryID, [MCategoryName] = @MCategoryName WHERE [InternalID] = @original_InternalID AND [MCategoryID] = @original_MCategoryID AND (([MCategoryName] = @original_MCategoryName) OR ([MCategoryName] IS NULL AND @original_MCategoryName IS NULL))">
            <DeleteParameters>
                <asp:Parameter Name="original_InternalID" Type="Int32" />
                <asp:Parameter Name="original_MCategoryID" Type="Int32" />
                <asp:Parameter Name="original_MCategoryName" Type="String" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="MCategoryID" Type="Int32" />
                <asp:Parameter Name="MCategoryName" Type="String" />
            </InsertParameters>
            <UpdateParameters>
                <asp:Parameter Name="MCategoryID" Type="Int32" />
                <asp:Parameter Name="MCategoryName" Type="String" />
                <asp:Parameter Name="original_InternalID" Type="Int32" />
                <asp:Parameter Name="original_MCategoryID" Type="Int32" />
                <asp:Parameter Name="original_MCategoryName" Type="String" />
            </UpdateParameters>
        </asp:SqlDataSource>
    </div>

</asp:Content>
