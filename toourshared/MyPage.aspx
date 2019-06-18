<%@ Page Language="C#" %>

<!DOCTYPE html>

<script runat="server">

    protected void Button3_Click(object sender, EventArgs e)
    {
        MultiView1.ActiveViewIndex = 0;
    }

    protected void Button4_Click(object sender, EventArgs e)
    {
        MultiView1.ActiveViewIndex = 1;
    }

    protected void Button5_Click(object sender, EventArgs e)
    {
        MultiView1.ActiveViewIndex = 2;
    }
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div style="background-color: #E9E9E9">
            <table align="center">
                <!-- 상단부 -->
                <tr>
                    <td rowspan="3" align="center"><asp:Image ID="Image1" runat="server" ImageUrl="~/imgs/ironman.jpg" Width="250px" Height="250px" /></td>
                    <td style="width: 90px; height: 50px;" align="center"><asp:Label ID="Label1" runat="server" Text="아이디"></asp:Label></td>
                    <td style="width: 90px; height: 50px;" align="center"><asp:Button ID="Button1" runat="server" Text="사진 변경" /></td>
                    <td style="width: 90px; height: 50px;" align="center"><asp:Button ID="Button2" runat="server" Text="설정" /></td>
                </tr>
                <tr>
                    <td style="width: 90px; height: 50px;" align="center">
                        <asp:Label ID="Label2" runat="server" Text="게시물"></asp:Label>
                        <asp:Label ID="Label3" runat="server" Text="0"></asp:Label>
                    </td>
                    <td style="width: 90px; height: 50px;" align="center">
                        <asp:Label ID="Label4" runat="server" Text="팔로워"></asp:Label>
                        <asp:Label ID="Label5" runat="server" Text="0"></asp:Label>
                    </td>
                    <td style="width: 90px; height: 50px;" align="center">
                        <asp:Label ID="Label6" runat="server" Text="팔로잉"></asp:Label>
                        <asp:Label ID="Label7" runat="server" Text="0"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td style="width: 90px; height: 50px;" align="center">
                        <asp:Label ID="Label8" runat="server" Text="이름"></asp:Label>
                    </td>
                    <td style="width: 90px; height: 50px;"></td>
                    <td style="width: 90px; height: 50px;"></td>
                </tr>
                <tr><td colspan="4"><hr /></td></tr>
                <tr>
                    <td></td>
                    <td align="center"><asp:Button ID="Button3" runat="server" Text="게시물" OnClick="Button3_Click" /></td>
                    <td align="center"><asp:Button ID="Button4" runat="server" Text="팔로워" OnClick="Button4_Click" /></td>
                    <td align="center"><asp:Button ID="Button5" runat="server" Text="팔로잉" OnClick="Button5_Click" /></td>
                </tr>
            </table>
        </div>
        <div>
            <asp:MultiView ID="MultiView1" runat="server">
                <asp:View ID="View1" runat="server">내 게시글</asp:View>
                <asp:View ID="View2" runat="server">팔로워 리스트</asp:View>
                <asp:View ID="View3" runat="server">팔로잉 리스트</asp:View>
            </asp:MultiView>
        </div>
    </form>
</body>
</html>
