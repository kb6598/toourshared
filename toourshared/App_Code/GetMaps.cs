using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using tooushared.DAO;
using tooushared.DTO;
using tooushared.Lib;
using Newtonsoft.Json;


/// <summary>
/// WebService의 요약 설명입니다.
/// </summary>
[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// ASP.NET AJAX를 사용하여 스크립트에서 이 웹 서비스를 호출하려면 다음 줄의 주석 처리를 제거합니다. 
[System.Web.Script.Services.ScriptService]
public class GetMaps : System.Web.Services.WebService
{
  



    

    [WebMethod]
    public void getMaps(string trv_no)
    {
        // trv_no를 통해 해당 travel의 travel_day list를 가져옴
        Travel_Day inTravel_Day = new Travel_Day();
        Travel_DayDao travel_DayDao = new Travel_DayDao();
        inTravel_Day.Trv_no = trv_no;
        List<Travel_Day> travel_Days = travel_DayDao.selectTravelDayListByTrvNo(inTravel_Day);

        //Travel_day_no를 이용하여 Map을 가져올 준비
        Map inMap = new Map();
        MapDao mapDao = new MapDao();
        Map tmpMap;
        List<Map> maps = new List<Map>();
        
        

        foreach(var travel_day in travel_Days)
        {
            inMap.Trv_day_no = travel_day.Trv_day_no;
            tmpMap = new Map();            
            tmpMap = mapDao.selectMapByTrv_day_no(inMap);
            maps.Add(tmpMap);
        }
        
               
        Context.Response.Write(JsonConvert.SerializeObject(maps));



    }



}
