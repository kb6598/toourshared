<%@ Page Language="C#" EnableEventValidation="false" %>

<!DOCTYPE html>

<script runat="server">

    protected void Page_Load(object sender, EventArgs e)
    {

    }
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <table>
                <tr>
                    <td>제목 : </td>
                    <td>
                        <asp:TextBox ID="title" runat="server" TextMode="MultiLine" Width="400px" Height="100px"></asp:TextBox></td>
                </tr>
                <tr>
                    <td>내용 :</td>
                    <td>
                        <asp:TextBox ID="article" runat="server" TextMode="MultiLine" Width="400px" Height="100px"></asp:TextBox></td>
                </tr>
                <tr>
                    <td>해시태그 :</td>
                    <td>
                        <asp:TextBox ID="hashtag" runat="server" TextMode="MultiLine" Width="400px" Height="100px"></asp:TextBox></td>
                </tr>
                <tr>
                    <td>마커 좌표 :</td>
                    <td>
                        <asp:TextBox TextMode="MultiLine" ID="marker" runat="server" Width="400px" Height="100px"></asp:TextBox></td>
                </tr>
                <tr>
                    <td>선 Path :</td>
                    <td>
                        <asp:TextBox TextMode="MultiLine" ID="polyline" runat="server" Width="400px" Height="100px"></asp:TextBox></td>
                </tr>
                <tr>
                    <td>원 Path :</td>
                    <td>
                        <asp:TextBox TextMode="MultiLine" ID="circles" runat="server" Width="400px" Height="100px"></asp:TextBox></td>
                </tr>
                <tr>
                    <td>사각형 Path :</td>
                    <td>
                        <asp:TextBox TextMode="MultiLine" ID="rects" runat="server" Width="400px" Height="100px"></asp:TextBox></td>
                </tr>
                <tr>
                    <td>다각형 Path :</td>
                    <td>
                        <asp:TextBox TextMode="MultiLine" ID="polygons" runat="server" Width="400px" Height="100px"></asp:TextBox></td>
                </tr>
            </table>
        </div>
    </form>
</body>
</html>
