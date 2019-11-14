<%@ WebHandler Language="C#" Class="getMapCenter" %>

using System;
using System.Web;
using System.IO;
using System.Collections.Generic;
using System.Linq;
using System.Web.Services;
using tooushared.DAO;
using tooushared.DTO;
using tooushared.Lib;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using System.Web.Script.Services;
using System.Web.Script.Serialization;
using System.Collections;


public class getMapCenter : IHttpHandler,System.Web.SessionState.IRequiresSessionState {

    public void ProcessRequest (HttpContext context) {
        if (context.Request.QueryString["trv_no"] != null)
        {
            // trv_no를 통해 해당 travel의 travel_day list를 가져옴
            Travel_Day inTravel_Day = new Travel_Day();
            Travel_DayDao travel_DayDao = new Travel_DayDao();
            inTravel_Day.Trv_no = context.Request.QueryString["trv_no"].ToString();
            List<Travel_Day> travel_Days = travel_DayDao.selectTravelDayListByTrvNo(inTravel_Day);

            //Travel_day_no를 이용하여 Map을 가져올 준비
            Map inMap = new Map();
            MapDao mapDao = new MapDao();
            Map tmpMap;
            List<Map> maps = new List<Map>();
            JArray jArray = new JArray();


            foreach (var travel_day in travel_Days)
            {
                inMap.Trv_day_no = travel_day.Trv_day_no;
                tmpMap = new Map();
                tmpMap = mapDao.selectMapByTrv_day_no(inMap);
                jArray.Add(JToken.Parse(JsonConvert.SerializeObject(tmpMap.Map_route)));

            }



            context.Response.Write(jArray);
        }
        else
        {
            context.Response.Write("error");
        }
    }

    public bool IsReusable {
        get {
            return false;
        }
    }

}