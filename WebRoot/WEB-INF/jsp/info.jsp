<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="/datetags" prefix="date"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<base href="<%=basePath%>">
<html>
<head>
    <title>路况信息</title>
    <link rel="stylesheet" type="text/css"
          href="css/bootstrap.min.css"/>
    <link rel="stylesheet"
          href="css/plugins/font-awesome/css/font-awesome.min.css"/>
    <link rel="stylesheet" type="text/css" href="css/style.css"/>
    <link id="css_main" rel="stylesheet" type="text/css"
          href="theme/dandelion2/main.css"/>
    <link rel="stylesheet" href="css/themes/default/default.css"/>
    <script language="javascript" src="js/jquery.min.js"></script>
    <script language="javascript" src="js/bootstrap.min.js"></script>
    <script charset="utf-8" src="<%=basePath%>js/plugins/code/prettify.js"></script>
    <script type="text/javascript" src="<%=basePath%>js/plugins/My97DatePicker/WdatePicker.js"></script>
    <script charset="utf-8" src="<%=basePath%>js/kindeditor-min.js"></script>
    <script type="text/javascript" src="http://webapi.amap.com/maps?v=1.3&key=ccc4eaefaf53e0a0b0575e214e4cd4f5"></script>
    <style>
        #container {width:600px; height: 600px; }
        form {
            margin: 0;
        }

        textarea {
            display: block;
        }
        .textarea{
	        white-space:pre-wrap; /* css3.0 */ 
			white-space:-moz-pre-wrap; /* Firefox */ 
			white-space:-pre-wrap; /* Opera 4-6 */ 
			white-space:-o-pre-wrap; /* Opera 7 */ 
			word-wrap:break-word; /* Internet Explorer 5.5+ */ 
        }
        .divScroll {
			OVERFLOW: auto;
			scrollbar-face-color: #FFFFFF;
			scrollbar-shadow-color: #D2E5F4;
			scrollbar-highlight-color: #D2E5F4;
			scrollbar-3dlight-color: #FFFFFF;
			scrollbar-darkshadow-color: #FFFFFF;
			scrollbar-track-color: #FFFFFF;
			scrollbar-arrow-color: #D2E5F4";
		}
		.bts{
            width: 50px;margin-bottom: 30px;
        }
    </style>
    <script language="javascript">

        $(function() {

            if ('${message}' != '') {
                alert('${message}');
            }

            var lat = '${roadcondition.StartLatitude}';
            var lng = '${roadcondition.StartLongitude}';
            if(lat == ''){
                lat = '26.513564';
            }
            if(lng == ''){
                lng = '106.730039';
            }
//            $("#startlatitude").val(lat);
//            $("#startlongitude").val(lng);
            var map = new AMap.Map('container');
            map.setZoom(10);
            map.setCenter([lng, lat]);
            var features = ['road', 'building', 'bg'];
            map.setFeatures(features);

            AMap.plugin(['AMap.ToolBar', 'AMap.Scale', 'AMap.OverView'],
                    function () {
                        map.addControl(new AMap.ToolBar());

                        map.addControl(new AMap.Scale());

                        map.addControl(new AMap.OverView({isOpen: true}));
                    });
            // 实例化点标记
            function addMarker( lat , lng) {
                marker = new AMap.Marker({
                    icon: "http://webapi.amap.com/images/marker_sprite.png",
                    position: [lng,lat]
                });
                marker.setMap(map);
            }

            function updateMarker(lng , lat) {
                marker.setPosition([lat, lng]); //更新点标记位置
            }

            addMarker(lat , lng);



            //为地图注册click事件获取鼠标点击出的经纬度坐标
            var clickEventListener = map.on( 'click', function(e) {
                console.log(e);
                var lng = e.lnglat.getLng();
                var lat = e.lnglat.getLat();
                updateMarker(lat , lng);
                $("#startlatitude").val(lat);
                $("#startlongitude").val(lng);
            });

        });

        function returnList(){
            var url = "roadinfo/roadconditions/list/${roottype}?currentPage=${pager.currentPage}&pageSize=${pager.pageSize}&totalSize=${pager.totalSize}&totalPage=${pager.totalPage}";
            var eventtime = $.trim($("#s_eventtime").val());
            var roadid = $.trim($("#s_roadid").val());
            var eventtype = $.trim($("#s_eventtype").val());
            var eventtype2 = $.trim($("#s_eventtype2").val());
            var s_publishstatus = $.trim($("#s_publishstatus").val());
            var s_eventcontents = $.trim($("#s_eventcontents").val());
            if(eventtime != ""){
                url += "&s_eventtime="+eventtime;
            }
            if(roadid != ""){
                url += "&s_roadid="+roadid;
            }
            if(eventtype != ""){
                url += "&s_eventtype="+eventtype;
            }
            if(eventtype2 != ""){
                url += "&s_eventtype2="+eventtype2;
            }
            if(eventtype2 != ""){
                url += "&s_eventtype2="+eventtype2;
            }
            if(s_publishstatus != ""){
                url += "&s_publishstatus="+s_publishstatus;
            }
            if(s_eventcontents != ""){
                url += "&s_eventcontents="+s_eventcontents;
            }
            location.href=url;
        }

        function eventChange(){
            var eventtype = $("#eventtype").val();
            if(eventtype != ''){
                $.ajax({

                    type: "GET",

                    url: "roadinfo/event/list?parentid="+eventtype,

                    dataType:'html',

                    success: function (data) {
                        $("#eventtype2").html('<option value="">请选择</option>');
                        if(data != null && data != ''){
                            var eventlist = eval('('+data+')');
                            for(var i = 0 ; i < eventlist.length ; i++){
                                var html = "<option id='eventtype2_"+parseInt(eventlist[i].typekey)+"' value='"+parseInt(eventlist[i].typekey)+"'>";
                                html += eventlist[i].typeval;
                                html += "</option>"
                                $("#eventtype2").append(html);
                            }
                        }
                    }
                });
            }else{
                $("#eventtype2").html('');
            }

        }

        function roadChange(){
            var roadid = $("#roadid").val();
            if(roadid != ''){
                $.ajax({

                    type: "GET",

                    url: "roadinfo/station/list?roadid="+roadid,

                    dataType:'html',

                    success: function (data) {
                        if(data != null && data != ''){
                            var stations = eval('('+data+')');
                            for(var i = 0 ; i < stations.length ; i++){
                                if(i == 0){
                                    $("#endstation").html("往"+stations[i].stationname + "方向：");
                                }
                                if(i == stations.length -1){
                                    $("#startstation").html("往"+stations[i].stationname + "方向：");
                                }
                            }
                        }

                    }
                });
                getTollstation(roadid);
            }else{
                $("#startstation").html('');
                $("#endstation").html('');
            }

        }

        function getTollstation(roadid){
            if(roadid != ''){
                $.ajax({

                    type: "GET",

                    url: "roadinfo/tollstation/list?roadid="+roadid,

                    dataType:'html',

                    success: function (data) {

                        $("#tollstation").html('<option value="">请选择</option>');
                        if(data != null && data != ''){
                            var stations = eval('('+data+')');
                            for(var i = 0 ; i < stations.length ; i++){
                                var html = "<option id='tollstation"+parseInt(stations[i].id)+"' value='"+parseInt(stations[i].id)+"'>";
                                html += stations[i].stationname;
                                html += "</option>"
                                $("#tollstation").append(html);
                            }
                        }

                    }
                });
            }
        }


        function doCheck(){
            if ($("#roadid").val() == "") {
                alert("请选择高速公路");
                myForm.roadid.focus();
                return false;
            }

            if ($("#eventtime").val() == "") {
                alert("请选择事件发生时间");
                myForm.eventtime.focus();
                return false;
            }

            if ($("#tollstation").val() == "") {
                alert("请选择涉及站");
                myForm.tollstation.focus();
                return false;
            }

            if ($("#eventtype").val() == "") {
                alert("请选择大类型");
                myForm.eventtype.focus();
                return false;
            }

            if ($("#eventtype2").val() == "") {
                alert("请选择子类型");
                myForm.eventtype2.focus();
                return false;
            }

            if ($("#upinstate").val() == "") {
                var s = $.trim($("#startstation").html());
                s=s.substring(0, s.length-1);
                alert("请选择"+s+"入站类型");
                myForm.upinstate.focus();
                return false;
            }

            if ($("#upoutstate").val() == "") {
                var s = $.trim($("#startstation").html());
                s=s.substring(0, s.length-1);
                alert("请选择"+s+"出站类型");
                myForm.upoutstate.focus();
                return false;
            }

            if ($("#downinstate").val() == "") {
                var s = $.trim($("#endstation").html());
                s=s.substring(0, s.length-1);
                alert("请选择"+s+"入站类型");
                myForm.downinstate.focus();
                return false;
            }

            if ($("#downoutstate").val() == "") {
                var s = $.trim($("#endstation").html());
                s=s.substring(0, s.length-1);
                alert("请选择"+s+"出站类型");
                myForm.downoutstate.focus();
                return false;
            }



            if ($("#startlatitude").val() == "") {
                alert("请选择事件位置");
                myForm.startlatitude.focus();
                return false;
            }

            return true;
        }


        function onSubmit(){
            document.getElementById('eventcontents').value = window.editor.html();
            if(doCheck()){
                if ($.trim($("#eventcontents").val()) == "") {
                    alert("请填写事件内容");
                    myForm.eventcontents.focus();
                    return false;
                }
                document.myForm.submit();
            }
        }




        //=====================================================================================================================




        
