<%@ Page Language="C#" AutoEventWireup="true" CodeFile="SignIn.aspx.cs" Inherits="carInspections.WebPages.SignIn" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script src="scripts/jquery.1.9.1/jquery.min.js"></script>
    <link href="bootstrap-4.0.0-dist/css/bootstrap.min.css" rel="stylesheet" />
    <script src="bootstrap-4.0.0-dist/js/bootstrap.min.js"></script>
</head>
<body>

            <form id="form1" runat="server" class="col-12">
                    <div class="container h-100">
                        <div class="row">
                            <div class="col-4">
                                &nbsp;
                            </div>
                            <div class="col-4">
                                    &nbsp;                         
                            </div>
                            <div class="col-4">

                            </div>
                        </div>
                        <div class="row justify-content-center align-items-center pt-5">        
                            <div class="col-offset-4 col-4">
                                <div class="form-group">
                                    <div class="input-group">
                                    <asp:TextBox ID="txtUsername" runat="server" placeholder="Username"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="input-group">
                                        <asp:TextBox ID="txtPassword" runat="server" placeholder="Password" TextMode="Password"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="input-group">
                                        <asp:Button ID="btnLogin" runat="server" Text="Login"  CssClass="btn" OnClick="btnLogin_Click"/>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="input-group">
                                        <asp:Label ID="errorMessage" runat="server"></asp:Label>
                                    </div>
                                </div>
                            </div>                    
                        </div>
                    </div>
            </form> 
</body>
</html>
