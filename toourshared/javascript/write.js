
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
    removable: false, // 마커를 삭제 할 수 있도록 x 버튼이 표시됩니다
    markerImages: [
        null, // API에서 제공하는 기본 마커 이미지
                    {
        src: 'http://t1.daumcdn.net/localimg/localimages/07/2009/map/icon/ico_mn_13.png',
    width: 31,
    height: 35,
    shape: 'rect',
    coords: '0,0,31,35',
                        hoverImage: {
        src: 'http://t1.daumcdn.net/localimg/localimages/07/2012/img/marker_normal.png',
    width: 33,
    height: 36,
    offsetX: 12,
    offsetY: 36,
    spriteWidth: 644,
    spriteHeight: 946,
    spriteOriginX: 10,
    spriteOriginY: 10
},
                        dragImage: {
        src: 'http://t1.daumcdn.net/localimg/localimages/07/2012/attach/pc_img/ico_comm.png',
    width: 20, // 마커 크기
    height: 20, // 마커 크기
    offsetX: 10, // 지도에 고정시킬 이미지 내 위치 좌표
    offsetY: 20, // 지도에 고정시킬 이미지 내 위치 좌표
    spriteWidth: 118, // 이미지 전체 크기
    spriteHeight: 111, // 이미지 전체 크기
    spriteOriginX: 0, // 이미지 중 마커로 사용할 위치
    spriteOriginY: 90 // 이미지 중 마커로 사용할 위치
}
}
]
},
            polylineOptions: { // 선 옵션입니다
        draggable: true, // 그린 후 드래그가 가능하도록 설정합니다
    removable: false, // 그린 후 삭제 할 수 있도록 x 버튼이 표시됩니다
    editable: true, // 그린 후 수정할 수 있도록 설정합니다
    strokeColor: '#39f', // 선 색
    hintStrokeStyle: 'dash', // 그리중 마우스를 따라다니는 보조선의 선 스타일
    hintStrokeOpacity: 0.5 // 그리중 마우스를 따라다니는 보조선의 투명도
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


        class History {
        constructor() {
    this._cursor = 0;
    this.cur_overlay
    this.history = Array();
                this.history.push({
        PlaceList: Array(),
    TravelRouteItemList: Array(),
    CostItemList: Array()
});
}
            setRoute(place_name, road_address_name, address_name, phone, place_url, x, y) {

        this.place_name = place_name;
    this.road_address_name = road_address_name;
    this.address_name = address_name;
    this.phone = phone;
    this.place_url = place_url;
    this.x = x;
    this.y = y;
}
push
}



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


    ////////////////////////////////////////////



        manager.addListener('drawend', function (data) {
        // data.target 에 그려진 오버레이 객체가 넘어온다.
        console.info(data.target);
    });




    // drawManager의 상태가 변경되고
    // travelRoute와 변경
        manager.addListener('state_changed', function () {
        closeCusOverlay();
    //console.info(this._historyStroage);
    refreshOverlayListener();


});
// e 는 삭제되는 대상 오버레이가 삭제될때 listener 삭제
// 대상이 삭제되면 listener 도 같이 삭제됨
// 애초에 리스너가 ExtenedMarker의 부분 요소로 들어가기 때문에
// 같이 삭제됨
        manager.addListener('remove', function (e) {

    });
    //http://localhost:49862/


        function refreshOverlayListener() {
            var data = manager.getOverlays();
    var overlayType = ["circle", "ellipse", "marker", "polygon", "rectangle"];
            overlayType.forEach(function (overlay, overlayIndex, overlayArray) {
                // 각 오버레이들은 길이가 0인 배열로 최초부터 존제
                //if (data[overlay] != null) {
                if (data[overlay].length > 0) {
        //현재 상태와 이전 상태의 오버레이 갯수가 같다면 해당 리스트 전부 새로고침
        //console.info(overlay + " : " + data[overlay]._index + "를 새로 고침");
        data[overlay].forEach(function (value, index, array) {
            try {
                //removeListener 시도
                // 리스너를 만드는중에 오버레이를 전달
                kakao.maps.event.removeListener(value, 'click', onClick_overlay);
            } catch (exception) {
                //console.info(exception);
            } finally {
                kakao.maps.event.addListener(value, 'click', onClick_overlay);
            }


        });

    }
});
}


//주소 - 좌표간 변환 서비스 객체를 생성한다.
var geocoder = new kakao.maps.services.Geocoder();

        var customOverlay = new kakao.maps.CustomOverlay({
        xAnchor: 0.5,
    yAnchor: 1.25,
    zIndex: 3
});

        function closeCusOverlay() {
        customOverlay.setMap(null);
    }




    var curOverlay = Array(1);

    //-----------------------------------------------
    // 클릭시 발생하는 이벤트
    //----------------------------------------------
        var onClick_overlay = function () {

            //console.info(overlay.constructor.name + '_' + overlay._index);

            //console.info("onClick_overlay");
            //alert(this._index + "번째 마커" + "\nk : " + this.k + "\nGa : " + this.k.Ga + "\nHa : " + this.k.Ha + '\nMARKER click!');
            //console.info(this);
            //console.info(overlay);
            //---- 오버레이 타입마다 좌표가 존재하는 위치가 다름

            var coord_WCONGNAMUL = getWCONGNAMULFromOverlay(this);
    curOverlay[0] = this;


    //----좌표값으로 주소를 가져옴
            geocoder.coord2Address(coord_WCONGNAMUL.wcongnamulX, coord_WCONGNAMUL.wcongnamulY, function (result, status) {


                if (status === kakao.maps.services.Status.OK) {
                    //console.info(result);

                    var content = "<div>ok</div>";
    var keyword = document.getElementById('keyword');



    //주소가 있다면 검색
                    if (result[0].address != null) {
                        if (result[0].address.address_name != null) {
        //                                keyword.value = result[0].address.address_name;
        //                                //
        //                                ps.keywordSearch(keyword.value, placesSearchByStateChange);
        //                                $('#searchPlaceModal').modal('show');

        content =


        '<div class="card card-cus" style="width:300px;">' +
        '<div class="card-header">' +
        '<div class="card-title">' +
        '<input class="form-control card-input" type="text" placeholder="장소 이름" value="" />' +
        '</div>' +
        '<div class="card-close">' +
        '<div class="closeBtn" onclick="closeCusOverlay()">' +
        '<span>×</span>' +
        '</div>' +
        '</div>' +
        '</div>' +
        '<div class="card-body">' +
        '<blockquote class="blockquote mb-0">';

    if (result[0].address.address_name != null) {
        content += '<li class="card-body-li">' + result[0].address.address_name + '</li>';
    }
    content +=
                                '<li class="card-body-li"> </li>' +
                                '<li class="card-body-li"> </li>' +
                                '</blockquote>' +
'<table style="margin-top: 10px;"><tr>' +
    '<td>' +
    '<div class="card-addBtn" onclick=\'pushTravelRouteItem("","","","","","' + coord_WCONGNAMUL.wcongnamulX + '","' + coord_WCONGNAMUL.wcongnamulY + '")\'>추가</div>' +
    '</td>' +
    '<td>' +
    '<div class="card-addBtn" onclick=\'searchPlacesByAddress("' + result[0].address.address_name + '")\'>주소로 검색</div>' +
    '</td>' +
    '</tr></table>' +
    '</div>';


                        }
                    }




geocoder.transCoord(coord_WCONGNAMUL.wcongnamulX, coord_WCONGNAMUL.wcongnamulY,
    function (result, status) {

        // 정상적으로 검색이 완료됐으면
        if (status === kakao.maps.services.Status.OK) {
            customOverlay.setPosition(new kakao.maps.LatLng(result[0].y, result[0].x));
            customOverlay.setContent(content);
            customOverlay.setMap(drawingMap);
        }
    }, {
        input_coord: kakao.maps.services.Coords.WCONGNAMUL, // 변환을 위해 입력한 좌표계 입니다
        output_coord: kakao.maps.services.Coords.WGS84 // 변환 결과로 받을 좌표계 입니다
    });

                }
            }, {
    input_coord: kakao.maps.services.Coords.WCONGNAMUL
});


        }


function getWCONGNAMULFromOverlay(overlay) {
    var wcongnamulX;
    var wcongnamulY;
    if (overlay.constructor.name == "ExtendsMarker") {
        wcongnamulX = overlay.k.Ga;
        wcongnamulY = overlay.k.Ha;
    } else if (overlay.constructor.name == "ExtendsCircle") {
        wcongnamulX = overlay.k.Ga;
        wcongnamulY = overlay.k.Ha;
    } else if (overlay.constructor.name == "ExtendsRectangle") {
        //ExtendedRectangle has za{ea,ja,ka,la} as coords
        wcongnamulY = (overlay.za.ka + overlay.za.la) / 2;
        wcongnamulX = (overlay.za.ea + overlay.za.ja) / 2;
    } else if (overlay.constructor.name == "ExtendsPolygon") {
        //ExtendedPolygon has ig{0: {ga: ha:}, }
        var gaTotal = 0;
        var haTotal = 0;
        overlay.Ig.forEach(function (value, index, array) {
            gaTotal += value.Ga;
            haTotal += value.Ha;
        });
        wcongnamulX = gaTotal / overlay.Ig.length;
        wcongnamulY = haTotal / overlay.Ig.length;
    } else if (overlay.constructor.name == "ExtendsEllipse") {
        wcongnamulX = overlay.k.Ga;
        wcongnamulY = overlay.k.Ha;
    }
    return { "wcongnamulX": wcongnamulX, "wcongnamulY": wcongnamulY };
}



// 검색 시스템



var find_markers = [];


var ps = new kakao.maps.services.Places();

// 검색 결과 목록이나 마커를 클릭했을 때 장소명을 표출할 인포윈도우를 생성합니다
var infowindow = new kakao.maps.InfoWindow({
    zIndex: 1
});

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


// 키워드(주소를 통해서 ) 주변 검색을 요청하는 함수입니다
function searchPlacesByAddress(address) {
    //주변검색을 하며 해당 마커는 삭제합니다.
    //console.info(curOverlay[0]);
    //manager.remove(curOverlay[0]);


    var keyword = document.getElementById('keyword');
    keyword.value = address;

    if (!keyword.value.replace(/^\s+|\s+$/g, '')) {
        alert('키워드를 입력해주세요!');
        return false;
    }

    // 장소검색 객체를 통해 키워드로 장소검색을 요청합니다
    ps.keywordSearch(keyword.value, placesSearchByAddressCB);
}

// 키워드(주소를 통해서 ) 주변 검색이 완료되었을때 호출되는 콜백함수 입니다
function placesSearchByAddressCB(data, status, pagination) {
    if (status === kakao.maps.services.Status.OK) {

        manager.remove(curOverlay[0]);
        // 정상적으로 검색이 완료됐으면
        // 검색 목록과 마커를 표출합니다
        displayPlaces(data);

        // 페이지 번호를 표출합니다
        displayPagination(pagination);
        $('#searchPlaceModal').modal('show');
    } else if (status === kakao.maps.services.Status.ZERO_RESULT) {

        alert('검색 결과가 존재하지 않아 더 넓은 주소로 찾습니다.');
        var keyword = document.getElementById('keyword');
        keyword.value = keyword.value.split('-')[0];
        ps.keywordSearch(keyword.value, placesSearchByAddressCB);
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
                $('#searchPlaceModal').modal('hide');

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

class Place {
    constructor(place_name, road_address_name, address_name, phone, place_url, x, y) {
        this.place_name = place_name;
        this.road_address_name = road_address_name;
        this.address_name = address_name;
        this.phone = phone;
        this.place_url = place_url;
        this.x = x;
        this.y = y;
    }
    setRoute(place_name, road_address_name, address_name, phone, place_url, x, y) {

        this.place_name = place_name;
        this.road_address_name = road_address_name;
        this.address_name = address_name;
        this.phone = phone;
        this.place_url = place_url;
        this.x = x;
        this.y = y;
    }
}

var CurPlaceList = Array();



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
        imageSize = new kakao.maps.Size(36, 37), // 마커 이미지의 크기
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
    find_markers.push(marker); // 배열에 생성된 마커를 추가합니다

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

    var content =
        '<div class="card card-cus" style="width:300px;">' +
        '<div class="card-header">' +
        '<div class="card-title">' +
        place.place_name +
        '</div>' +
        '<div class="card-close">' +
        '<div class="closeBtn" onclick="closeOverlay()">' +
        '<span >×</span>' +
        '</div>' +
        '</div>' +
        '</div>' +
        '<div class="card-body">' +
        '<blockquote class="blockquote mb-0">';
    if (place.road_address_name != null) {
        content += '<li class="card-body-li">' + place.road_address_name + '</li>';
    }
    if (place.address_name != null) {
        content += '<li class="card-body-li">' + place.address_name + '</li>';
    }
    if (place.phone != null) {
        content += '<li class="card-body-li">' + place.phone + '</li>';
    }
    if (place.place_url != null) {
        content += '<li class="card-body-li" style="padding: 15px 0;"><a href="' + place.place_url + '" target="_blank" style="text-decoration: none;">상세페이지</a></li>';
    }
    content +=
        '</blockquote>' +
        '<div class="card-addBtn" onclick=\'pushTravelRouteItem("' + place.place_name + '","' + place.road_address_name + '","' + place.ddress_name + '","' + place.phone + '","' + place.place_url + '","' + place.x + '","' + place.y + '")\'>추가</div>' +
        '</div>' +
        '</div>';




    //            var content =
    //                '<div class="card">' +
    //                '<div class="card-header">' +
    //                place.place_name +
    //                '<div class="btn btn-link" onclick="closeOverlay()" title="닫기" style="float: right">X</div>' +
    //                '</div>' +
    //                '<blockquote class="blockquote mb-0">';
    //
    //            if (place.road_address_name != null) {
    //                content += '<li class="card-body-li">' + place.road_address_name + '</li>';
    //            }
    //            if (place.address_name != null) {
    //                content += '<li class="card-body-li">' + place.address_name + '</li>';
    //            }
    //            if (place.phone != null) {
    //                content += '<li class="card-body-li">' + place.phone + '</li>';
    //            }
    //            if (place.place_url != null) {
    //                content += '<li class="card-body-li"><a href="' + place.place_url + '" target="_blank" class="link">상세페이지</a></li>';
    //            }
    //            content +=
    //                '<div class="btn btn-secondary" onclick=\'pushTravelRouteItem("' + place.place_name + '","' + place.road_address_name + '","' + place.ddress_name + '","' + place.phone + '","' + place.place_url + '","' + place.x + '","' + place.y + '")\'>여행경로에 추가</div>' +
    //                '</blockquote>' +
    //                '</div>';

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

//------------------------------------
//----------TravelRouteItem and travelRouteList Start
//------------------------------------

class TravelRouteItem {
    constructor(place_name, road_address_name, address_name, phone, place_url, x, y) {
        this.place_name = place_name;
        this.road_address_name = road_address_name;
        this.address_name = address_name;
        this.phone = phone;
        this.place_url = place_url;
        this.x = x;
        this.y = y;
        this.info = "";

    }
    setRoute(place_name, road_address_name, address_name, phone, place_url, x, y) {

        this.place_name = place_name;
        this.road_address_name = road_address_name;
        this.address_name = address_name;
        this.phone = phone;
        this.place_url = place_url;
        this.x = x;
        this.y = y;

    }
    setName(place_name) {
        this.place_name = place_name;
    }
    setInfo(info) {
        this.info = info;
    }

}

var TravelRouteList = Array();

function refreashTravelRoute() {

    var travelRouteUl = document.getElementById('travelRoute'),
        trBody = document.getElementById('trBody'),
        fragment = document.createDocumentFragment(),
        itemList = '',
        el;

    ;

    // costBody 모든 자식 노드 삭제
    while (travelRouteUl.hasChildNodes()) {
        travelRouteUl.removeChild(travelRouteUl.firstChild);
    }
    TravelRouteList.forEach(function (currentValue, index) {

        ////console.info(index);
        ////console.info(currentValue);
        el = document.createElement('li'),
            itemStr =

            '<div class="travelRouteItem-header">' +
            ' <div class="form-group">' +
            ' <table>' +
            ' <tr>' +
            ' <td>' +
            ' <input id="addTravelRoute_place_name_' + index + '" class="form-control form-control-sm" type="text" placeholder="장소 이름" value="' + currentValue.place_name + '" style="width:130px;" />' +
            ' </td>' +
            ' <td>' +
            ' <div class="btn btn-secondary btn-sm" onclick="setTravelRouteItemName(' + index + ')">이름변경</div>' +
            ' </td>' +
            ' <td>' +
            ' <div class="btn btn-danger btn-sm" onclick="removeTravelRouteItem(' + index + ')"> x </div>' +
            ' </td>' +
            ' </tr>' +
            '</table>' +
            ' </div>' +
            '</div>' +
            ' <div>' +
            '<table>' +
            '<tr>' +
            '<td>' +
            ' <textarea id="addTravelRoute_info_' + index + '" class="form-control form-control-sm" type="text" placeholder="설명" rows="3" >' + currentValue.info + '</textarea>' +
            '</td>' +
            '<td style="vertical-align:top">' +
            ' <div class="btn btn-secondary btn-sm" onclick="setTravelRouteItemInfo(' + index + ')" >설명저장</div>' +
            '</td>' +
            '</tr>' +
            '</table>';

        if (currentValue.address_name != "" && currentValue.address_name != "undefined") {
            itemStr += currentValue.address_name + '<br/>';

        }
        if (currentValue.road_address_name != "" && currentValue.road_address_name != "undefined") {
            itemStr += currentValue.road_address_name + '<br/>';

        }
        if (currentValue.phone != "" && currentValue.phone != "undefined") {
            itemStr += currentValue.phone + '<br/>';

        }
        itemStr += '<a class="btn btn-primary btn-sm" href="' + currentValue.place_url + '" target="_blank">상세페이지</a>';




        itemStr += '</div>';
        el.innerHTML = itemStr;
        el.setAttribute("draggable", 'true');
        el.setAttribute("class", "travelPoint");
        el.setAttribute("id", "travelPoint_" + index);



        var itemEl = el;

        fragment.appendChild(itemEl);

        travelRouteUl.appendChild(fragment);



    });

    var trBodyStr = '방문 : ' + TravelRouteList.length;
    ////console.info(trBody);
    trBody.innerHTML = trBodyStr;


    dragAndDropAction();

}

function pushTravelRouteItem(place_name, road_address_name, address_name, phone, place_url, x, y) {

    TravelRouteList.push(new TravelRouteItem(place_name, road_address_name, address_name, phone, place_url, x, y));
    addCostItemParent(place_name);
    refreashTravelRoute();
    closeOverlay();
    closeCusOverlay();

}


function removeTravelRouteItem(index) {
    TravelRouteList.splice(index, 1);
    removeCostItemParent(index);
    refreashTravelRoute();



}




function setTravelRouteItem(index, place_name, road_address_name, address_name, phone, place_url, x, y) {


    TravelRouteList[index].setRoute(place_name, road_address_name, address_name, phone, place_url, x, y);
    refreashTravelRoute();
}

function setTravelRouteItemName(index) {

    var addTravelRoute_place_nameId = "addTravelRoute_place_name_" + index;
    var place_name = document.getElementById(addTravelRoute_place_nameId).value;
    TravelRouteList[index].setName(place_name);
    refreashTravelRoute();

    setCostItemParentName(index);
}

function setTravelRouteItemInfo(index) {

    var addTravelRoute_infoId = "addTravelRoute_info_" + index;
    var info = document.getElementById(addTravelRoute_infoId).value;
    TravelRouteList[index].setInfo(info);
    refreashTravelRoute();

    setCostItemParentName(index);
}




function swapTravelRouteItem(fIndex, sIndex) {
    var tmp = TravelRouteList[fIndex];
    TravelRouteList[fIndex] = TravelRouteList[sIndex];
    TravelRouteList[sIndex] = tmp;
    refreashTravelRoute();
}



//------------------------------------
//----------TravelRouteItem and travelRouteList END
//------------------------------------

//------------------------------------
//----------CostItems and CostItemList Start
//------------------------------------
class CostItem {
    constructor(place_name) {
        this.itemList = Array();
        this.place_name = place_name;
    }
    setPlace_name(place_name) {
        this.place_name = place_name;
    }
    pushItem(costType, cost, info) {
        this.itemList.push({
            costType,
            cost,
            info
        });
    }
    popItem() {
        this.itemList.pop();
    }
}

var CostItemList = Array();



function button() {

}


function refreashCostItem() {

    var costBody = document.getElementById('costBody'),
        costHeader = document.getElementById('costHeader'),
        fragment = document.createDocumentFragment(),
        headerFragment = document.createDocumentFragment(),
        itemList = '',
        el, headerEl, totalCost = 0,
        pindexTmp;

    ;

    // costBody 모든 자식 노드 삭제
    while (costBody.hasChildNodes()) {
        costBody.removeChild(costBody.firstChild);
    }
    CostItemList.forEach(function (currentValue, pindex) {
        pindexTmp = pindex;
        ////console.info(pindex);
        ////console.info(currentValue);
        el = document.createElement('div'),
            itemStr =

            '<div class="costItem-header">' +
            '         <span># ' + currentValue.place_name + '</span>' +
            '</div>' +
            '   <div class="costItem-body">' +
            '       <ul>';

        currentValue.itemList.forEach(function (currentValue, index) {
            itemStr += '<li>' + currentValue.costType +
                '               <div class="btn btn-sm btn-warning" onclick="removeCostItemChild(' + pindex + ',' + index + ')">x</div>' +
                '<br/>' +
                setComa(currentValue.cost) + ' (' + currentValue.info + ')' + '</li>';
            totalCost += parseInt(currentValue.cost);
        });

        itemStr +=
            '<li>' +
            '   <div class="btn btn-secondary btn-sm" data-toggle="collapse" data-target="#collapseAddCost_' + pindex + '" aria-expanded="false" aria-controls="collapseAddCost_' + pindex + '">경비추가</div>' +
            '   <div class="collapse" id="collapseAddCost_' + pindex + '">' +
            '       <select id="addCost_costType_' + pindex + '" class="form-control form-control-sm">' +
            '           <option value="식비">식비</option>' +
            '           <option value="교통비">교통비</option>' +
            '           <option value="숙박비">숙박비</option>' +
            '           <option value="기타">기타</option>' +
            '       </select>' +
            '       <input id="addCost_cost_' + pindex + '" class="form-control form-control-sm" type="number" placeholder="비용">' +
            '       <input id="addCost_info_' + pindex + '" class="form-control form-control-sm" type="text" placeholder="비용 설명">' +
            '       <div class="btn btn-secondary btn-sm" onclick="pushCostItemChild(' + pindex + ')">+</div>' +
            //'       <div class="btn btn-secondary btn-sm" onclick="popCostItemChild(' + pindex + ')">-</div>' +

            '</div>' +
            '</li>' +
            '   </ul>' +
            '</div>' +
            '</div>';
        el.innerHTML = itemStr;
        //            el.setAttribute("draggable", 'true');
        //            el.setAttribute("id", "travelPoint");
        el.setAttribute("class", "costItem");


        var itemEl = el;

        fragment.appendChild(itemEl);

        costBody.appendChild(fragment);



    });

    // 나중에 지도의 travelroute에서 추가할 버튼
    //el = document.createElement('div'),
    //    itemStr =

    //    '<div class="btn btn-secondary btn-sm" onclick="addCostItemParent(' + pindexTmp + ')">+</div>';

    //el.innerHTML = itemStr;
    ////            el.setAttribute("draggable", 'true');
    ////            el.setAttribute("id", "travelPoint");
    //el.setAttribute("class", "costItem");


    //var itemEl = el;

    //fragment.appendChild(itemEl);

    //costBody.appendChild(fragment);

    ////--------------------



    var headerStr =
        '<span class="chTitle">전체 경비</span>' +
        '<span class="chBody">💰 ' + setComa(totalCost) + '</span>';
    costHeader.innerHTML = headerStr;




}

function pushCostItemChild(index) {

    var costTypeId = "addCost_costType_" + index,
        costId = "addCost_cost_" + index,
        infoId = "addCost_info_" + index;

    var costType = document.getElementById(costTypeId);
    cost = document.getElementById(costId),
        info = document.getElementById(infoId);

    if (cost.value == "") {

        alert("비용을 입력하세요");
    } else {

        CostItemList[index].pushItem(costType.options[costType.selectedIndex].value, cost.value, info.value);
        refreashCostItem();
    }



}


function popCostItemChild(index) {

    var costTypeId = "addCost_costType_" + index,
        costId = "addCost_cost_" + index,
        infoId = "addCost_info_" + index;

    var costType = document.getElementById(costTypeId);
    cost = document.getElementById(costId),
        info = document.getElementById(infoId);

    CostItemList[index].popItem();
    refreashCostItem();

}




function addCostItemParent(place_name) {
    CostItemList.push(new CostItem(place_name));
    refreashCostItem();

}

function setCostItemParentName(pindex) {

    //var addCost_place_nameId = "addCost_place_name_" + pindex;
    //var addCost_place_name = document.getElementById(addCost_place_nameId);
    var addTravelRoute_place_nameId = "addTravelRoute_place_name_" + pindex;
    var place_name = document.getElementById(addTravelRoute_place_nameId).value;

    CostItemList[pindex].setPlace_name(place_name);
    refreashCostItem();
}

function removeCostItemChild(pindex, index) {
    CostItemList[pindex].itemList.splice(index, 1);
    refreashCostItem();
}


function removeCostItemParent(pindex) {
    CostItemList.splice(pindex, 1);
    refreashCostItem();
}

function swapCostItemParent(fIndex, sIndex) {
    var tmp = CostItemList[fIndex];
    CostItemList[fIndex] = CostItemList[sIndex];
    CostItemList[sIndex] = tmp;
    refreashCostItem();
}

function setComa(number) {
    var resultStr = "";
    var strNumber = String(number);
    ////console.info(strNumber);
    ////console.info(strNumber.length);
    for (var i = strNumber.length - 1; i >= 0; i--) {
        ////console.info(i);

        if ((strNumber.length - i - 1) % 3 == 0 && i != strNumber.length - 1) {
            resultStr = ',' + resultStr;
        }
        resultStr = strNumber[i] + resultStr;
    }


    return resultStr;

}

//------------------------------------
//----------CostItems and CostItemList End
//------------------------------------




//------------------------------------
//----------DragManager Start
//------------------------------------





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
            ////console.info(event.target);
            if (event.type == 'dragstart') {
                //console.info("dragstart");
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
        ////console.info(target);
        return $(this.element).find(target).length;
    }

    travelRoute.prototype.handleEvent = function (event) {
        // NOTE: We've bound `this` to the travelRoute object, not
        // the element the event was fired on.
        var $t = $(event.target);

        if (event.type == 'dragstart') {
            this.draggingItem = event.target;
            //console.info(event.target);
            //setdata에 최상위 LIdml HTML을 데이터로 보낸다
            ////console.info("this.draggingItem");
            ////console.info(this.draggingItem);
            var tgtItem = this.draggingItem;
            while (1) {
                //if(data.id == "travelPoint")
                ////console.info("tgtItem.tagName");
                ////console.info(tgtItem.tagName);
                //if (tgtItem.tagName == "LI")
                if (tgtItem.className == "travelPoint")
                    break;
                tgtItem = tgtItem.parentNode;
            }


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
                    //if (tgtItem.tagName == "LI")
                    if (tgtItem.className == "travelPoint")
                        break;
                    tgtItem = tgtItem.parentNode;
                }
                var fIndex, sIndex;
                //travelPoint_0
                fIndex = tgtItem.id.slice(12);
                sIndex = this.draggingItem.id.slice(12);

                //console.info(fIndex);
                //console.info(sIndex);
                swapTravelRouteItem(parseInt(fIndex), parseInt(sIndex));
                swapCostItemParent(parseInt(fIndex), parseInt(sIndex));
                //최상단  travelPoint로만 옮김.
                //this.draggingItem.innerHTML = tgtItem.innerHTML;
                //tgtItem.innerHTML = event.dataTransfer.getData('text/html');
            } else if (this.type == 'reorder') {
                //console.info('reorder');
                //console.info(this.items.index(event.target));
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
//------------------------------------
//----------DragManager END
//------------------------------------



//------------------------------------
//----------Map DataBind Start Not DrawingMap
//-------------------------------



function getMapData() {
    return manager.getData();
}
function getTravelRouteData() {
    return TravelRouteList;
}
function getCostData() {
    return CostItemList;
}

function setTravelRouteData(data) {
    TravelRouteList = data;
}
function setCostData(data) {
    CostItemList = data;
}


overlays = [];
function setMapData(mapData) {
    // Drawing Manager에서 그려진 데이터 정보를 가져옵니다 
    var data = mapData;
    console.info(data);

    // 아래 지도에 그려진 도형이 있다면 모두 지웁니다
    removeOverlays();

    console.info(data["marker"]);
    console.info(data["polyline"]);
    console.info(data["rectangle"]);
    console.info(data["circle"]);
    console.info(data["polygon"]);
    console.info(data["ellipse"]);
    console.info(data["arrow"]);
    // 지도에 가져온 데이터로 도형들을 그립니다
    setMapMarker(data["marker"]);
    setMapPolyline(data["polyline"]);
    setMapRectangle(data["rectangle"]);
    setMapCircle(data["circle"]);
    setMapPolygon(data["polygon"]);
    setMapEllipse(data["ellipse"]);
    setMapArrow(data["arrow"]);




}

// 아래 지도에 그려진 도형이 있다면 모두 지웁니다
function removeOverlays() {
    var len = overlays.length,
        i = 0;

    for (; i < len; i++) {
        overlays[i].setMap(null);
    }

    overlays = [];
}

function setMapArrow(arrow) {
    var len = arrow.length,
        i = 0;

    for (; i < len; i++) {
        var path = pointsToPath(arrow[i].points);
        var style = arrow[i].options;
        var polyline = new kakao.maps.Polyline({
            map: drawingMap,
            endArrow: true,
            path: path,
            strokeColor: style.strokeColor,
            strokeOpacity: style.strokeOpacity,
            strokeStyle: style.strokeStyle,
            strokeWeight: style.strokeWeight
        });

        overlays.push(polyline);
    }
}

function setMapEllipse(ellipse) {
    var len = ellipse.length,
        i = 0;

    for (; i < len; i++) {
        var style = ellipse[i].options;
        var ellipse = new kakao.maps.Ellipse({
            map: drawingMap,
            center: new kakao.maps.LatLng(ellipse[i].center.x, ellipse[i].center.y),
            rx: ellipse[i].rx,
            ry: ellipse[i].ry,
            strokeWeight: style.strokeWeight,
            strokeColor: style.strokeColor,
            strokeOpacity: style.strokeOpacity,
            strokeStyle: style.strokeStyle,
            fillColor: style.fillColor,
            fillOpacity: style.fillOpacity




        });
        console.info(ellipse);
        overlays.push(ellipse);
    }
} // Drawing Manager에서 가져온 데이터 중 마커를 아래 지도에 표시하는 함수입니다
function setMapMarker(markers) {
    var len = markers.length,
        i = 0;

    for (; i < len; i++) {
        var marker = new kakao.maps.Marker({
            map: drawingMap,
            position: new kakao.maps.LatLng(markers[i].y, markers[i].x),
            zIndex: markers[i].zIndex
        });

        overlays.push(marker);
    }
}

// Drawing Manager에서 가져온 데이터 중 선을 아래 지도에 표시하는 함수입니다
function setMapPolyline(lines) {
    var len = lines.length,
        i = 0;

    for (; i < len; i++) {
        var path = pointsToPath(lines[i].points);
        var style = lines[i].options;
        var polyline = new kakao.maps.Polyline({
            map: drawingMap,
            path: path,
            strokeColor: style.strokeColor,
            strokeOpacity: style.strokeOpacity,
            strokeStyle: style.strokeStyle,
            strokeWeight: style.strokeWeight
        });

        overlays.push(polyline);
    }
}

// Drawing Manager에서 가져온 데이터 중 사각형을 아래 지도에 표시하는 함수입니다
function setMapRectangle(rects) {
    var len = rects.length,
        i = 0;

    for (; i < len; i++) {
        var style = rects[i].options;
        var rect = new kakao.maps.Rectangle({
            map: drawingMap,
            bounds: new kakao.maps.LatLngBounds(
                new kakao.maps.LatLng(rects[i].sPoint.y, rects[i].sPoint.x),
                new kakao.maps.LatLng(rects[i].ePoint.y, rects[i].ePoint.x)
            ),
            strokeColor: style.strokeColor,
            strokeOpacity: style.strokeOpacity,
            strokeStyle: style.strokeStyle,
            strokeWeight: style.strokeWeight,
            fillColor: style.fillColor,
            fillOpacity: style.fillOpacity
        });

        overlays.push(rect);
    }
}

// Drawing Manager에서 가져온 데이터 중 원을 아래 지도에 표시하는 함수입니다
function setMapCircle(circles) {
    var len = circles.length,
        i = 0;

    for (; i < len; i++) {
        var style = circles[i].options;
        var circle = new kakao.maps.Circle({
            map: drawingMap,
            center: new kakao.maps.LatLng(circles[i].center.y, circles[i].center.x),
            radius: circles[i].radius,
            strokeColor: style.strokeColor,
            strokeOpacity: style.strokeOpacity,
            strokeStyle: style.strokeStyle,
            strokeWeight: style.strokeWeight,
            fillColor: style.fillColor,
            fillOpacity: style.fillOpacity
        });

        overlays.push(circle);
    }
}

// Drawing Manager에서 가져온 데이터 중 다각형을 아래 지도에 표시하는 함수입니다
function setMapPolygon(polygons) {
    var len = polygons.length,
        i = 0;

    for (; i < len; i++) {
        var path = pointsToPath(polygons[i].points);
        var style = polygons[i].options;
        var polygon = new kakao.maps.Polygon({
            map: drawingMap,
            path: path,
            strokeColor: style.strokeColor,
            strokeOpacity: style.strokeOpacity,
            strokeStyle: style.strokeStyle,
            strokeWeight: style.strokeWeight,
            fillColor: style.fillColor,
            fillOpacity: style.fillOpacity
        });

        overlays.push(polygon);
    }
}

// Drawing Manager에서 가져온 데이터 중 
// 선과 다각형의 꼭지점 정보를 kakao.maps.LatLng객체로 생성하고 배열로 반환하는 함수입니다 
function pointsToPath(points) {
    var len = points.length,
        path = [],
        i = 0;

    for (; i < len; i++) {
        var latlng = new kakao.maps.LatLng(points[i].y, points[i].x);
        path.push(latlng);
    }

    return path;
}
    //------------------------------------
    //----------DataBind  END  Not DrawingMap
    //------------------------------------
