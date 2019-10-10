using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Map의 요약 설명입니다.
/// </summary>
namespace tooushared.DTO
{
    public class Map
    {
        private string map_no;
        private string trv_no;


        public string Map_no
        {
            get
            {
                return map_no;
            }

            set
            {
                map_no = value;
            }
        }

        public string Trv_no
        {
            get
            {
                return trv_no;
            }

            set
            {
                trv_no = value;
            }
        }

        public Map()
        {
            //
            // TODO: 여기에 생성자 논리를 추가합니다.
            //
        }

    }
}