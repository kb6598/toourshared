<%@ Page Language="C#" %>

<!DOCTYPE html>

<script runat="server">

    protected void Button1_Click(object sender, EventArgs e)
    {
        Response.Cookies["mem_id"].Expires = DateTime.Now.AddHours(-99);
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
            if (Request.Cookies["mem_id"] == null)
            {
        %>
               로그인 안됨
        <%  
            }
            else
            {
        %>
                <div class = 'statebar1'> <% string id = Request.Cookies["mem_id"].Value.ToString(); Response.Write($"{id}님 반갑습니다."); %></div><br />
                <asp:Button ID="Button1" runat="server" Text="로그아웃" OnClick="Button1_Click" />
               
        <% 
            }
        %>
        </div>
    </form>
</body>
</html>
