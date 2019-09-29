﻿<%@ Page Language="C#" %>

<!DOCTYPE html>

<script runat="server">



</script>


<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
    <link href="https://cdn.jsdelivr.net/npm/summernote@0.8.11/dist/summernote-bs4.min.css" rel="stylesheet" />
    <script src="https://code.jquery.com/jquery-1.12.0.min.js"></script>
    <script src='https://www.google.com/recaptcha/api.js'></script>
    <title></title>
    <style>
        .map_wrap {
            width: 100%;
            vertical-align: middle;
            margin-bottom: 30px;
        }

        .modes {
            top: 10px;
            left: 10px;
            z-index: 1;
        }

        #drawingMap {
            top: 0px;
            width: auto;
            height: 500px;
            text-align: center;
        }

        #travelRoute_wrap {
            max-height: 500px;
            overflow-x: hidden;
            overflow-y: scroll;
            position: absolute;
            text-align: center;
            z-index: 3;
            background-color: whitesmoke;
        }

        .map_wrap, .map_wrap * {
            margin: 10;
            padding: 0;
            font-family: 'Malgun Gothic',dotum,'돋움',sans-serif;
            font-size: 12px;
        }

            .map_wrap a, .map_wrap a:hover, .map_wrap a:active {
                color: #000;
                text-decoration: none;
            }

        .map_wrap {
            position: relative;
            width: 100%;
            height: 500px;
        }



        #menu_wrap {
            margin: 10px 0 30px 10px;
            padding: 5px;
            overflow-y: auto;
            background: rgba(255, 255, 255, 0.7);
            z-index: 1;
            font-size: 12px;
            border-radius: 10px;
        }

        .bg_white {
            background: #fff;
        }

        #menu_wrap hr {
            display: block;
            height: 1px;
            border: 0;
            border-top: 2px solid #5F5F5F;
            margin: 3px 0;
        }

        #menu_wrap .option {
            text-align: center;
        }

            #menu_wrap .option p {
                margin: 10px 0;
            }

            #menu_wrap .option button {
                margin-left: 5px;
            }

        #placesList li {
            list-style: none;
        }

        #placesList .item {
            position: relative;
            border-bottom: 1px solid #888;
            overflow: hidden;
            cursor: pointer;
            min-height: 65px;
        }

            #placesList .item span {
                display: block;
                margin-top: 4px;
            }

            #placesList .item h5, #placesList .item .info {
                text-overflow: ellipsis;
                overflow: hidden;
                white-space: nowrap;
            }

            #placesList .item .info {
                padding: 10px 0 10px 55px;
            }

        #placesList .info .gray {
            color: #8a8a8a;
        }

        #placesList .info .jibun {
            padding-left: 26px;
            background: url(http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/places_jibun.png) no-repeat;
        }

        #placesList .info .tel {
            color: #009900;
        }

        #placesList .item .markerbg {
            float: left;
            position: absolute;
            width: 36px;
            height: 37px;
            margin: 10px 0 0 10px;
            background: url(http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png) no-repeat;
        }

        #placesList .item .marker_1 {
            background-position: 0 -10px;
        }

        #placesList .item .marker_2 {
            background-position: 0 -56px;
        }

        #placesList .item .marker_3 {
            background-position: 0 -102px
        }

        #placesList .item .marker_4 {
            background-position: 0 -148px;
        }

        #placesList .item .marker_5 {
            background-position: 0 -194px;
        }

        #placesList .item .marker_6 {
            background-position: 0 -240px;
        }

        #placesList .item .marker_7 {
            background-position: 0 -286px;
        }

        #placesList .item .marker_8 {
            background-position: 0 -332px;
        }

        #placesList .item .marker_9 {
            background-position: 0 -378px;
        }

        #placesList .item .marker_10 {
            background-position: 0 -423px;
        }

        #placesList .item .marker_11 {
            background-position: 0 -470px;
        }

        #placesList .item .marker_12 {
            background-position: 0 -516px;
        }

        #placesList .item .marker_13 {
            background-position: 0 -562px;
        }

        #placesList .item .marker_14 {
            background-position: 0 -608px;
        }

        #placesList .item .marker_15 {
            background-position: 0 -654px;
        }

        #pagination {
            margin: 10px auto;
            text-align: center;
        }

            #pagination a {
                display: inline-block;
                margin-right: 10px;
            }

            #pagination .on {
                font-weight: bold;
                cursor: default;
                color: #777;
            }


        <!-- 커스텀 오버레이 스타일-- >
        .wrap {
            position: absolute;
            left: 0;
            bottom: 40px;
            width: 250px;
            height: 132px;
            margin-left: -144px;
            text-align: left;
            overflow: hidden;
            font-size: 12px;
            font-family: 'Malgun Gothic', dotum, '돋움', sans-serif;
            line-height: 1.5;
        }

        .wrap * {
            padding: 0;
            margin: 0;
        }

        .wrap .info {
            width: 286px;
            height: 140px;
            border-radius: 5px;
            border-bottom: 2px solid #ccc;
            border-right: 1px solid #ccc;
            overflow: hidden;
            background: #fff;
        }

            .wrap .info:nth-child(1) {
                border: 0;
                box-shadow: 0px 1px 2px #888;
            }

        .info .title {
            padding: 5px 0 0 10px;
            height: 30px;
            background: #eee;
            border-bottom: 1px solid #ddd;
            font-size: 18px;
            font-weight: bold;
        }

        .info .close {
            position: absolute;
            top: 10px;
            right: 10px;
            color: #888;
            width: 17px;
            height: 17px;
            background: url('http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/overlay_close.png');
        }

            .info .close:hover {
                cursor: pointer;
            }

        .info .body {
            position: relative;
            overflow: hidden;
        }

        .info .desc {
            position: relative;
            margin: 13px 0 0 0px;
            height: 120px;
        }

        .desc .ellipsis {
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
        }

        .desc .jibun {
            font-size: 11px;
            color: #888;
            margin-top: -2px;
        }

        .info:after {
            content: '';
            position: absolute;
            margin-left: -12px;
            left: 50%;
            bottom: 0;
            width: 22px;
            height: 12px;
            background: url('http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/vertex_white.png')
        }

        .info .link {
            color: #5085BB;
        }
    </style>
