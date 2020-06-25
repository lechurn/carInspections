<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="carInspections.Register" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title> Register an account with us</title>
    <script src="scripts/jquery.1.9.1/jquery.min.js"></script>
    <link href="bootstrap-4.0.0-dist/css/bootstrap.min.css" rel="stylesheet" />
    <script src="bootstrap-4.0.0-dist/js/bootstrap.min.js"></script>
</head>
<body>
<form id="form1" runat="server">
        <div class="container h-100">
            <div class="row justify-content-center align-items-center pt-5">     
                <div class="col-offset-4 col-4">
                    <div class="form-group">
                        <div class="input-group">
                            <asp:TextBox ID="txtUsername" runat="server" placeholder="Username"></asp:TextBox>
                        </div>
                    </div>
                     <div class="form-group">
                        <div class="input-group">
                            <asp:TextBox ID="txtPassword" runat="server" TextMode="Password"></asp:TextBox>
                        </div>
                    </div>
                    <div class="form-group d-none">
                        <div class="input-group">
                            <asp:TextBox ID="txtCfmPassword" runat="server" TextMode="Password"></asp:TextBox>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="input-group">
                            <asp:Button ID="btnRegister" runat="server" Text="Register" OnClick="btnRegister_Click"></asp:Button>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="input-group">
                            <asp:Label ID="errorMessage" runat="server"></asp:Label>
                            <asp:Button ID="btnSign" runat="server" CssClass="btn btn-link" Text="Already Registered ? Click here to Sign In" OnClick="btnSign_Click"></asp:Button>
                        </div>
                    </div>
                </div>
            </div>
        </div>    
    </form>
</body>
</html>
