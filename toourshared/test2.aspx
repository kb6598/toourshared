<%@ Page Language="C#" %>

<!DOCTYPE html>

<script runat="server">

    protected void Button_selecttag_Click(object sender, EventArgs e)
    {

        List<Travel> travelList;
        Travel travel = new Travel();

        TravelDao tra = new TravelDao();

        travel.Trv_tag = txtTag.Text;
        string like = "'%" + txtTag.Text + "%'";

        travelList = tra.selectAll(travel, like);

        txt1.Text = travelList[1].Trv_no;
        txt2.Text = travelList[1].Trv_title;
        txt3.Text = travelList[1].Trv_timestamp;



    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if(RadioButton1.Checked == true)
        {
            List<Travel> travelList;
            Travel travel = new Travel();

            TravelDao tra = new TravelDao();


            travelList = tra.test(travel);

            txt1.Text = travelList[1].Trv_no;
            txt2.Text = travelList[1].Trv_title;
            txt3.Text = travelList[1].Trv_timestamp;
        }
        else if(RadioButton2.Checked == true)
        {
            txt1.Text = "";
            txt2.Text = "";
            txt3.Text = "";
        }

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
            <br />
            <asp:RadioButton ID="RadioButton1" runat="server" GroupName="select" AutoPostBack="true" Checked="true"/> 최신순
            <asp:RadioButton ID="RadioButton2" runat="server" GroupName="select" AutoPostBack="true"/> 인기순
            <asp:RadioButton ID="RadioButton3" runat="server" GroupName="select" AutoPostBack="true"/> 팔로워
            <asp:RadioButton ID="RadioButton4" runat="server" GroupName="select" AutoPostBack="true"/> HOT


            
        </div>
    </form>
</body>
</html>
