<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.Contest" %>
<%@ page import="com.chengxusheji.po.Project" %>
<%@ page import="com.chengxusheji.po.School" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    List<Contest> contestList = (List<Contest>)request.getAttribute("contestList");
    //获取所有的projectObj信息
    List<Project> projectList = (List<Project>)request.getAttribute("projectList");
    //获取所有的schoolObj信息
    List<School> schoolList = (List<School>)request.getAttribute("schoolList");
    int currentPage =  (Integer)request.getAttribute("currentPage"); //当前页
    int totalPage =   (Integer)request.getAttribute("totalPage");  //一共多少页
    int recordNumber =   (Integer)request.getAttribute("recordNumber");  //一共多少记录
    School schoolObj = (School)request.getAttribute("schoolObj");
    Project projectObj = (Project)request.getAttribute("projectObj");
    String contestName = (String)request.getAttribute("contestName"); //比赛名称查询关键字
    String signUpTime = (String)request.getAttribute("signUpTime"); //报名时间查询关键字
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
<title>比赛查询</title>
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
			    	<li role="presentation" class="active"><a href="#contestListPanel" aria-controls="contestListPanel" role="tab" data-toggle="tab">比赛列表</a></li>
			    	<li role="presentation" ><a href="<%=basePath %>Contest/contest_frontAdd.jsp" style="display:none;">添加比赛</a></li>
				</ul>
			  	<!-- Tab panes -->
			  	<div class="tab-content">
				    <div role="tabpanel" class="tab-pane active" id="contestListPanel">
				    		<div class="row">
				    			<div class="col-md-12 top5">
				    				<div class="table-responsive">
				    				<table class="table table-condensed table-hover">
				    					<tr class="success bold"><td>序号</td><td>举办学校</td><td>比赛项目</td><td>比赛名称</td><td>比赛地点</td><td>人数限制</td><td>报名时间</td><td>截止时间</td><td>操作</td></tr>
				    					<% 
				    						/*计算起始序号*/
				    	            		int startIndex = (currentPage -1) * 5;
				    	            		/*遍历记录*/
				    	            		for(int i=0;i<contestList.size();i++) {
					    	            		int currentIndex = startIndex + i + 1; //当前记录的序号
					    	            		Contest contest = contestList.get(i); //获取到比赛对象
 										%>
 										<tr>
 											<td><%=currentIndex %></td> 
 											<td><%=contest.getSchoolObj().getSchoolName() %></td>
 											<td><%=contest.getProjectObj().getProjectName() %></td>
 											<td><%=contest.getContestName() %></td>
 											<td><%=contest.getContestPlace() %></td>
 											<td><%=contest.getPersonNumber() %></td>
 											<td><%=contest.getSignUpTime() %></td>
 											<td><%=contest.getEndTime() %></td>
 											<td>
 												<a href="<%=basePath  %>Contest/<%=contest.getContestId() %>/frontshow"><i class="fa fa-info"></i>&nbsp;查看</a>&nbsp;
 												<a href="#" onclick="contestEdit('<%=contest.getContestId() %>');" style="display:none;"><i class="fa fa-pencil fa-fw"></i>编辑</a>&nbsp;
 												<a href="#" onclick="contestDelete('<%=contest.getContestId() %>');" style="display:none;"><i class="fa fa-trash-o fa-fw"></i>删除</a>
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
    		<h1>比赛查询</h1>
		</div>
		<form name="contestQueryForm" id="contestQueryForm" action="<%=basePath %>Contest/frontlist" class="mar_t15">
            <div class="form-group">
            	<label for="schoolObj_schoolId">举办学校：</label>
                <select id="schoolObj_schoolId" name="schoolObj.schoolId" class="form-control">
                	<option value="0">不限制</option>
	 				<%
	 				for(School schoolTemp:schoolList) {
	 					String selected = "";
 					if(schoolObj!=null && schoolObj.getSchoolId()!=null && schoolObj.getSchoolId().intValue()==schoolTemp.getSchoolId().intValue())
 						selected = "selected";
	 				%>
 				 <option value="<%=schoolTemp.getSchoolId() %>" <%=selected %>><%=schoolTemp.getSchoolName() %></option>
	 				<%
	 				}
	 				%>
 			</select>
            </div>
            <div class="form-group">
            	<label for="projectObj_projectId">比赛项目：</label>
                <select id="projectObj_projectId" name="projectObj.projectId" class="form-control">
                	<option value="0">不限制</option>
	 				<%
	 				for(Project projectTemp:projectList) {
	 					String selected = "";
 					if(projectObj!=null && projectObj.getProjectId()!=null && projectObj.getProjectId().intValue()==projectTemp.getProjectId().intValue())
 						selected = "selected";
	 				%>
 				 <option value="<%=projectTemp.getProjectId() %>" <%=selected %>><%=projectTemp.getProjectName() %></option>
	 				<%
	 				}
	 				%>
 			</select>
            </div>
			<div class="form-group">
				<label for="contestName">比赛名称:</label>
				<input type="text" id="contestName" name="contestName" value="<%=contestName %>" class="form-control" placeholder="请输入比赛名称">
			</div>






			<div class="form-group">
				<label for="signUpTime">报名时间:</label>
				<input type="text" id="signUpTime" name="signUpTime" class="form-control"  placeholder="请选择报名时间" value="<%=signUpTime %>" onclick="SelectDate(this,'yyyy-MM-dd')" />
			</div>
            <input type=hidden name=currentPage value="<%=currentPage %>" />
            <button type="submit" class="btn btn-primary">查询</button>
        </form>
	</div>

		</div>
	</div> 
<div id="contestEditDialog" class="modal fade" tabindex="-1" role="dialog">
  <div class="modal-dialog" style="width:900px;" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title"><i class="fa fa-edit"></i>&nbsp;比赛信息编辑</h4>
      </div>
      <div class="modal-body" style="height:450px; overflow: scroll;">
      	<form class="form-horizontal" name="contestEditForm" id="contestEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="contest_contestId_edit" class="col-md-3 text-right">比赛id:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="contest_contestId_edit" name="contest.contestId" class="form-control" placeholder="请输入比赛id" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="contest_schoolObj_schoolId_edit" class="col-md-3 text-right">举办学校:</label>
		  	 <div class="col-md-9">
			    <select id="contest_schoolObj_schoolId_edit" name="contest.schoolObj.schoolId" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="contest_projectObj_projectId_edit" class="col-md-3 text-right">比赛项目:</label>
		  	 <div class="col-md-9">
			    <select id="contest_projectObj_projectId_edit" name="contest.projectObj.projectId" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="contest_contestName_edit" class="col-md-3 text-right">比赛名称:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="contest_contestName_edit" name="contest.contestName" class="form-control" placeholder="请输入比赛名称">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="contest_contestDesc_edit" class="col-md-3 text-right">比赛介绍:</label>
		  	 <div class="col-md-9">
			 	<textarea name="contest.contestDesc" id="contest_contestDesc_edit" style="width:100%;height:500px;"></textarea>
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="contest_contestPlace_edit" class="col-md-3 text-right">比赛地点:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="contest_contestPlace_edit" name="contest.contestPlace" class="form-control" placeholder="请输入比赛地点">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="contest_personNumber_edit" class="col-md-3 text-right">人数限制:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="contest_personNumber_edit" name="contest.personNumber" class="form-control" placeholder="请输入人数限制">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="contest_signUpTime_edit" class="col-md-3 text-right">报名时间:</label>
		  	 <div class="col-md-9">
                <div class="input-group date contest_signUpTime_edit col-md-12" data-link-field="contest_signUpTime_edit">
                    <input class="form-control" id="contest_signUpTime_edit" name="contest.signUpTime" size="16" type="text" value="" placeholder="请选择报名时间" readonly>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                </div>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="contest_endTime_edit" class="col-md-3 text-right">截止时间:</label>
		  	 <div class="col-md-9">
                <div class="input-group date contest_endTime_edit col-md-12" data-link-field="contest_endTime_edit">
                    <input class="form-control" id="contest_endTime_edit" name="contest.endTime" size="16" type="text" value="" placeholder="请选择截止时间" readonly>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                </div>
		  	 </div>
		  </div>
		</form> 
	    <style>#contestEditForm .form-group {margin-bottom:5px;}  </style>
      </div>
      <div class="modal-footer"> 
      	<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
      	<button type="button" class="btn btn-primary" onclick="ajaxContestModify();">提交</button>
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
var contest_contestDesc_edit = UE.getEditor('contest_contestDesc_edit'); //比赛介绍编辑器
var basePath = "<%=basePath%>";
/*跳转到查询结果的某页*/
function GoToPage(currentPage,totalPage) {
    if(currentPage==0) return;
    if(currentPage>totalPage) return;
    document.contestQueryForm.currentPage.value = currentPage;
    document.contestQueryForm.submit();
}

/*可以直接跳转到某页*/
function changepage(totalPage)
{
    var pageValue=document.contestQueryForm.pageValue.value;
    if(pageValue>totalPage) {
        alert('你输入的页码超出了总页数!');
        return ;
    }
    document.contestQueryForm.currentPage.value = pageValue;
    documentcontestQueryForm.submit();
}

/*弹出修改比赛界面并初始化数据*/
function contestEdit(contestId) {
	$.ajax({
		url :  basePath + "Contest/" + contestId + "/update",
		type : "get",
		dataType: "json",
		success : function (contest, response, status) {
			if (contest) {
				$("#contest_contestId_edit").val(contest.contestId);
				$.ajax({
					url: basePath + "School/listAll",
					type: "get",
					success: function(schools,response,status) { 
						$("#contest_schoolObj_schoolId_edit").empty();
						var html="";
		        		$(schools).each(function(i,school){
		        			html += "<option value='" + school.schoolId + "'>" + school.schoolName + "</option>";
		        		});
		        		$("#contest_schoolObj_schoolId_edit").html(html);
		        		$("#contest_schoolObj_schoolId_edit").val(contest.schoolObjPri);
					}
				});
				$.ajax({
					url: basePath + "Project/listAll",
					type: "get",
					success: function(projects,response,status) { 
						$("#contest_projectObj_projectId_edit").empty();
						var html="";
		        		$(projects).each(function(i,project){
		        			html += "<option value='" + project.projectId + "'>" + project.projectName + "</option>";
		        		});
		        		$("#contest_projectObj_projectId_edit").html(html);
		        		$("#contest_projectObj_projectId_edit").val(contest.projectObjPri);
					}
				});
				$("#contest_contestName_edit").val(contest.contestName);
				contest_contestDesc_edit.setContent(contest.contestDesc, false);
				$("#contest_contestPlace_edit").val(contest.contestPlace);
				$("#contest_personNumber_edit").val(contest.personNumber);
				$("#contest_signUpTime_edit").val(contest.signUpTime);
				$("#contest_endTime_edit").val(contest.endTime);
				$('#contestEditDialog').modal('show');
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*删除比赛信息*/
function contestDelete(contestId) {
	if(confirm("确认删除这个记录")) {
		$.ajax({
			type : "POST",
			url : basePath + "Contest/deletes",
			data : {
				contestIds : contestId,
			},
			success : function (obj) {
				if (obj.success) {
					alert("删除成功");
					$("#contestQueryForm").submit();
					//location.href= basePath + "Contest/frontlist";
				}
				else 
					alert(obj.message);
			},
		});
	}
}

/*ajax方式提交比赛信息表单给服务器端修改*/
function ajaxContestModify() {
	$.ajax({
		url :  basePath + "Contest/" + $("#contest_contestId_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#contestEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                $("#contestQueryForm").submit();
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

    /*报名时间组件*/
    $('.contest_signUpTime_edit').datetimepicker({
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
    /*截止时间组件*/
    $('.contest_endTime_edit').datetimepicker({
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

