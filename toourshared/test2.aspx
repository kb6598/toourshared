<%@ Page Language="C#" %>

<!DOCTYPE html>

<script runat="server">

    protected void Button_selecttag_Click(object sender, EventArgs e)
    {
        List<Travel> travelList;
        Travel travel = new Travel();
        TravelDao tra = new TravelDao();

        travel.Trv_tag = txtTag.Text;
        int start = 1;
        int count = 10;

        travelList = tra.SelectTagTravel(travel, start, count);

        txt1.Text = travelList[0].Trv_no;
        txt2.Text = travelList[0].Trv_title;
        txt3.Text = travelList[0].Trv_timestamp;
        txt4.Text = travelList[0].Trv_create_time;
        
        


        
       
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
            태그로 검색하기
            <asp:TextBox ID="txtTag" runat="server"></asp:TextBox><br />
            <asp:Button ID="Button_selecttag" runat="server" Text="Button" OnClick="Button_selecttag_Click" />
            <br />
            결과
            <asp:TextBox ID="txt1" runat="server"></asp:TextBox>
            <asp:TextBox ID="txt2" runat="server"></asp:TextBox>
            <asp:TextBox ID="txt3" runat="server"></asp:TextBox>
            <asp:TextBox ID="txt4" runat="server"></asp:TextBox>

            
        </div>
    </form>
</body>
</html>
