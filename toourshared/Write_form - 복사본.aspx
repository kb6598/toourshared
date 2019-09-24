﻿<%@ Page Language="C#" %>

<!DOCTYPE html>

<script runat="server">



</script>


<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css" integrity="sha384-GJzZqFGwb1QTTN6wy59ffF1BuGJpLSa9DkKMp0DgiMDm4iYMj70gZWKYbI706tWS" crossorigin="anonymous" />
    <link href="https://cdn.jsdelivr.net/npm/summernote@0.8.11/dist/summernote-bs4.min.css" rel="stylesheet" />
    <script src="https://code.jquery.com/jquery-1.12.0.min.js"></script>
    <script src='https://www.google.com/recaptcha/api.js'></script>
    <title></title>
    <style>
        .map_wrap {
            width: 100%;
            vertical-align: middle;
        }

        .modes {
            top: 10px;
            left: 10px;
            z-index: 1;
        }

        #drawingMap {
            width: 100%;
            height: 500px;
            text-align: center;
        }

        .map_wrap, .map_wrap * {
            margin: 0;
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
            position: absolute;
            top: 0;
            left: 0;
            bottom: 0;
            width: 250px;
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
        
          .travelRoute {
            list-style-type: none;
            margin: 0 0 1em 0;
            padding: 1em;
            border: 2px solid transparent;
        }

        .travelRoute:hover {
            border: 2px solid #222;
        }

        .travelRoute li {
            display: block;
            height: 3em;
            border: 1px solid #ccc;
            margin-bottom: 1em;
            line-height: 3em;
            padding: 0 2em;
        }

        .travelRoute li:last-of-type {
            margin-bottom: 0;
        }

        .travelRoute li:before {
            content: '≔';
            position: relative;
            left: -.5em;
            font-size: 2em;
            cursor: move;
        }

        .travelRoute li:hover {
            background-color: #eee;
        }

        .travelRoute li.js-active {
            border: 1px dashed #444;
            background-color: #09f;
        }
    </style>
</head>
<body>




    <div class="container">
        <div class="col-sm-12">
            <div id="emailMsg"></div>
            <form id="form1" runat="server" action="Write_get.aspx">
                <input type="hidden" name="sendEmail" value="ok" />
                <div class="form-group">
                    <asp:TextBox ID="title" runat="server" CssClass="form-control form-control-lg" placeholder="제목을 입력해주세요"></asp:TextBox>
                </div>
                <div class="map_wrap">
                    <div id="map" style="width: 100%; height: 100%; position: relative; overflow: hidden;"></div>


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

        // 마커를 담을 배열입니다
        var markers = [];

        var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
            mapDrawing = {
                center: new kakao.maps.LatLng(37.566826, 126.9786567), // 지도의 중심좌표
                level: 3 // 지도의 확대 레벨
            };

        // 지도를 생성합니다    
        var map = new kakao.maps.Map(mapContainer, mapDrawing);

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
                //return false;
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
                (function (marker, title) {
                    kakao.maps.event.addListener(marker, 'mouseover', function () {
                        displayInfowindow(marker, title);
                    });

                    kakao.maps.event.addListener(marker, 'mouseout', function () {
                        infowindow.close();
                    });

                    itemEl.onmouseover = function () {
                        displayInfowindow(marker, title);
                    };

                    itemEl.onmouseout = function () {
                        infowindow.close();
                    };
                })(marker, places[i].place_name);

                fragment.appendChild(itemEl);
            }

            // 검색결과 항목들을 검색결과 목록 Elemnet에 추가합니다
            listEl.appendChild(fragment);
            menuEl.scrollTop = 0;

            // 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
            map.setBounds(bounds);
        }

        // 검색결과 항목을 Element로 반환하는 함수입니다
        function getListItem(index, places) {

            var el = document.createElement('li'),
                itemStr = '<span class="markerbg marker_' + (index + 1) + '"></span>' +
                    '<div class="info">' +
                    '   <h5>' + places.place_name + '</h5>';

            if (places.road_address_name) {
                itemStr += '    <span>' + places.road_address_name + '</span>' +
                    '   <span class="jibun gray">' + places.address_name + '</span>';
            } else {
                itemStr += '    <span>' + places.address_name + '</span>';
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

            marker.setMap(map); // 지도 위에 마커를 표출합니다
            markers.push(marker);  // 배열에 생성된 마커를 추가합니다

            return marker;
        }

        // 지도 위에 표시되고 있는 마커를 모두 제거합니다
        function removeMarker() {
            for (var i = 0; i < markers.length; i++) {
                markers[i].setMap(null);
            }
            markers = [];
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
        function displayInfowindow(marker, title) {
            var content = '<div style="padding:5px;z-index:1;">' + title + '</div>';

            infowindow.setContent(content);
            infowindow.open(map, marker);
        }

        // 검색결과 목록의 자식 Element를 제거하는 함수입니다
        function removeAllChildNods(el) {
            while (el.hasChildNodes()) {
                el.removeChild(el.lastChild);
            }
        }
        
            <script>
        var DragManager = {
            travelRoutes: [],
            currentContainer: null,

            add: function(travelRoute) {
                this.travelRoutes.push(travelRoute);
            },

            handleEvent: function(event) {
                //console.info(event.target);
                if (event.type == 'dragstart') {
                    var containers = this.travelRoutes.filter(function(container) {

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

        travelRoute.prototype.contains = function(target) {
            //console.info(target);
            return $(this.element).find(target).length;
        }

        travelRoute.prototype.handleEvent = function(event) {
            // NOTE: We've bound `this` to the travelRoute object, not
            // the element the event was fired on.
            var $t = $(event.target);

            if (event.type == 'dragstart') {
                this.draggingItem = event.target;
                console.info(event.target);
                //setdata에 최상위 LIdml HTML을 데이터로 보낸다
                                    var tgtItem = this.draggingItem;
                    while (1) {
                        //if(data.id == "travelPoint")
                        if (tgtItem.tagName == "LI")
                            break;
                        tgtItem = tgtItem.parentNode;
                    }
                console.info("전송할 태그"+tgtItem);
                
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

                    console.info("받을 태그"+tgtItem);
                    this.draggingItem.innerHTML = tgtItem.innerHTML;
                    event.target.innerHTML = event.dataTransfer.getData('text/html');
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

        travelRoute.prototype.activate = function() {
            for (var i = 0, j = this.items.length; i < j; i++) {
                // Make sure `this` is always a travelRoute instead of the element the
                // event was activated on.
                this.items[i].addEventListener('dragenter', this.handleEvent.bind(this));
                this.items[i].addEventListener('dragover', this.handleEvent.bind(this));
                this.items[i].addEventListener('dragleave', this.handleEvent.bind(this));
                this.items[i].addEventListener('drop', this.handleEvent.bind(this));
            }
        }

        travelRoute.prototype.deactivate = function() {
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
    </script>

        
    </script>

</body>
</html>