</head>
<body>






    <div class="container">
        <div class="col-sm-12">
            <div id="emailMsg"></div>
            <div id="edit_right">
                <form id="form1" runat="server" action="Write_get.aspx">
                    <input type="hidden" name="sendEmail" value="ok" />
                    <div class="form-group">
                        <asp:TextBox ID="title" runat="server" CssClass="form-control form-control-lg" placeholder="제목을 입력해주세요"></asp:TextBox>
                    </div>

                    <div class="map_wrap">
                        <div id="travelRoute_wrap" class="collapse">
                            <ul id="travelRoute" class="travelRoute"></ul>
                        </div>

                        <div id="drawingMap"></div>


                        <!--폼 내부에서 버튼객체를 쓰려면 type=button을 써주면 된다.-->
                        <button type="button" class="btn btn-secondary" onclick="selectOverlay('MARKER')">마커</button>
                        <button type="button" class="btn btn-secondary" onclick="selectOverlay('POLYLINE')">선</button>
                        <button type="button" class="btn btn-secondary" onclick="selectOverlay('CIRCLE')">원</button>
                        <button type="button" class="btn btn-secondary" onclick="selectOverlay('RECTANGLE')">사각형</button>
                        <button type="button" class="btn btn-secondary" onclick="selectOverlay('POLYGON')">다각형</button>
                        <button type="button" class="btn btn-secondary" onclick="selectOverlay('ELLIPSE')">타원</button>
                        <button type="button" class="btn btn-secondary" onclick="selectOverlay('ARROW')">화살표</button>
                        <button type="button" class="btn btn-secondary" id="undo" onclick="undoAction()" disabled>UNDO</button>
                        <button type="button" class="btn btn-secondary" id="redo" onclick="redoAction()" disabled>REDO</button>
                        <!-- Button trigger modal -->
                        <button type="button" class="btn btn-secondary" data-toggle="modal" data-target="#searchPlaceModal">
                            검색
                        </button>
                        <button type="button" class="btn btn-secondary" data-toggle="collapse" data-target="#travelRoute_wrap">
                            여행경로
                        </button>

                    </div>
                    <div class="form-group">
                        <asp:TextBox ID="article" runat="server" TextMode="MultiLine" />
                    </div>
                    <div class="form-group">
                        <asp:TextBox ID="hashtag" runat="server" CssClass="form-control form-control-lg" placeholder="#해시태그를 입력해주세요"></asp:TextBox>
                    </div>
                    <div class="form-group">
                        <input type="button" onclick="postToNext()" value="넘기기" />
                    </div>

                </form>
            </div>

        </div>






    </div>
    <!-- Modal -->
    <div class="modal fade" id="searchPlaceModal" tabindex="-1" role="dialog" aria-labelledby="searchPlaceModalTitle" aria-hidden="true">
        <div class="modal-dialog modal-dialog-scrollable" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="searchPlaceModalTitle">장소 검색</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div id="menu_wrap" class="bg_white">
                        <div class="option">
                            <div>
                                키워드 :
                                <input id="keyword" value="이태원 맛집" type="text" />
                                <button onclick="searchPlaces();">검색하기</button>
                            </div>
                        </div>
                        <hr>
                        <ul id="placesList"></ul>
                        <div id="pagination"></div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>





    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js" integrity="sha384-wHAiFfRlMFy6i5SRaxvfOCifBUQy1xHdJ/yoi7FRNXMRBu5WHdZYu1hA6ZOblgut" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/js/bootstrap.min.js" integrity="sha384-B0UglyR+jN6CkvvICOB2joaf5I4l3gm9GU6Hc1og6Ls7i6U/mkkaduKaBhlAXv9k" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bs4-summernote@0.8.10/dist/summernote-bs4.min.js"></script>
    <script>
        $(document).ready(function () {
            $('textarea').summernote({
                height: 300,   //set editable area's height
            });
        });
    </script>
    <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=ebcd0c1accbe0ff4bbb47bd777ef2fcf&libraries=service&libraries=services,clusterer,drawing"></script>

    <script>
        // Drawing Manager로 도형을 그릴 지도 div
        var drawingMapContainer = document.getElementById('drawingMap'),
            drawingMap = {
                center: new daum.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
                level: 3 // 지도의 확대 레벨
            };

        // 지도를 표시할 div와  지도 옵션으로  지도를 생성합니다
        //var drawingMap = new daum.maps.Map(drawingMapContainer, mapOption);
        var drawingMap = new daum.maps.Map(drawingMapContainer, drawingMap);

        var options = { // Drawing Manager를 생성할 때 사용할 옵션입니다
            map: drawingMap, // Drawing Manager로 그리기 요소를 그릴 map 객체입니다
            drawingMode: [ // Drawing Manager로 제공할 그리기 요소 모드입니다
                daum.maps.drawing.OverlayType.ARROW,
                daum.maps.drawing.OverlayType.CIRCLE,
                daum.maps.drawing.OverlayType.ELLIPSE,
                daum.maps.drawing.OverlayType.MARKER,
                daum.maps.drawing.OverlayType.POLYLINE,
                daum.maps.drawing.OverlayType.POLYGON,
                daum.maps.drawing.OverlayType.RECTANGLE
            ],
            // 사용자에게 제공할 그리기 가이드 툴팁입니다
            // 사용자에게 도형을 그릴때, 드래그할때, 수정할때 가이드 툴팁을 표시하도록 설정합니다
            guideTooltip: ['draw', 'drag', 'edit'],
            arrowOptions: {
                draggable: true,
                removable: false,
                editable: true,
                strokeWeight: 3,
                strokeOpacity: 0.8,
                strokeColor: '#39f',
                strokeStyle: 'solid',
                hintStrokeStyle: 'dashdot',
                hintStrokeOpacity: 0.3,
                startArrow: false
            },
            circleOptions: {
                draggable: true,
                removable: false,
                editable: true,
                strokeColor: '#39f',
                fillColor: '#39f',
                fillOpacity: 0.5
            },
            ellipseOptions: {
                draggable: true,
                removable: false,
                editable: true,
                strokeWeight: 2,
                strokeOpacity: 0.8,
                strokeColor: '#39f',
                strokeStyle: 'solid',
                fillColor: '#39f',
                fillOpacity: 0.3
            },
            markerOptions: { // 마커 옵션입니다 
                draggable: true, // 마커를 그리고 나서 드래그 가능하게 합니다 
                removable: false // 마커를 삭제 할 수 있도록 x 버튼이 표시됩니다  
            },
            polylineOptions: { // 선 옵션입니다
                draggable: true, // 그린 후 드래그가 가능하도록 설정합니다
                removable: false, // 그린 후 삭제 할 수 있도록 x 버튼이 표시됩니다
                editable: true, // 그린 후 수정할 수 있도록 설정합니다 
                strokeColor: '#39f', // 선 색
                hintStrokeStyle: 'dash', // 그리중 마우스를 따라다니는 보조선의 선 스타일
                hintStrokeOpacity: 0.5  // 그리중 마우스를 따라다니는 보조선의 투명도
            },
            polygonOptions: {
                draggable: true,
                removable: false,
                editable: true,
                strokeColor: '#39f',
                fillColor: '#39f',
                fillOpacity: 0.5,
                hintStrokeStyle: 'dash',
                hintStrokeOpacity: 0.5
            },
            rectangleOptions: {
                draggable: true,
                removable: false,
                editable: true,
                strokeColor: '#39f', // 외곽선 색
                fillColor: '#39f', // 채우기 색
                fillOpacity: 0.5 // 채우기색 투명도
            }

        };

        // 위에 작성한 옵션으로 Drawing Manager를 생성합니다
        var manager = new daum.maps.drawing.DrawingManager(options);

        // undo, redo 버튼의 disabled 속성을 설정하기 위해 엘리먼트를 변수에 설정합니다
        var undoBtn = document.getElementById('undo');
        var redoBtn = document.getElementById('redo');

        // Drawing Manager 객체에 state_changed 이벤트를 등록합니다
        // state_changed 이벤트는 그리기 요소의 생성/수정/이동/삭제 동작 
        // 또는 Drawing Manager의 undo, redo 메소드가 실행됐을 때 발생합니다
        manager.addListener('state_changed', function () {

            // 되돌릴 수 있다면 undo 버튼을 활성화 시킵니다 
            if (manager.undoable()) {
                undoBtn.disabled = false;

            } else { // 아니면 undo 버튼을 비활성화 시킵니다 
                undoBtn.disabled = true;
            }

            // 취소할 수 있다면 redo 버튼을 활성화 시킵니다 
            if (manager.redoable()) {
                redoBtn.disabled = false;
            } else { // 아니면 redo 버튼을 비활성화 시킵니다 
                redoBtn.disabled = true;
            }

        });


        // 버튼 클릭 시 호출되는 핸들러 입니다
        function selectOverlay(type) {
            // 그리기 중이면 그리기를 취소합니다
            manager.cancel();

            // 클릭한 그리기 요소 타입을 선택합니다
            manager.select(daum.maps.drawing.OverlayType[type]);
        }



        // undo 버튼 클릭시 호출되는 함수입니다.
        function undoAction() {
            // 그리기 요소를 이전 상태로 되돌립니다
            manager.undo();
        }

        // redo 버튼 클릭시 호출되는 함수입니다.
        function redoAction() {
            // 이전 상태로 되돌린 상태를 취소합니다
            manager.redo();
        }


        //주소 - 좌표간 변환 서비스 객체를 생성한다.
        var geocoder = new kakao.maps.services.Geocoder();

        var callback = function (result, status) {

            if (status === kakao.maps.services.Status.OK) {
                console.log('그런 너를 마주칠까 ' + result[0].address.address_name + '을 못가');
            }
        };

        //그리기 끝났을때 동작
        manager.addListener('drawend', function (data) {

            //console.log('drawend', data);



            // 생성되는 overlay에 이벤트 추가 
            //marker에 이벤트를 추천하면 ExtendesMarker

            //if (data.overlayType == "marker") {
            //    console.info("this is marker");
            //}
            //else if (data.overlayType == "polyline") {
            //    console.info("this is polyline");
            //}
            //else if (data.overlayType == "polygon") {
            //    console.info("this is polygon");
            //}
            //else if (data.overlayType == "rectangle") {
            //    console.info("this is rectangle");
            //}
            //else if (data.overlayType == "circle") {
            //    console.info("this is circle");
            //}


            // 여기서 리스너를 추가하면 redo때 추가가 안됨
            //kakao.maps.event.addListener(data.target, "click", function () {
            //    console.info(this);
            //    console.info(this.k);


            //});




        });



        // drawManager의 상태가 변경되고
        // travelRoute와 변경
        manager.addListener('state_changed', function () {
            console.info("state_changed");

            console.info(this._historyStroage);
           
            addListenerFromDrawingMap(this._historyStroage);

            //this._historyStroage._stack.forEach(function (currentValue, index, array) {
            //    console.log(currentValue);
            //    console.log(index);
            //    console.log(array);
            //});
        });
        // e 는 삭제되는 대상 오버레이가 삭제될때 listener 삭제
        // 대상이 삭제되면 listener 도 같이 삭제됨
        // 애초에 리스너가 ExtenedMarker의 부분 요소로 들어가기 때문에
        // 같이 삭제됨
        manager.addListener('remove', function (e) {
            //console.info("삭제");
            //console.info(e);
            //var handler;
            //kakao.maps.event.removeListener(e.target, 'click', handler);
        });







        function addListenerFromDrawingMap(history) {
            // Drawing Manager에서 그려진 데이터 정보를 가져옵니다 
            // getData를 통하여 얻은 값에는 Addlintener 안됨
            //var data = manager.getData();



            //console.info(history);
            //console.info(typeof (history._stack));
            //console.info(history._stack);
            console.info(history._stack.length);
            //_stack
            // 히스토리 객체

            var historyStackLength = history._stack.length;

            var preState = new Array();
            var curState = new Array();

            // 오버레이 객체 실제로 액션을 추가할 대상
            var data = manager.getOverlays();

            // 알고리즘 다시짜자

                                    // historyStackLength의 최초 생성시 길이는 2이기때문에 인덱스 오류 걱정 없음 하지만 처리해주어야 속편함
            console.info(history._stack);
            console.info("****************marker");


            if (history._cursor == historyStackLength) {
                console.info("추가, 수정");

                if (historyStackLength == 2) {
                    //첫번째 히스토리의 마커 첫번째
                    console.info(history._stack[1]);
                    if (history._stack[1].marker.length > 0) {
                        // *****************************************************************20190929 작업중



                        // 히스토리와 overlay에 저장되는 좌표 타입이 다른듯.
                        kakao.maps.event.addListener(data[daum.maps.drawing.OverlayType.MARKER][0], 'click', function () {
                            console.info("marker 오브젝트 dataget");
                            console.info(data[daum.maps.drawing.OverlayType.MARKER][0]);
                            console.info(data[daum.maps.drawing.OverlayType.MARKER][0].k.Ga + ":" + data[daum.maps.drawing.OverlayType.MARKER][0].k.Ha);

                            console.info("marker 오브젝트 history");
                            console.info(history._stack[1].marker[0]);
                            console.info(history._stack[1].marker[0].y + ":" + history._stack[1].marker[0].x);



                            alert("x:" + data[daum.maps.drawing.OverlayType.MARKER][0].k.Ga + "y:" + data[daum.maps.drawing.OverlayType.MARKER][0].k.Ha + 'MARKER click!');
                        });
                        console.info(history._stack[1].marker);
                    }
                }
                else if (historyStackLength >= 3) {

                    preState = history._stack[historyStackLength - 2];//아무리 작아도 0
                    curState = history._stack[historyStackLength - 1];//아무리 작아도 1
                    console.info(preState.marker);
                    console.info(curState.marker);



                    // 이부분 오류남. 
                    // curState.(value) 로는 불가
                    //curState.marker, curState.circle 식으로 써야함

                    //갯수가 변하지 않았다면 좌표값을 비교하여 액션 리스너 재생성

                    //지도에 생성된 marker가 1개이상일때 부터 동작
                    //undo시에 마커가 삭제될때도 인식하기 위해 datdaGet을 통해 가져오는 overlay의 길이도 확인
                    if (curState.marker.length > 0 && data[daum.maps.drawing.OverlayType.MARKER].length > 0) {
                        if (curState.marker.length == preState.marker.length) {
                            console.info("length is same");
                            //현재 기록의 marker 배열의 목록을 조회

                            curState.marker.forEach(function (value, index, array) {
                                //현재 index의 marker x,y 좌표와 과거의 x,y 좌표가 일치하지 않을때,
                                if (value.x != preState.marker[index].x && value.y != preState.marker[index].y) {
                                    console.info(index + "번째 마커 좌표 수정됨!");
                                    var Func;
                                    //이전 액션 리스너 삭제

                                    kakao.maps.event.removeListener(data[daum.maps.drawing.OverlayType.MARKER][index], 'click', function () { });
                                    //액션리스너 새로 추가
                                    kakao.maps.event.addListener(data[daum.maps.drawing.OverlayType.MARKER][index], 'click', function () {
                                        console.info("x : " + data[daum.maps.drawing.OverlayType.MARKER][index].x + "y : " + data[daum.maps.drawing.OverlayType.MARKER][index].y)
                                        alert("x : " + data[daum.maps.drawing.OverlayType.MARKER][index].x + "y : " + data[daum.maps.drawing.OverlayType.MARKER][index].y + '<br>MARKER click!');
                                    });
                                }
                            });
                        }
                        else if (curState.marker.length > preState.marker.length) {
                            console.info("length is not same");

                            //가장 최근에 추가된 노드에 액션 추가
                            kakao.maps.event.addListener(data[daum.maps.drawing.OverlayType.MARKER][curState.marker.length - 1], 'click', function () {
                                console.info("x : " + data[daum.maps.drawing.OverlayType.MARKER][curState.marker.length - 1].x + "y : " + data[daum.maps.drawing.OverlayType.MARKER][curState.marker.length - 1].y);
                                alert("x : " + data[daum.maps.drawing.OverlayType.MARKER][curState.marker.length - 1].x + "y : " + data[daum.maps.drawing.OverlayType.MARKER][curState.marker.length - 1].y + '<br>MARKER click!');
                            });
                        }

                    }



                    //preState.marker.forEach(function (currentValue, index, array) {
                    //    console.log(index);
                    //    console.log(currentValue);
                    //    //console.log(array);


                    //});

                }

            }
            else if (history._cursor < historyStackLength) {
                var undoCnt = historyStackLength - history._cursor;
                console.info("undoCnt : " + undoCnt);
            }
            //console.info(curState);







            
            var marker_lastNode;
            var polyline_lastNode;
            var polygon_lastNode;
            var circle_lastNode;
            var rectangle_lastNode;
            //MARKER

            //marker_lastNode = data[daum.maps.drawing.OverlayType.MARKER].length - 1;
            //console.info(data[daum.maps.drawing.OverlayType.MARKER]);
            //console.info(marker_lastNode);

            //if (marker_lastNode >= 0) {
            //    kakao.maps.event.addListener(data[daum.maps.drawing.OverlayType.MARKER][marker_lastNode], 'click', function () {
            //        alert('MARKER click!');
            //    });
            //}

            ////data[daum.maps.drawing.OverlayType.MARKER].forEach(function (currentValue, index, array) {
            ////    console.log(currentValue);
            ////    //console.log(index);
            ////    //console.log(array);




            ////    kakao.maps.event.addListener(currentValue, 'click', function () {
            ////        alert('MARKER click!');
            ////    });
            ////});

            //            //POLYLINE
            //data[daum.maps.drawing.OverlayType.POLYLINE].forEach(function (currentValue, index, array) {
            //    console.log(currentValue);
            //    //console.log(index);
            //    //console.log(array);

            //                    kakao.maps.event.addListener(currentValue, 'click', function () {
            //        alert('POLYLINE click!');
            //    });
            //});

            //            //RECTANGLE
            //data[daum.maps.drawing.OverlayType.RECTANGLE].forEach(function (currentValue, index, array) {
            //    console.log(currentValue);
            //    //console.log(index);
            //    //console.log(array);

            //                    kakao.maps.event.addListener(currentValue, 'click', function () {
            //        alert('RECTANGLE click!');
            //    });
            //});

            //            //CIRCLE
            //data[daum.maps.drawing.OverlayType.CIRCLE].forEach(function (currentValue, index, array) {
            //    console.log(currentValue);
            //   // console.log(index);
            //   // console.log(array);

            //                    kakao.maps.event.addListener(currentValue, 'click', function () {
            //        alert('CIRCLE click!');
            //    });
            //});

            //            //POLYGON
            //data[daum.maps.drawing.OverlayType.POLYGON].forEach(function (currentValue, index, array) {
            //    console.log(currentValue);
            //   // console.log(index);
            //   // console.log(array);

            //                    kakao.maps.event.addListener(currentValue, 'click', function () {
            //        alert('POLYGON click!');
            //    });
            //});






            // 지도에 가져온 데이터로 도형들을 그립니다
            //drawMarker(data[daum.maps.drawing.OverlayType.MARKER]);
            //drawPolyline(data[daum.maps.drawing.OverlayType.POLYLINE]);
            //drawRectangle(data[daum.maps.drawing.OverlayType.RECTANGLE]);
            //drawCircle(data[daum.maps.drawing.OverlayType.CIRCLE]);
            //drawPolygon(data[daum.maps.drawing.OverlayType.POLYGON]);

        }



        //kakao.maps.event.addListener(marker, 'dragend', function () {
        //    alert('marker dragend!');
        //});






        function displayInfowindowOnOverlay(marker) {
            //var content = '<div style="padding:5px;z-index:1;">' + title + ' <button >추가</button></div>';
            var content = '<div class="wrap">' +
                '    <div class="info">' +
                '        <div class="title">' +
                place.place_name +
                '            <div class="close" onclick="closeOverlay()" title="닫기"></div>' +
                '        </div>' +
                '        <div class="body">' +
                '            <div class="desc">' +
                '                <div class="ellipsis">' + place.road_address_name + '</div>' +
                '                <div class="jibun ellipsis">' + place.address_name + '</div>' +
                '   <div class="jibun ellipsis">' + place.phone + '</div>' +
                '                <div><a href="' + place.place_url + '" target="_blank" class="link">상세페이지</a></div>' +
                '<div class="btn btn-secondary" onclick=\'addTravelRoute("' + place.place_name + '","' + place.road_address_name + '","' + place.ddress_name + '","' + place.phone + '","' + place.place_url + '","' + place.x + '","' + place.y + '")\'>여행경로에 추가</div>' +
                '            </div>' +
                '        </div>' +
                '    </div>' +
                '</div>';
            infowindow.setContent(content);
            infowindow.open(drawingMap, marker);
        }


        // Drawing Manager에서 데이터를 가져와 도형을 표시할 아래쪽 지도 div
        //var mapContainer = document.getElementById('map'),
        //    mapOptions = { 
        //        center: new daum.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
        //        level: 3 // 지도의 확대 레벨
        //    };

        // 지도 div와 지도 옵션으로 지도를 생성합니다
        //var map = new daum.maps.Map(mapContainer, mapOptions),
        overlays = []; // 지도에 그려진 도형을 담을 배열





        //// 아래 지도에 그려진 도형이 있다면 모두 지웁니다
        //function removeOverlays() {
        //    var len = overlays.length, i = 0;

        //    for (; i < len; i++) {
        //        overlays[i].setMap(null);
        //    }

        //    overlays = [];
        //}



        //// Drawing Manager에서 가져온 데이터 중 마커를 아래 지도에 표시하는 함수입니다
        //function drawMarker(markers) {
        //    var len = markers.length, i = 0;

        //    for (; i < len; i++) {
        //        var marker = new daum.maps.Marker({
        //            map: map,
        //            position: new daum.maps.LatLng(markers[i].y, markers[i].x),
        //            zIndex: markers[i].zIndex
        //        });

        //        overlays.push(marker);


        //        //alert (new daum.maps.LatLng(markers[0].y, markers[0].x)) ;

        //    }
        //}

        //// Drawing Manager에서 가져온 데이터 중 선을 아래 지도에 표시하는 함수입니다
        //function drawPolyline(lines) {
        //    var len = lines.length, i = 0;

        //    for (; i < len; i++) {
        //        var path = pointsToPath(lines[i].points);
        //        var style = lines[i].options;
        //        var polyline = new daum.maps.Polyline({
        //            map: map,
        //            path: path,
        //            strokeColor: style.strokeColor,
        //            strokeOpacity: style.strokeOpacity,
        //            strokeStyle: style.strokeStyle,
        //            strokeWeight: style.strokeWeight
        //        });

        //        overlays.push(polyline);
        //    }
        //}

        //// Drawing Manager에서 가져온 데이터 중 사각형을 아래 지도에 표시하는 함수입니다
        //function drawRectangle(rects) {
        //    var len = rects.length, i = 0;

        //    for (; i < len; i++) {
        //        var style = rects[i].options;
        //        var rect = new daum.maps.Rectangle({
        //            map: map,
        //            bounds: new daum.maps.LatLngBounds(
        //                new daum.maps.LatLng(rects[i].sPoint.y, rects[i].sPoint.x),
        //                new daum.maps.LatLng(rects[i].ePoint.y, rects[i].ePoint.x)
        //            ),
        //            strokeColor: style.strokeColor,
        //            strokeOpacity: style.strokeOpacity,
        //            strokeStyle: style.strokeStyle,
        //            strokeWeight: style.strokeWeight,
        //            fillColor: style.fillColor,
        //            fillOpacity: style.fillOpacity
        //        });

        //        overlays.push(rect);
        //    }
        //}

        //// Drawing Manager에서 가져온 데이터 중 원을 아래 지도에 표시하는 함수입니다
        //function drawCircle(circles) {
        //    var len = circles.length, i = 0;

        //    for (; i < len; i++) {
        //        var style = circles[i].options;
        //        var circle = new daum.maps.Circle({
        //            map: map,
        //            center: new daum.maps.LatLng(circles[i].center.y, circles[i].center.x),
        //            radius: circles[i].radius,
        //            strokeColor: style.strokeColor,
        //            strokeOpacity: style.strokeOpacity,
        //            strokeStyle: style.strokeStyle,
        //            strokeWeight: style.strokeWeight,
        //            fillColor: style.fillColor,
        //            fillOpacity: style.fillOpacity
        //        });

        //        overlays.push(circle);
        //    }
        //}

        //// Drawing Manager에서 가져온 데이터 중 다각형을 아래 지도에 표시하는 함수입니다
        //function drawPolygon(polygons) {
        //    var len = polygons.length, i = 0;

        //    for (; i < len; i++) {
        //        var path = pointsToPath(polygons[i].points);
        //        var style = polygons[i].options;
        //        var polygon = new daum.maps.Polygon({
        //            map: map,
        //            path: path,
        //            strokeColor: style.strokeColor,
        //            strokeOpacity: style.strokeOpacity,
        //            strokeStyle: style.strokeStyle,
        //            strokeWeight: style.strokeWeight,
        //            fillColor: style.fillColor,
        //            fillOpacity: style.fillOpacity
        //        });

        //        overlays.push(polygon);
        //    }
        //}

        //// Drawing Manager에서 가져온 데이터 중 
        //// 선과 다각형의 꼭지점 정보를 daum.maps.LatLng객체로 생성하고 배열로 반환하는 함수입니다 
        //function pointsToPath(points) {
        //    var len = points.length,
        //        path = [],
        //        i = 0;

        //    for (; i < len; i++) {
        //        var latlng = new daum.maps.LatLng(points[i].y, points[i].x);
        //        //path.push(i+":");
        //        path.push(latlng);
        //    }

        //    return path;

        //}


        // 다음페이지로 markers, polyline, rect, circle, polygon 보내는 기능
        function postToNext() {
            var data = manager.getData();
            //rects  circles   polygons 
            markers = data[daum.maps.drawing.OverlayType.MARKER];
            polylines = data[daum.maps.drawing.OverlayType.POLYLINE];
            rects = data[daum.maps.drawing.OverlayType.RECTANGLE];
            circles = data[daum.maps.drawing.OverlayType.CIRCLE];
            polygons = data[daum.maps.drawing.OverlayType.POLYGON];

            markersPath = [];
            polylinesPath = [];
            rectsPath = [];
            circlesPath = [];
            polygonsPath = [];

            for (var i = 0; i < markers.length; i++) {

                var latlng = new daum.maps.LatLng(markers[i].y, markers[i].x);
                markersPath.push(i + ":");
                markersPath.push(latlng);


            }




            var len = polylines.length, i = 0;

            for (; i < len; i++) {
                var path = pointsToPath(polylines[i].points);
                polylinesPath.push(i + ":");
                polylinesPath.push(path);

            }


            var len = circles.length, i = 0;

            for (; i < len; i++) {
                circlesPath.push(i + ":");
                circlesPath.push(new daum.maps.LatLng(circles[i].center.y, circles[i].center.x));
                circlesPath.push(circles[i].radius);

            }

            var len = rects.length, i = 0;

            for (; i < len; i++) {


                rectsPath.push(i + ":");
                rectsPath.push(rects[i].sPoint.y, rects[i].sPoint.x, rects[i].ePoint.y, rects[i].ePoint.x);


            }

            var len = polygons.length, i = 0;

            for (; i < len; i++) {
                var path = pointsToPath(polygons[i].points);
                polygonsPath.push(i + ":");
                polygonsPath.push(path);

            }




            //document.getElementById("marker").value = markersPath;
            //document.getElementById("polygon").value = polylinesPath;
            var title = document.getElementById("title").value;
            var article = document.getElementById("article").value;
            var hashtag = document.getElementById("hashtag").value;


            var form = document.getElementById("form1");




            var insert1 = document.createElement("input");   // input 엘리멘트 생성
            insert1.setAttribute("type", "hidden");           // type 속성을 hidden으로 설정
            insert1.setAttribute("name", "marker");               // name 속성을 'stadium'으로 설정
            insert1.setAttribute("value", markersPath);             // value 속성을 삽입
            form.appendChild(insert1);                       // form 엘리멘트에 input 엘리멘트 추가

            var insert2 = document.createElement("input");   // input 엘리멘트 생성
            insert2.setAttribute("type", "hidden");           // type 속성을 hidden으로 설정
            insert2.setAttribute("name", "polyline");               // name 속성을 'stadium'으로 설정
            insert2.setAttribute("value", polylinesPath);             // value 속성을 삽입
            form.appendChild(insert2);
            //rects  circles   polygons 
            var insert3 = document.createElement("input");   // input 엘리멘트 생성
            insert3.setAttribute("type", "hidden");           // type 속성을 hidden으로 설정
            insert3.setAttribute("name", "rects");               // name 속성을 'stadium'으로 설정
            insert3.setAttribute("value", rectsPath);             // value 속성을 삽입
            form.appendChild(insert3);

            var insert4 = document.createElement("input");   // input 엘리멘트 생성
            insert4.setAttribute("type", "hidden");           // type 속성을 hidden으로 설정
            insert4.setAttribute("name", "circles");               // name 속성을 'stadium'으로 설정
            insert4.setAttribute("value", circlesPath);             // value 속성을 삽입
            form.appendChild(insert4);

            var insert5 = document.createElement("input");   // input 엘리멘트 생성
            insert5.setAttribute("type", "hidden");           // type 속성을 hidden으로 설정
            insert5.setAttribute("name", "polygons");               // name 속성을 'stadium'으로 설정
            insert5.setAttribute("value", polygonsPath);             // value 속성을 삽입
            form.appendChild(insert5);

            var insert6 = document.createElement("input");   // input 엘리멘트 생성
            insert5.setAttribute("type", "hidden");           // type 속성을 hidden으로 설정
            insert5.setAttribute("name", "data");               // name 속성을 'stadium'으로 설정
            insert5.setAttribute("value", manager.getData());             // value 속성을 삽입
            form.appendChild(insert6);



            form.submit();                                  // 전송
        }

        // 검색 시스템



        var find_markers = [];

        //var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
        //    mapOption = {
        //        center: new kakao.maps.LatLng(37.566826, 126.9786567), // 지도의 중심좌표
        //        level: 3 // 지도의 확대 레벨
        //    };

        // 지도를 생성합니다    
        //var map = new kakao.maps.Map(mapContainer, mapOption);

        // 장소 검색 객체를 생성합니다
        var ps = new kakao.maps.services.Places();

        // 검색 결과 목록이나 마커를 클릭했을 때 장소명을 표출할 인포윈도우를 생성합니다
        var infowindow = new kakao.maps.InfoWindow({ zIndex: 1 });

        // 키워드로 장소를 검색합니다
        searchPlaces();

        // 키워드 검색을 요청하는 함수입니다
        function searchPlaces() {

            var keyword = document.getElementById('keyword').value;

            if (!keyword.replace(/^\s+|\s+$/g, '')) {
                alert('키워드를 입력해주세요!');
                return false;
            }

            // 장소검색 객체를 통해 키워드로 장소검색을 요청합니다
            ps.keywordSearch(keyword, placesSearchCB);
        }

        // 장소검색이 완료됐을 때 호출되는 콜백함수 입니다
        function placesSearchCB(data, status, pagination) {
            if (status === kakao.maps.services.Status.OK) {

                // 정상적으로 검색이 완료됐으면
                // 검색 목록과 마커를 표출합니다
                displayPlaces(data);

                // 페이지 번호를 표출합니다
                displayPagination(pagination);

            } else if (status === kakao.maps.services.Status.ZERO_RESULT) {

                alert('검색 결과가 존재하지 않습니다.');
                return;

            } else if (status === kakao.maps.services.Status.ERROR) {

                alert('검색 결과 중 오류가 발생했습니다.');
                return;

            }
        }






        // 검색 결과 목록과 마커를 표출하는 함수입니다
        function displayPlaces(places) {

            var listEl = document.getElementById('placesList'),
                menuEl = document.getElementById('menu_wrap'),
                fragment = document.createDocumentFragment(),
                bounds = new kakao.maps.LatLngBounds(),
                listStr = '';


            // 검색 결과 목록에 추가된 항목들을 제거합니다
            removeAllChildNods(listEl);

            // 지도에 표시되고 있는 마커를 제거합니다
            removeMarker();

            for (var i = 0; i < places.length; i++) {

                // 마커를 생성하고 지도에 표시합니다
                var placePosition = new kakao.maps.LatLng(places[i].y, places[i].x),
                    marker = addMarker(placePosition, i),
                    itemEl = getListItem(i, places[i]); // 검색 결과 항목 Element를 생성합니다

                // 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
                // LatLngBounds 객체에 좌표를 추가합니다
                bounds.extend(placePosition);

                // 마커와 검색결과 항목에 mouseover 했을때
                // 해당 장소에 인포윈도우에 장소명을 표시합니다
                // mouseout 했을 때는 인포윈도우를 닫습니다
                (function (marker, place) {
                    kakao.maps.event.addListener(marker, 'click', function () {
                        displayInfowindow(marker, place);
                    });


                    itemEl.onmouseover = function () {
                        displayInfowindow(marker, place);
                    };

                    itemEl.onmouseclick = function () {
                        displayInfowindow(marker, place);
                        $('#searchPlaceModal').modal('hide')

                    };


                })(marker, places[i]);

                fragment.appendChild(itemEl);
            }

            // 검색결과 항목들을 검색결과 목록 Elemnet에 추가합니다
            listEl.appendChild(fragment);
            menuEl.scrollTop = 0;

            // 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
            //map.setBounds(bounds);
            drawingMap.setBounds(bounds);
        }

        // 검색결과 항목을 Element로 반환하는 함수입니다
        function getListItem(index, places) {

            var el = document.createElement('li'),
                itemStr = '<span class="markerbg marker_' + (index + 1) + '"></span>' +
                    '<div class="info">' +
                    '   <h5 data-dismiss="modal">' + places.place_name + '</h5>';

            if (places.road_address_name) {
                itemStr += '    <span data-dismiss="modal">' + places.road_address_name + '</span>' +
                    '   <span class="jibun gray" data-dismiss="modal">' + places.address_name + '</span>';
            } else {
                itemStr += '    <span data-dismiss="modal">' + places.address_name + '</span>';
            }

            itemStr += '  <span class="tel">' + places.phone + '</span>' +
                '</div>';

            el.innerHTML = itemStr;
            el.className = 'item';

            return el;
        }

        // 마커를 생성하고 지도 위에 마커를 표시하는 함수입니다
        function addMarker(position, idx, title) {
            var imageSrc = 'http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png', // 마커 이미지 url, 스프라이트 이미지를 씁니다
                imageSize = new kakao.maps.Size(36, 37),  // 마커 이미지의 크기
                imgOptions = {
                    spriteSize: new kakao.maps.Size(36, 691), // 스프라이트 이미지의 크기
                    spriteOrigin: new kakao.maps.Point(0, (idx * 46) + 10), // 스프라이트 이미지 중 사용할 영역의 좌상단 좌표
                    offset: new kakao.maps.Point(13, 37) // 마커 좌표에 일치시킬 이미지 내에서의 좌표
                },
                markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imgOptions),
                marker = new kakao.maps.Marker({
                    position: position, // 마커의 위치
                    image: markerImage
                });

            marker.setMap(drawingMap); // 지도 위에 마커를 표출합니다
            find_markers.push(marker);  // 배열에 생성된 마커를 추가합니다

            return marker;
        }

        // 지도 위에 표시되고 있는 마커를 모두 제거합니다
        function removeMarker() {
            for (var i = 0; i < find_markers.length; i++) {
                find_markers[i].setMap(null);
            }
            find_markers = [];
        }

        // 검색결과 목록 하단에 페이지번호를 표시는 함수입니다
        function displayPagination(pagination) {
            var paginationEl = document.getElementById('pagination'),
                fragment = document.createDocumentFragment(),
                i;

            // 기존에 추가된 페이지번호를 삭제합니다
            while (paginationEl.hasChildNodes()) {
                paginationEl.removeChild(paginationEl.lastChild);
            }

            for (i = 1; i <= pagination.last; i++) {
                var el = document.createElement('a');
                el.href = "#";
                el.innerHTML = i;

                if (i === pagination.current) {
                    el.className = 'on';
                } else {
                    el.onclick = (function (i) {
                        return function () {
                            pagination.gotoPage(i);
                        }
                    })(i);
                }

                fragment.appendChild(el);
            }
            paginationEl.appendChild(fragment);
        }

        // 검색결과 목록 또는 마커를 클릭했을 때 호출되는 함수입니다
        // 인포윈도우에 장소명을 표시합니다
        function displayInfowindow(marker, place) {
            //var content = '<div style="padding:5px;z-index:1;">' + title + ' <button >추가</button></div>';
            var content = '<div class="wrap">' +
                '    <div class="info">' +
                '        <div class="title">' +
                place.place_name +
                '            <div class="close" onclick="closeOverlay()" title="닫기"></div>' +
                '        </div>' +
                '        <div class="body">' +
                '            <div class="desc">' +
                '                <div class="ellipsis">' + place.road_address_name + '</div>' +
                '                <div class="jibun ellipsis">' + place.address_name + '</div>' +
                '   <div class="jibun ellipsis">' + place.phone + '</div>' +
                '                <div><a href="' + place.place_url + '" target="_blank" class="link">상세페이지</a></div>' +
                '<div class="btn btn-secondary" onclick=\'addTravelRoute("' + place.place_name + '","' + place.road_address_name + '","' + place.ddress_name + '","' + place.phone + '","' + place.place_url + '","' + place.x + '","' + place.y + '")\'>여행경로에 추가</div>' +
                '            </div>' +
                '        </div>' +
                '    </div>' +
                '</div>';
            infowindow.setContent(content);
            infowindow.open(drawingMap, marker);
        }
        // 모든 인포윈도우 닫음
        function closeOverlay() {
            infowindow.close();
        }


        // 검색결과 목록의 자식 Element를 제거하는 함수입니다
        function removeAllChildNods(el) {
            while (el.hasChildNodes()) {
                el.removeChild(el.lastChild);
            }
        }

        var travelRouteCnt = 0;

        // 검색결과에서 선택된 마커의 인포윈도우에서 travelRoute로 요소 추가
        function addTravelRoute(place_name, road_address_name, address_name, phone, place_url, x, y) {

            var listEl = document.getElementById('travelRoute'),
                menuEl = document.getElementById('travelRoute_wrap'),
                fragment = document.createDocumentFragment(),
                searchBox = document.getElementById('keyword'),
                paginationEl = document.getElementById('pagination'),
                listStr = '';

            //검색 키워드 삭제
            //searchBox.value = '';

            // 검색 결과 목록에 추가된 항목들을 제거합니다
            removeAllChildNods(document.getElementById('placesList'));

            // 기존에 추가된 페이지번호를 삭제합니다
            while (paginationEl.hasChildNodes()) {
                paginationEl.removeChild(paginationEl.lastChild);
            }
            // 지도에 표시되고 있는 마커를 제거합니다
            removeMarker();
            //지도에 표시되고 있는 인포윈도우 제거
            closeOverlay();
            $('#travelRoute_wrap').collapse('show');

            //travelRouteCnt 증가
            ++travelRouteCnt;

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

            // drawing 메니저에 마커 추가
            var position = new kakao.maps.LatLng(y, x);
            manager.put(kakao.maps.drawing.OverlayType.MARKER, position, 1);


            // 검색결과 항목들을 검색결과 목록 Elemnet에 추가합니다
            listEl.appendChild(fragment);
            menuEl.scrollTop = 0;

            //드래그 앤드롭 액션 실행
            dragAndDropAction();
        }
        //여행경로 드래그 앤 드롭
        var DragManager;
        function dragAndDropAction() {
            //DragManger에 요소 추가 (추후 드래그 앤드롭 액션 실행)
            DragManager = {
                travelRoutes: [],
                currentContainer: null,

                add: function (travelRoute) {
                    this.travelRoutes.push(travelRoute);
                },

                handleEvent: function (event) {
                    //console.info(event.target);
                    if (event.type == 'dragstart') {
                        console.info("dragstart");
                        var containers = this.travelRoutes.filter(function (container) {

                            return container.contains(event.target);
                        });

                        if (containers.length > 0) {
                            this.currentContainer = containers[0];
                            this.currentContainer.activate();
                        }
                    }

                    if (this.currentContainer !== null) {
                        this.currentContainer.handleEvent(event);
                        if (event.type == 'dragend') {
                            this.currentContainer.deactivate();
                            this.currentContainer = null;
                        }
                    }
                }

            };

            window.addEventListener('dragstart', DragManager);
            window.addEventListener('dragend', DragManager);

            function travelRoute(container, type) {
                this.element = container;
                this.type = type || 'swap';
                this.items = $('> li', this.element);
                this.draggingItem = null;

                DragManager.add(this);
            }

            travelRoute.prototype.contains = function (target) {
                //console.info(target);
                return $(this.element).find(target).length;
            }

            travelRoute.prototype.handleEvent = function (event) {
                // NOTE: We've bound `this` to the travelRoute object, not
                // the element the event was fired on.
                var $t = $(event.target);

                if (event.type == 'dragstart') {
                    this.draggingItem = event.target;
                    console.info(event.target);
                    //setdata에 최상위 LIdml HTML을 데이터로 보낸다
                    console.info("this.draggingItem");
                    console.info(this.draggingItem);
                    var tgtItem = this.draggingItem;
                    while (1) {
                        //if(data.id == "travelPoint")
                        console.info("tgtItem.tagName");
                        console.info(tgtItem.tagName);
                        if (tgtItem.tagName == "LI")
                            break;
                        tgtItem = tgtItem.parentNode;
                    }
                    console.info("전송할 태그" + tgtItem);

                    event.dataTransfer.setData('text/html', tgtItem.innerHTML);
                }

                if (event.type == 'dragover' && this.draggingItem != event.target) {

                    $t.addClass('js-active');
                    // Preventing the default action _enables_ drop. Because JS APIs.
                    if (event.preventDefault) {
                        event.preventDefault();
                    }
                    event.dataTransfer.dropEffect = 'move';
                }

                if (event.type == 'dragleave') {
                    $t.removeClass('js-active');
                }

                if (event.type == 'drop' && this.draggingItem != null) {
                    if (this.type == 'swap') {


                        // 최상단 LI태그를 탐색
                        var tgtItem = event.target;
                        while (1) {
                            //if(data.id == "travelPoint")
                            if (tgtItem.tagName == "LI")
                                break;
                            tgtItem = tgtItem.parentNode;
                        }

                        //최상단  LI로만 옮김.
                        this.draggingItem.innerHTML = tgtItem.innerHTML;
                        tgtItem.innerHTML = event.dataTransfer.getData('text/html');
                    } else if (this.type == 'reorder') {
                        console.info('reorder');
                        console.info(this.items.index(event.target));
                    }
                }

                if (event.type == 'dragend' || event.type == 'drop') {
                    this.items.removeClass('js-active');
                    this.draggingItem = null;
                }
            }

            travelRoute.prototype.activate = function () {
                for (var i = 0, j = this.items.length; i < j; i++) {
                    // Make sure `this` is always a travelRoute instead of the element the
                    // event was activated on.
                    this.items[i].addEventListener('dragenter', this.handleEvent.bind(this));
                    this.items[i].addEventListener('dragover', this.handleEvent.bind(this));
                    this.items[i].addEventListener('dragleave', this.handleEvent.bind(this));
                    this.items[i].addEventListener('drop', this.handleEvent.bind(this));
                }
            }

            travelRoute.prototype.deactivate = function () {
                this.draggingItem = null;
                for (var i = 0, j = this.items.length; i < j; i++) {
                    //this.items[i].removeEventListener('dragenter', this.handleEvent);
                    //this.items[i].removeEventListener('dragover', this.handleEvent);
                    //this.items[i].removeEventListener('dragleave', this.handleEvent);
                    //this.items[i].removeEventListener('drop', this.handleEvent);
                }
            }

            var travelRoutes = document.getElementsByClassName('travelRoute');

            for (var i = 0, j = travelRoutes.length; i < j; i++) {
                new travelRoute(travelRoutes[i], (i % 2 == 0) ? 'swap' : 'reorder');
            }

        }


    </script>
</body>
</html>