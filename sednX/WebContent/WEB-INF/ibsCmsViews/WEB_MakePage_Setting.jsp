<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt"  uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="hn" uri="/WEB-INF/tlds/hanibalWebDev.tld"%>
<script>
$('#settingAdd').click(function(){
	var count=Number($('#totalCount').val())+1;
	$('#totalCount').val(count);
	layout.add('${category}',count,'N','0');
});
$('#updateLayout').click(function(){
	var frmArray=layout.getArray();
	console.log(frmArray);
	for(var i=0;i<frmArray.length;i++){
		var formData = new FormData();
		//formData.append("uploadFile",);
	}
});
var layout={
	add:function(category,index,type,idx){
		$.ajax({
			url : "${pageContext.request.contextPath}/cms/makepage/editForm/"+category+"/"+index+"/"+type+"/"+idx,
			async: false,
			success : function(data){
				$('.setUI').append(data);
			},
			error : exception.ajaxException
		});
	},
	del:function(idx){
		alert(idx);
	},
	getArray:function(){
		var tempArray = new Array();
		$(".frm").each(function(){
		    tempArray.push($(this).attr("title"));
		})
		return tempArray;
	}
};

</script>
<div class="form_div setUI" style="max-height: 820px; overflow-y: auto; width:100%;">

</div>

<div class="tile col-md-12 p-5">
   <div class="col-md-6">
       <button class="btn btn-alt col-md-2 m-b-5" id="settingAdd">추가</button>
   </div>
   <div class="col-md-6">
       <button class="btn btn-alt col-md-2 m-b-5 pull-right" id="updateLayout">적용</button>
   </div>
</div>

<c:choose>
	<c:when test="${empty lists}">
		<script>
			layout.add('${category}',Number($('#totalCount').val())+1,'N','0');
			$('#totalCount').val(Number($('#totalCount').val())+1);
		</script>
	</c:when>
	<c:otherwise>
		<c:forEach items="${lists}" var="list" varStatus="status">
  				<script>
  				$('#totalCount').val(Number($('#totalCount').val())+1);
  				layout.add('${list.wl_category}','${status.count}','E','${list.idx}');
  				</script>
		</c:forEach>
	</c:otherwise>
</c:choose>
<input type="text" class="form-control" id="totalCount"> 
