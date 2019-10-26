<%@ Page Language="C#" EnableEventValidation="false" ValidateRequest="false"%>
<%@ Import Namespace="MySql.Data.MySqlClient" %>
<%@ Import Namespace="MySql.Data" %>
<%@ Import Namespace="System.Data" %>

<!DOCTYPE html>

<script runat="server">

    protected void Page_Load(object sender, EventArgs e)
    {
        //post로 날아오는 값
        //title
        //article
        //hashtag
        //mapData
        //TravelRouteListData
        //CostItemListData

        TravelDao travelDao = new TravelDao();
        Travel travel = new Travel();

        travel.Trv_title = Request.Form["title"].ToString();
        travel.Trv_tag = Request.Form["hashtag"].ToString();
        travel.Trv_secret = "0";
        travel.Trv_tot_rate = "0";
        travel.Trv_views = "0";
        travel.Mem_id = "billip";
        travel.Loc_name = "서울";

        var trv_no = travelDao.InsertTravel(travel);

        Travel_DayDao travel_DayDao = new Travel_DayDao();
        Travel_Day travel_Day = new Travel_Day();

        travel_Day.Trv_day_content = Request.Form["article"].ToString();
        travel_Day.Trv_no = trv_no;

        var trv_day_no = travel_DayDao.InsertTravel_Day(travel_Day);

        MapDao mapDao = new MapDao();
        Map map = new Map();

        map.Trv_day_no = trv_day_no;

        var map_no = mapDao.InsertMap(map);





        //title.Text = Request.Form["title"].ToString();
        foreach(var item in Request.Form)
        {
            mapData.Text = Request.Form["mapData"];
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
                        <asp:TextBox ID="title" name="title" runat="server" TextMode="MultiLine" Width="400px" Height="100px"></asp:TextBox></td>
                </tr>
                <tr>
                    <td>내용 :</td>
                    <td>
                        <asp:TextBox ID="article" name="article" runat="server" TextMode="MultiLine" Width="400px" Height="100px"></asp:TextBox></td>
                </tr>
                <tr>
                    <td>해시태그 :</td>
                    <td>
                        <asp:TextBox ID="hashtag" name="hashtag" runat="server" TextMode="MultiLine" Width="400px" Height="100px"></asp:TextBox></td>
                </tr>
                <tr>
                    <td>지도 데이터</td>
                    <td>
                        <asp:TextBox TextMode="MultiLine" ID="mapData" name="mapData" runat="server" Width="400px" Height="100px"></asp:TextBox></td>
                </tr>
                <tr>
                    <td>TravelRouteList</td>
                    <td>
                        <asp:TextBox TextMode="MultiLine" ID="TravelRouteListData" name="TravelRouteListData" runat="server" Width="400px" Height="100px"></asp:TextBox></td>
                </tr>
                <tr>
                    <td>CostItmeList</td>
                    <td>
                        <asp:TextBox TextMode="MultiLine" ID="CostItemListData" name="CostItemListData" runat="server" Width="400px" Height="100px"></asp:TextBox></td>
                </tr>
            </table>
        </div>
    </form>

</body>
</html>