</script>
 <script>
        KindEditor.ready(function (K) {
            window.editor = K.create('textarea[name="eventcontents"]', {
                cssPath: 'js/plugins/code/prettify.css',
                uploadJson: 'news_upload.do',
                fileManagerJson: 'file_manager_json.jsp',
                allowFileManager: false,
                resizeType: 0,
                allowImageUpload: false,
                showRemote: true,
                showLocal: true,
                autoHeightMode: false,

                items : [
                    'source', '|', 'undo', 'redo', '|', 'preview', 'print', 'template', 'code', 'cut', 'copy', 'paste',
                    'plainpaste', 'wordpaste', '|', 'justifyleft', 'justifycenter', 'justifyright',
                    'justifyfull', 'insertorderedlist', 'insertunorderedlist', 'indent', 'outdent', 'subscript',
                    'superscript', 'clearhtml', 'quickformat', 'selectall', '|', 'fullscreen', '/',
                    'formatblock', 'fontname', 'fontsize', '|', 'forecolor', 'hilitecolor', 'bold',
                    'italic', 'underline', 'strikethrough', 'lineheight', 'removeformat', '|',
                    'hr', 'pagebreak',
                    'anchor', 'link', 'unlink', '|', 'about'
                ],
                afterCreate: function () {
                    this.loadPlugin('autoheight');
                },
                afterBlur: function () {
                    this.sync();
                },  //Kindeditor下获取文本框信息
                afterChange : function() {
                    var limitNum = 2000;  //设定限制字数
                    if(this.count('text') > limitNum) {
                        pattern = ('字数超过限制，请适当删除部分内容');
                        alert(pattern);
                        //超过字数限制自动截取
                        var strValue = window.editor.text();
                        strValue = strValue.substring(0,limitNum);
                        window.editor.text(strValue);
                    }
                }
            });
            K('#generatebtn').bind('click', function (e) {
                if(doCheck()){
                    var contents = "";
                    var roadid = $("#roadid").val();
                    var eventtime = $("#eventtime").val();
                    var eventtype = $("#eventtype").val();
                    var eventtype2 = $("#eventtype2").val();
                    var startstation = $("#startstation").html();
                    var endstation = $("#endstation").html();
                    var upinstate = $.trim($("#upinstate").val());
                    var upoutstate = $.trim($("#upoutstate").val());
                    var downinstate = $.trim($("#downinstate").val());
                    var downoutstate = $.trim($("#downoutstate").val());
                    var tollstation = $("#tollstation").val();

                    contents += eventtime + "，";
                    contents += $("#roadid" + roadid).html() + "，";
                    contents += $.trim($("#eventtype2_" + eventtype2).html()) + "，";
                    if(upinstate != '' || upoutstate != ''){
                        var flag1 = false;
                        var flag2 = false;
                        var cont = "";
                        if($.trim($("#upinstate"+upinstate).html()) != '无'){
                            cont +=  $.trim($("#upinstate"+upinstate).html())+ "入站 ，";
                            flag1 = true;
                        }
                        if($.trim($("#upoutstate"+upoutstate).html()) != '无'){
                            cont +=  $.trim($("#upoutstate"+upoutstate).html()) + "出站，" ;
                            flag2 = true;
                        }
                        if(flag1 || flag2){
                            contents += startstation;
                            contents += cont;
                        }
                    }
                    if(downinstate != '' || downoutstate != ''){
                        var flag1 = false;
                        var flag2 = false;
                        var cont = "";

                        if($.trim($("#downinstate"+downinstate).html()) != '无'){
                            cont +=  $.trim($("#downinstate"+downinstate).html())+ "入站 ，";
                            flag1 = true;
                        }
                        if($.trim($("#downoutstate"+downoutstate).html()) != '无'){
                            cont +=  $.trim($("#downoutstate"+downoutstate).html()) + "出站，" ;
                            flag2 = true;
                        }
                        if(flag1 || flag2){
                            contents += endstation;
                            contents += cont;
                        }

                    }
                    contents += "涉及的收费站为："+ $("#tollstation"+tollstation).html()  +"。";
                    window.editor.text(contents);
                }
            });

        });
            prettyPrint();
        window.editor = K.create('#helpinfo');
