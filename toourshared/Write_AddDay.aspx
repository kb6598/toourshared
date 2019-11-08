﻿<%@ Page Language="C#" EnableEventValidation="false" ValidateRequest="false"%>
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

            //-----------------------------------
            //
            TravelDao travelDao = new TravelDao();
            Travel inTravel = new Travel();
            inTravel.Trv_no = WriteStatus["trv_no"];
            Travel curTravel = travelDao.selectTravelBytrv_no(inTravel);

            //update Travel
            //loc_name을 가져와야함
            //curTravel.Loc_name = Request.Form["loc_name"];
            //curTravel.Trv_main_img = Request.Form["main_img"];
            curTravel.Trv_no = WriteStatus["trv_no"];
            curTravel.Trv_secret = Request.Form["trv_secret"];
            curTravel.Trv_tag = Request.Form["hashtag"];
            curTravel.Trv_timestamp = TimeLib.GetTimeStamp();
            curTravel.Trv_title = Request.Form["title"];
            travelDao.UpdatetTravel(curTravel);

            //update Travel_day
            Travel_DayDao travelDayDao = new Travel_DayDao();
            Travel_Day inTravelDay = new Travel_Day();
            inTravelDay.Trv_day_no = WriteStatus[WriteStatus["cur_day"]];
            inTravelDay.Trv_no = WriteStatus["trv_no"];
            inTravelDay.Trv_day_content = Request.Form["article"];
            travelDayDao.UpdatetTravel_Day(inTravelDay);

            //insert map
            Map inMap = new Map();
            MapDao mapDao = new MapDao();
            inMap.Map_cost = Request.Form["mapCost"];
            inMap.Map_data = Request.Form["mapData"];
            inMap.Map_route = Request.Form["mapRoute"];
            inMap.Trv_day_no = WriteStatus[WriteStatus["cur_day"]];

            mapDao.InsertMap(inMap);


            //    {
            //        { "trv_no", trv_no},
            //        { "cur_trv_day_no",trv_day_no},
            //        { "cur_day","1"},
            //        {"1",trv_day_no }
            //    };

            // insert new travel_day at last
            //
            //travel_day도 생성 하여 trv_day_no를 가지고 있음
            Travel_Day travel_Day = new Travel_Day();
            travel_Day.Trv_no =WriteStatus["trv_no"] ;
            Travel_DayDao travel_DayDao = new Travel_DayDao();
            string new_trv_day_no = travel_DayDao.InsertTravel_Day(travel_Day);

            //find insert point
            int insertPoint = 1;
            while (true)            {
                
                if (!WriteStatus.ContainsKey(insertPoint.ToString()) ) break;
                insertPoint++;
            }
            WriteStatus.Add(insertPoint.ToString(), new_trv_day_no);







            Session["write_status"] = WriteStatus;
            Response.Redirect("./write.aspx");



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
    <form id="form1" runat="server" method="post" action="write.aspx">
        저장중.....

    </form>
  <script>

     </script>

</body>

   
</html>