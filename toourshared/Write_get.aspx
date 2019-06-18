<%@ Page Language="C#" EnableEventValidation="false"%>

<!DOCTYPE html>

<script runat="server">

    protected void Page_Load(object sender, EventArgs e)
    {
        Request.QueryString.Get("TextBox1");
        Request.QueryString.Get("TextBox2");
        Request.QueryString.Get("TextBox3");
    }
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            제목 : <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox><br />
            내용 : <asp:TextBox ID="TextBox2" runat="server"></asp:TextBox><br />
            해시태그 : <asp:TextBox ID="TextBox3" runat="server"></asp:TextBox>


        </div>
    </form>
</body>
</html>
