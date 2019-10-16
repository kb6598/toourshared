<%@ Page Language="C#" %>

<!DOCTYPE html>

<script runat="server">

</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <div id="travelCost_wrap" class="collapse">
                <ul id="travelCost" class="travelCost"></ul>
            </div>
        </div>
    </form>

    <script>
        function addTravelCost(place_name, road_address_name, address_name, phone, place_url, x, y) {

            var listEl = document.getElementById('travelCost'),
                menuEl = document.getElementById('travelCOst_wrap'),
                fragment = document.createDocumentFragment(),
                listStr = '';



            // 지도에 표시되고 있는 마커를 제거합니다
            removeMarker();
            //지도에 표시되고 있는 인포윈도우 제거
            closeOverlay();
            $('#travelCost_wrap').collapse('show');

            //travelRouteCnt 증가
            ++travelCostCnt;

            var el = document.createElement('li'),
                itemStr = '<div  class="card" style="width:12rem">' +
                    '    <div class="card-body" >' +
                    '        <h4 class="card-title">' + place_name + '</h4>' +
                    ' <p class="card-text">' + road_address_name + '</p>' +
                    ' <p class="card-text">' + address_name + '</p>' +
                    ' <p class="card-text">' + phone + '</p>' +
                    ' <a class="card-link" href="' + place_url + '" target="_blank" class="link">상세페이지</a>' +

                    '    </div>' +
                    '<input id=x type=hidden value=' + x + '/>' +
                    '<input id=y type=hidden value=' + y + '/>' +
                    '</div>';
            el.innerHTML = itemStr;
            el.setAttribute("draggable", 'true');
            el.setAttribute("id", "travelPoint");


            var itemEl = el; // 검색 결과 항목 Element를 생성합니다


            fragment.appendChild(itemEl);

            // drawing 매니저에 마커 추가
            var position = new kakao.maps.LatLng(y, x);
            manager.put(kakao.maps.drawing.OverlayType.MARKER, position, 1);


            // 검색결과 항목들을 검색결과 목록 Elemnet에 추가합니다
            listEl.appendChild(fragment);
            menuEl.scrollTop = 0;

            //드래그 앤드롭 액션 실행
            dragAndDropAction();
        }

    </script>
</body>
</html>
