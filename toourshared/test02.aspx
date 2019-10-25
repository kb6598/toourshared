<%@ Page Language="C#" %>

<!DOCTYPE html>

<script runat="server">

    protected void Button1_Click(object sender, EventArgs e)
    {
        Session["mem_id"] = "";
        Session.Abandon();
        Response.Redirect("test.aspx");
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
        <% 
            if (Session["mem_id"] == null)
            {
        %>
               로그인 안됨
        <%  
            }
            else
            {
        %>
                <div class = 'statebar1'> <% string id = Session["mem_id"].ToString(); Response.Write($"{id}님 반갑습니다."); %></div><br />
                <asp:Button ID="Button1" runat="server" Text="로그아웃" OnClick="Button1_Click" />
               
        <% 
            }
        %>
        </div>
    </form>
</body>
</html>
