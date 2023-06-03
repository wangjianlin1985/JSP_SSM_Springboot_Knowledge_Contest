<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.Tiku" %>
<%@ page import="com.chengxusheji.po.TikuType" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    List<Tiku> tikuList = (List<Tiku>)request.getAttribute("tikuList");
    //获取所有的tikuTypeObj信息
    List<TikuType> tikuTypeList = (List<TikuType>)request.getAttribute("tikuTypeList");
    int currentPage =  (Integer)request.getAttribute("currentPage"); //当前页
    int totalPage =   (Integer)request.getAttribute("totalPage");  //一共多少页
    int recordNumber =   (Integer)request.getAttribute("recordNumber");  //一共多少记录
    TikuType tikuTypeObj = (TikuType)request.getAttribute("tikuTypeObj");
    String tikuName = (String)request.getAttribute("tikuName"); //题库名称查询关键字
    String addTime = (String)request.getAttribute("addTime"); //发布时间查询关键字
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
<title>题库测试查询</title>
<link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
<link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
<link href="<%=basePath %>plugins/animate.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-datetimepicker.min.css" rel="stylesheet" media="screen">
</head>
<body style="margin-top:70px;">
<div class="container">
<jsp:include page="../header.jsp"></jsp:include>
	<div class="row"> 
		<div class="col-md-9 wow fadeInDown" data-wow-duration="0.5s">
			<div>
				<!-- Nav tabs -->
				<ul class="nav nav-tabs" role="tablist">
			    	<li><a href="<%=basePath %>index.jsp">首页</a></li>
			    	<li role="presentation" class="active"><a href="#tikuListPanel" aria-controls="tikuListPanel" role="tab" data-toggle="tab">题库测试列表</a></li>
			    	<li role="presentation" ><a href="<%=basePath %>Tiku/tiku_frontAdd.jsp" style="display:none;">添加题库测试</a></li>
				</ul>
			  	<!-- Tab panes -->
			  	<div class="tab-content">
				    <div role="tabpanel" class="tab-pane active" id="tikuListPanel">
				    		<div class="row">
				    			<div class="col-md-12 top5">
				    				<div class="table-responsive">
				    				<table class="table table-condensed table-hover">
				    					<tr class="success bold"><td>序号</td><td>题库id</td><td>题库分类</td><td>题库名称</td><td>点击率</td><td>发布时间</td><td>操作</td></tr>
				    					<% 
				    						/*计算起始序号*/
				    	            		int startIndex = (currentPage -1) * 5;
				    	            		/*遍历记录*/
				    	            		for(int i=0;i<tikuList.size();i++) {
					    	            		int currentIndex = startIndex + i + 1; //当前记录的序号
					    	            		Tiku tiku = tikuList.get(i); //获取到题库测试对象
 										%>
 										<tr>
 											<td><%=currentIndex %></td>
 											<td><%=tiku.getTikuId() %></td>
 											<td><%=tiku.getTikuTypeObj().getTikuTypeName() %></td>
 											<td><%=tiku.getTikuName() %></td>
 											<td><%=tiku.getHitNum() %></td>
 											<td><%=tiku.getAddTime() %></td>
 											<td>
 												<a href="<%=basePath  %>Tiku/<%=tiku.getTikuId() %>/frontshow"><i class="fa fa-info"></i>&nbsp;查看</a>&nbsp;
 												<a href="#" onclick="tikuEdit('<%=tiku.getTikuId() %>');" style="display:none;"><i class="fa fa-pencil fa-fw"></i>编辑</a>&nbsp;
 												<a href="#" onclick="tikuDelete('<%=tiku.getTikuId() %>');" style="display:none;"><i class="fa fa-trash-o fa-fw"></i>删除</a>
 											</td> 
 										</tr>
 										<%}%>
				    				</table>
				    				</div>
				    			</div>
				    		</div>

				    		<div class="row">
					            <div class="col-md-12">
						            <nav class="pull-left">
						                <ul class="pagination">
						                    <li><a href="#" onclick="GoToPage(<%=currentPage-1 %>,<%=totalPage %>);" aria-label="Previous"><span aria-hidden="true">&laquo;</span></a></li>
						                     <%
						                    	int startPage = currentPage - 5;
						                    	int endPage = currentPage + 5;
						                    	if(startPage < 1) startPage=1;
						                    	if(endPage > totalPage) endPage = totalPage;
						                    	for(int i=startPage;i<=endPage;i++) {
						                    %>
						                    <li class="<%= currentPage==i?"active":"" %>"><a href="#"  onclick="GoToPage(<%=i %>,<%=totalPage %>);"><%=i %></a></li>
						                    <%  } %> 
						                    <li><a href="#" onclick="GoToPage(<%=currentPage+1 %>,<%=totalPage %>);"><span aria-hidden="true">&raquo;</span></a></li>
						                </ul>
						            </nav>
						            <div class="pull-right" style="line-height:75px;" >共有<%=recordNumber %>条记录，当前第 <%=currentPage %>/<%=totalPage %> 页</div>
					            </div>
				            </div> 
				    </div>
				</div>
			</div>
		</div>
	<div class="col-md-3 wow fadeInRight">
		<div class="page-header">
    		<h1>题库测试查询</h1>
		</div>
		<form name="tikuQueryForm" id="tikuQueryForm" action="<%=basePath %>Tiku/frontlist" class="mar_t15" method="post">
            <div class="form-group">
            	<label for="tikuTypeObj_typeId">题库分类：</label>
                <select id="tikuTypeObj_typeId" name="tikuTypeObj.typeId" class="form-control">
                	<option value="0">不限制</option>
	 				<%
	 				for(TikuType tikuTypeTemp:tikuTypeList) {
	 					String selected = "";
 					if(tikuTypeObj!=null && tikuTypeObj.getTypeId()!=null && tikuTypeObj.getTypeId().intValue()==tikuTypeTemp.getTypeId().intValue())
 						selected = "selected";
	 				%>
 				 <option value="<%=tikuTypeTemp.getTypeId() %>" <%=selected %>><%=tikuTypeTemp.getTikuTypeName() %></option>
	 				<%
	 				}
	 				%>
 			</select>
            </div>
			<div class="form-group">
				<label for="tikuName">题库名称:</label>
				<input type="text" id="tikuName" name="tikuName" value="<%=tikuName %>" class="form-control" placeholder="请输入题库名称">
			</div>






			<div class="form-group">
				<label for="addTime">发布时间:</label>
				<input type="text" id="addTime" name="addTime" class="form-control"  placeholder="请选择发布时间" value="<%=addTime %>" onclick="SelectDate(this,'yyyy-MM-dd')" />
			</div>
            <input type=hidden name=currentPage value="<%=currentPage %>" />
            <button type="submit" class="btn btn-primary">查询</button>
        </form>
	</div>

		</div>
	</div> 
