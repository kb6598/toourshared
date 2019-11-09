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
        //mapRoute
        //mapCost
        Dictionary<string, string> WriteStatus = SessionLib.getWriteStatus();
        if (WriteStatus != null)
        {
            //update Travel
            Travel inTravel = new Travel();            
            TravelDao travelDao = new TravelDao();

            inTravel.Trv_no = WriteStatus["trv_no"];
            Travel curTravel = travelDao.selectTravelBytrv_no(inTravel);            
            
            curTravel.Trv_main_img = Request.Form["main_img"];
            curTravel.Trv_no = WriteStatus["trv_no"];
            curTravel.Trv_secret = Request.Form["trv_secret"];
            curTravel.Trv_tag = Request.Form["hashtag"];
            curTravel.Trv_timestamp = TimeLib.GetTimeStamp();
            curTravel.Trv_title = Request.Form["title"];
            travelDao.UpdatetTravel(curTravel);




            //update Travel_day
            Travel_Day inTravelDay = new Travel_Day();
            Travel_DayDao travelDayDao = new Travel_DayDao();            
            inTravelDay.Trv_day_no = WriteStatus[WriteStatus["cur_day"]];
            inTravelDay.Trv_no = WriteStatus["trv_no"];
            inTravelDay.Trv_day_content = Request.Form["article"];
            travelDayDao.UpdatetTravel_Day(inTravelDay);


            //update map
            Map inMap = new Map();
            MapDao mapDao = new MapDao();
            inMap.Map_cost = Request.Form["mapCost"];
            inMap.Map_data = Request.Form["mapData"];
            inMap.Map_route = Request.Form["mapRoute"];
            inMap.Trv_day_no = WriteStatus["cur_trv_day_no"];

            mapDao.UpdateMapByTrvDayNo(inMap);




  
        }
        // 지도는 정보를 이전 폼에서 주어야 한다.





    }
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=ebcd0c1accbe0ff4bbb47bd777ef2fcf&libraries=service&libraries=services,clusterer,drawing"></script>
</head>
<body>
    <form id="form1" runat="server" method="post" action="write.aspx">
        저장중.....

    </form>
  <script>
         form = document.getElementById("form1");
         form.submit(); // 전송

     </script>

</body>

   
</html>
