<%@ Page Language="C#" EnableEventValidation="false" ValidateRequest="false"%>
<%@ Import Namespace="MySql.Data.MySqlClient" %>
<%@ Import Namespace="MySql.Data" %>
<%@ Import Namespace="System.Data" %>

<!DOCTYPE html>

<script runat="server">

    protected void Page_Load(object sender, EventArgs e)
    {
        // 세션에 저장된 정보
        //Dictionary<string, string> newWriteStatus = new Dictionary<string, string>()
        //    {
        //        {"status","first" },
        //        { "trv_no", trv_no},
        //        { "cur_trv_day_no",trv_day_no},
        //        { "cur_day","1"},
        //        {"trv_day_cnt","1" },
        //        {"1",trv_day_no }
        //    };
        //post로 날아오는 값
        //title
        //article
        //hashtag
        //mapData
        //TravelRouteListData
        //CostItemListData
        Dictionary<string, string> WriteStatus = SessionLib.getWriteStatus();
        if (WriteStatus != null)
        {

            //-----------------------------------
            //Travel 업데이트 (필수)
            TravelDao travelDao = new TravelDao();
            Travel inTravel = new Travel();
            inTravel.Trv_no = WriteStatus["trv_no"];
            Travel curTravel = travelDao.selectTravelBytrv_no(inTravel);

          
            //loc_name을 가져와야함
            curTravel.Loc_name = Request.Form["loc_name"];
            curTravel.Trv_main_img = Request.Form["main_img"];
            curTravel.Trv_no = WriteStatus["trv_no"];
            curTravel.Trv_secret = Request.Form["trv_secret"];
            curTravel.Trv_tag = Request.Form["hashtag"];
            curTravel.Trv_timestamp = TimeLib.GetTimeStamp();
            curTravel.Trv_title = Request.Form["title"];

            travelDao.UpdatetTravel(curTravel);


            //--------------------------------------
            // Travel_day 업데이트
            Travel_Day inTravel_Day = new Travel_Day();
            Travel_DayDao travel_DayDao = new Travel_DayDao();
            // 작업중인던 Trv_day_no 가져옴
            inTravel_Day.Trv_day_no = WriteStatus[WriteStatus["cur_day"]];
            inTravel_Day.Trv_no = WriteStatus[WriteStatus["trv_no"]];
            inTravel_Day.Trv_day_content = Request.Form["article"];




        }
        else
        {

        }




        //title.Text = Request.Form["title"].ToString();
        foreach(var item in Request.Form)
        {
            mapData.Text = Request.Form["mapData"];
            TravelRouteListData.Text = Request.Form["TravelRouteListData"];
            CostItemListData.Text = Request.Form["CostItemListData"];
            //foreach(var i in Request.Form[item.ToString()])
            //{
            //    Response.Write(i);
            //}
        }
    }
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=ebcd0c1accbe0ff4bbb47bd777ef2fcf&libraries=service&libraries=services,clusterer,drawing"></script>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <table>
                <tr>
                    <td>제목 : </td>
                    <td>
                        <asp:TextBox ID="title"  runat="server" TextMode="MultiLine" Width="400px" Height="100px"></asp:TextBox></td>
                </tr>
                <tr>
                    <td>내용 :</td>
                    <td>
                        <asp:TextBox ID="article"  runat="server" TextMode="MultiLine" Width="400px" Height="100px"></asp:TextBox></td>
                </tr>
                <tr>
                    <td>해시태그 :</td>
                    <td>
                        <asp:TextBox ID="hashtag"  runat="server" TextMode="MultiLine" Width="400px" Height="100px"></asp:TextBox></td>
                </tr>
                <tr>
                    <td>지도 데이터</td>
                    <td>
                        <asp:TextBox TextMode="MultiLine" ID="mapData"  runat="server" Width="400px" Height="100px"></asp:TextBox></td>
                </tr>
                <tr>
                    <td>TravelRouteList</td>
                    <td>
                        <asp:TextBox TextMode="MultiLine" ID="TravelRouteListData"  runat="server" Width="400px" Height="100px"></asp:TextBox></td>
                </tr>
                <tr>
                    <td>CostItmeList</td>
                    <td>
                        <asp:TextBox TextMode="MultiLine" ID="CostItemListData"  runat="server" Width="400px" Height="100px"></asp:TextBox></td>
                </tr>
            </table>
        </div>
    </form>

</body>
</html>