<div id="tikuEditDialog" class="modal fade" tabindex="-1" role="dialog">
  <div class="modal-dialog" style="width:900px;" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title"><i class="fa fa-edit"></i>&nbsp;题库测试信息编辑</h4>
      </div>
      <div class="modal-body" style="height:450px; overflow: scroll;">
      	<form class="form-horizontal" name="tikuEditForm" id="tikuEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="tiku_tikuId_edit" class="col-md-3 text-right">题库id:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="tiku_tikuId_edit" name="tiku.tikuId" class="form-control" placeholder="请输入题库id" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="tiku_tikuTypeObj_typeId_edit" class="col-md-3 text-right">题库分类:</label>
		  	 <div class="col-md-9">
			    <select id="tiku_tikuTypeObj_typeId_edit" name="tiku.tikuTypeObj.typeId" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="tiku_tikuName_edit" class="col-md-3 text-right">题库名称:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="tiku_tikuName_edit" name="tiku.tikuName" class="form-control" placeholder="请输入题库名称">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="tiku_tikuContent_edit" class="col-md-3 text-right">题库内容:</label>
		  	 <div class="col-md-9">
			 	<textarea name="tiku.tikuContent" id="tiku_tikuContent_edit" style="width:100%;height:500px;"></textarea>
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="tiku_hitNum_edit" class="col-md-3 text-right">点击率:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="tiku_hitNum_edit" name="tiku.hitNum" class="form-control" placeholder="请输入点击率">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="tiku_addTime_edit" class="col-md-3 text-right">发布时间:</label>
		  	 <div class="col-md-9">
                <div class="input-group date tiku_addTime_edit col-md-12" data-link-field="tiku_addTime_edit">
                    <input class="form-control" id="tiku_addTime_edit" name="tiku.addTime" size="16" type="text" value="" placeholder="请选择发布时间" readonly>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                </div>
		  	 </div>
		  </div>
		</form> 
	    <style>#tikuEditForm .form-group {margin-bottom:5px;}  </style>
      </div>
      <div class="modal-footer"> 
      	<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
      	<button type="button" class="btn btn-primary" onclick="ajaxTikuModify();">提交</button>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->