</script>
</head>
<body>
<form name="myForm" id="myForm" method="post" action="roadinfo/roadconditions" >
    <input type="hidden" id="roottype" name="roottype" value="${roottype}"/>
    <input type="hidden" name="id" value='<fmt:parseNumber value="${roadcondition.ID}" integerOnly="true" />' />
    <input type="hidden" name="eventid" value='<fmt:parseNumber value="${roadcondition.EventId}" integerOnly="true" />' />
    <input type="hidden" name="s_eventtime" id="s_eventtime" value='${s_eventtime}'/>
    <input type="hidden" name="s_roadid" id="s_roadid" value='<fmt:parseNumber value="${s_roadid}" integerOnly="true" />'/>
    <input type="hidden" name="s_eventtype" id="s_eventtype" value='<fmt:parseNumber value="${s_eventtype}" integerOnly="true" />'/>
    <input type="hidden" name="s_eventtype2" id="s_eventtype2" value='<fmt:parseNumber value="${s_eventtype2}" integerOnly="true" />'/>
    <input type="hidden" name="s_publishstatus" id="s_publishstatus" value='<fmt:parseNumber value="${s_publishstatus}" integerOnly="true" />'/>
    <input type="hidden" name="s_eventcontents" id="s_eventcontents" value='${s_eventcontents}'/>
    <input type="hidden" name="stationinfo" id="stationinfo" value='${stations}'/>
    <ul class="breadcrumb">
        <li><i class="icon-home icon-2x"></i></li>
        <li>当前位置：
            <c:choose>
                <c:when test="${roottype == 3}">
                    <c:if test="${roadcondition.ID == null}">管制事件 > 新增管制事件</c:if>
                    <c:if test="${roadcondition.ID != null}">管制事件 > 修改管制事件</c:if>
                </c:when>
            </c:choose></li>
    </ul>
    <div class="widget widget-edit">
        <div class="widget-content">
            <table class="pn-ftable table-bordered" border="0" cellpadding="10">
                <tbody>
                <tr>
                    <th style="width: 300px;"><span class="point"style="color:red">*</span>高速公路：</th>
                    <td><select name="roadid" id ="roadid" style="width:40%"  onchange="roadChange()">
							<option value="">请选择高速公路</option>
                        <c:forEach items="${roadinfo}" var="item" >
                            <option id="roadid<fmt:parseNumber value="${item.roadid}" integerOnly="true" />"
                                    value="<fmt:parseNumber value="${item.roadid}" integerOnly="true" />"
                                    ${item.roadid == roadcondition.RoadId ? "selected" : ""}>${item.roadname}</option>
                        </c:forEach>
					</select>
					</td>
                </tr>
                <tr>
                    <th><span class="point"style="color:red">*</span>发生时间：</th>
                    <td>
                        <input type="text" name="eventtime" readonly="readonly" id="eventtime"
                               <c:if test="${roadcondition.EventTime != null}">
                                   value='<date:date value="${roadcondition.EventTime}"  />'
                               </c:if>
                               class="Wdate" onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd HH:mm:ss'})"
                                style="width:40%;"/>
                    </td>
                </tr>
                <tr>
                    <th><span class="point"style="color:red">*</span>涉及收费站：</th>
                    <td>
                        <select name="tollstation" id="tollstation" style="width:40%"/>
                        <c:forEach items="${tollstations}" var="item">
                            <option id="tollstation<fmt:parseNumber value="${item.id}" integerOnly="true" />"
                                    value="<fmt:parseNumber value="${item.id}" integerOnly="true" />"
                                ${roadcondition.Tollstation==item.id ? "selected" :""} >
                                    ${item.stationname}
                            </option>
                        </c:forEach>
                    </td>
                </tr>

                <tr>
                    <th><span class="point"style="color:red">*</span>大类型：</th>
                    <td>
                        <select name="eventtype" id="eventtype" onchange="eventChange()" style="width:40%;" >
                            <option value="">请选择</option>
                            <c:forEach items="${events}"  var="item">
                                <option id="eventtype<fmt:parseNumber value="${item.typekey}" integerOnly="true" />"
                                        value='<fmt:parseNumber value="${item.typekey}" integerOnly="true" />'
                                        ${roadcondition.EventType==item.typekey ? "selected" :""}>
                                        ${item.typeval}
                                </option>
                            </c:forEach>
                        </select>
                    </td>
                </tr>
                <tr>
                    <th><span class="point"style="color:red">*</span>子类型：</th>
                    <td>
                        <select name="eventtype2" id="eventtype2" style="width:40%;">
                            <c:forEach items="${event2s}" var="item">
                                <option id="eventtype2_<fmt:parseNumber value="${item.typekey}" integerOnly="true" />"
                                        value='<fmt:parseNumber value="${item.typekey}" integerOnly="true" />'
                                        ${roadcondition.EventType2==item.typekey ? "selected" :""} >
                                        ${item.typeval}
                                </option>
                            </c:forEach>
                        </select>
                    </td>
                </tr>
                <tr>
                    <th>
                        <span id="startstation">
                            <c:forEach items="${stations}" var="item" varStatus="status">
                                <c:if test="${status.last}">
                                    往${item.stationname}方向：
                                </c:if>
                            </c:forEach>

                        </span>
                    </th>
                    <td>

                        <span class="point"style="color:red">*</span>入站：
                        <select name="upinstate" id="upinstate" style="width:15%">
                            <option value=""></option>
                        <c:forEach items="${zparastate}" var="item">
                            <c:if test="${item.typeflag == 0}">
                                <option id="upinstate<fmt:parseNumber value="${item.typekey}" integerOnly="true" />"
                                        value="<fmt:parseNumber value="${item.typekey}" integerOnly="true" />"
                                    ${roadcondition.UpInState==item.typekey ? "selected" :""} >
                                        ${item.typeval}
                                </option>
                            </c:if>
                        </c:forEach>
                        </select>
                        &nbsp;&nbsp;&nbsp;&nbsp;
                        <span class="point"style="color:red">*</span>出站：
                        <select name="upoutstate" id="upoutstate" style="width:15%">
                            <option value=""></option>
                        <c:forEach items="${zparastate}" var="item">
                            <c:if test="${item.typeflag == 1}">
                                <option id="upoutstate<fmt:parseNumber value="${item.typekey}" integerOnly="true" />"
                                        value="<fmt:parseNumber value="${item.typekey}" integerOnly="true" />"
                                    ${roadcondition.UpOutState==item.typekey ? "selected" :""} >
                                        ${item.typeval}
                                </option>
                            </c:if>
                        </c:forEach>
                        </select>
                    </td>
                </tr>
                   <tr>
                    <th>
                        <span id="endstation">
                             <c:forEach items="${stations}" var="item" varStatus="status">
                                 <c:if test="${status.first}">
                                     往${item.stationname}方向：
                                 </c:if>
                             </c:forEach>
                        </span>
                    </th>
                       <td>
                           <span class="point"style="color:red">*</span>入站：
                        <select name="downinstate" id="downinstate" style="width:15%">
                            <option value=""></option>
                        <c:forEach items="${zparastate}" var="item">
                            <c:if test="${item.typeflag == 0}">
                                <option id="downinstate<fmt:parseNumber value="${item.typekey}" integerOnly="true" />"
                                        value="<fmt:parseNumber value="${item.typekey}" integerOnly="true" />"
                                    ${roadcondition.DownInState==item.typekey ? "selected" :""} >
                                        ${item.typeval}
                                </option>
                            </c:if>
                        </c:forEach>
                        </select>
                        &nbsp;&nbsp;&nbsp;&nbsp;
                           <span class="point"style="color:red">*</span>出站：
                        <select name="downoutstate" id="downoutstate" style="width:15%">
                            <option value=""></option>
                        <c:forEach items="${zparastate}" var="item">
                            <c:if test="${item.typeflag == 1}">
                                <option id="downoutstate<fmt:parseNumber value="${item.typekey}" integerOnly="true" />"
                                        value="<fmt:parseNumber value="${item.typekey}" integerOnly="true" />"
                                    ${roadcondition.DownOutState==item.typekey ? "selected" :""} >
                                        ${item.typeval}
                                </option>
                            </c:if>
                        </c:forEach>
                        </select>
                    </td>
                </tr>

                <tr>
                    <th><span class="point"style="color:red">*</span>地图标识：</th>
                    <td>
                        <input type="hidden" id="startlongitude" name="startlongitude" value="${roadcondition.StartLongitude}"/>
                        <input type="hidden" id="startlatitude" name="startlatitude" value="${roadcondition.StartLatitude}"/>
                        <div id="container">

                        </div>

                    </td>
                </tr>
                <tr>
                    <th><span class="point"style="color:red">*</span>事件内容：</th>
                    <!-- <td height="30" colspan="4"> -->
                    <td>
                        <textarea name="eventcontents" id="eventcontents"  cols="80" rows="20" style="overflow-y:scroll; width:80%" >
                            ${roadcondition.EventContents}
                        </textarea>
                    </td>
                </tr>

				<tr>

                    <th>发布状态：</th>
                    <td>
                        <c:choose>
                            <c:when test="${roadcondition.PublishState == 2}">
                                已发布
                            </c:when>
                            <c:otherwise>
                                未发布
                            </c:otherwise>
                        </c:choose>
					</td>
                </tr>
                <c:if test="${roadcondition.PublishState== 2}">
                <tr>
                	<th>发布时间：</th>
                	<td><date:date value="${roadcondition.PublishTime}"  /></td>
                </tr>
                </c:if>
                </tbody>
            </table>
            <div class="widget-bottom" >
            <input type="hidden" value="${pager.currentPage}" name="currentPage"/>
            <input type="hidden" value="${pager.pageSize}" name="pageSize"/>
            <input type="hidden" value="${pager.totalSize}" name="totalSize"/>
            <input type="hidden" value="${pager.totalPage}" name="totalPage"/>
                <a  onclick="returnList()"
						class="btn btn-danger pull-right">返 回</a> 
                <a onclick="onSubmit();" href="javascript:void(0);"
                   class="btn btn-success pull-right">保存</a>
                <a  id="generatebtn" class="btn btn-info pull-right">生成事件内容</a>
            </div>
        </div>
        <!-- /widget-content -->

    </div>
</form>
</body>
</html>