<jsp:include page="../footer.jsp"></jsp:include> 
<script src="<%=basePath %>plugins/jquery.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap.js"></script>
<script src="<%=basePath %>plugins/wow.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap-datetimepicker.min.js"></script>
<script src="<%=basePath %>plugins/locales/bootstrap-datetimepicker.zh-CN.js"></script>
<script type="text/javascript" src="<%=basePath %>js/jsdate.js"></script>
<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor1_4_3/ueditor.config.js"></script>
<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor1_4_3/ueditor.all.min.js"> </script>
<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor1_4_3/lang/zh-cn/zh-cn.js"></script>
<script>
//实例化编辑器
var tiku_tikuContent_edit = UE.getEditor('tiku_tikuContent_edit'); //题库内容编辑器
var basePath = "<%=basePath%>";
/*跳转到查询结果的某页*/
function GoToPage(currentPage,totalPage) {
    if(currentPage==0) return;
    if(currentPage>totalPage) return;
    document.tikuQueryForm.currentPage.value = currentPage;
    document.tikuQueryForm.submit();
}

/*可以直接跳转到某页*/
function changepage(totalPage)
{
    var pageValue=document.tikuQueryForm.pageValue.value;
    if(pageValue>totalPage) {
        alert('你输入的页码超出了总页数!');
        return ;
    }
    document.tikuQueryForm.currentPage.value = pageValue;
    documenttikuQueryForm.submit();
}

/*弹出修改题库测试界面并初始化数据*/
function tikuEdit(tikuId) {
	$.ajax({
		url :  basePath + "Tiku/" + tikuId + "/update",
		type : "get",
		dataType: "json",
		success : function (tiku, response, status) {
			if (tiku) {
				$("#tiku_tikuId_edit").val(tiku.tikuId);
				$.ajax({
					url: basePath + "TikuType/listAll",
					type: "get",
					success: function(tikuTypes,response,status) { 
						$("#tiku_tikuTypeObj_typeId_edit").empty();
						var html="";
		        		$(tikuTypes).each(function(i,tikuType){
		        			html += "<option value='" + tikuType.typeId + "'>" + tikuType.tikuTypeName + "</option>";
		        		});
		        		$("#tiku_tikuTypeObj_typeId_edit").html(html);
		        		$("#tiku_tikuTypeObj_typeId_edit").val(tiku.tikuTypeObjPri);
					}
				});
				$("#tiku_tikuName_edit").val(tiku.tikuName);
				tiku_tikuContent_edit.setContent(tiku.tikuContent, false);
				$("#tiku_hitNum_edit").val(tiku.hitNum);
				$("#tiku_addTime_edit").val(tiku.addTime);
				$('#tikuEditDialog').modal('show');
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*删除题库测试信息*/
function tikuDelete(tikuId) {
	if(confirm("确认删除这个记录")) {
		$.ajax({
			type : "POST",
			url : basePath + "Tiku/deletes",
			data : {
				tikuIds : tikuId,
			},
			success : function (obj) {
				if (obj.success) {
					alert("删除成功");
					$("#tikuQueryForm").submit();
					//location.href= basePath + "Tiku/frontlist";
				}
				else 
					alert(obj.message);
			},
		});
	}
}

/*ajax方式提交题库测试信息表单给服务器端修改*/
function ajaxTikuModify() {
	$.ajax({
		url :  basePath + "Tiku/" + $("#tiku_tikuId_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#tikuEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                $("#tikuQueryForm").submit();
            }else{
                alert(obj.message);
            } 
		},
		processData: false,
		contentType: false,
	});
}

$(function(){
	/*小屏幕导航点击关闭菜单*/
    $('.navbar-collapse a').click(function(){
        $('.navbar-collapse').collapse('hide');
    });
    new WOW().init();

    /*发布时间组件*/
    $('.tiku_addTime_edit').datetimepicker({
    	language:  'zh-CN',  //语言
    	format: 'yyyy-mm-dd hh:ii:ss',
    	weekStart: 1,
    	todayBtn:  1,
    	autoclose: 1,
    	minuteStep: 1,
    	todayHighlight: 1,
    	startView: 2,
    	forceParse: 0
    });
})
</script>
</body>
</html>

