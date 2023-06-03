<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.Score" %>
<%@ page import="com.chengxusheji.po.Contest" %>
<%@ page import="com.chengxusheji.po.Student" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    List<Score> scoreList = (List<Score>)request.getAttribute("scoreList");
    //获取所有的contestObj信息
    List<Contest> contestList = (List<Contest>)request.getAttribute("contestList");
    //获取所有的studentObj信息
    List<Student> studentList = (List<Student>)request.getAttribute("studentList");
    int currentPage =  (Integer)request.getAttribute("currentPage"); //当前页
    int totalPage =   (Integer)request.getAttribute("totalPage");  //一共多少页
    int recordNumber =   (Integer)request.getAttribute("recordNumber");  //一共多少记录
    Contest contestObj = (Contest)request.getAttribute("contestObj");
    Student studentObj = (Student)request.getAttribute("studentObj");
    String contentRound = (String)request.getAttribute("contentRound"); //比赛轮次查询关键字
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
<title>比赛成绩查询</title>
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
			    	<li role="presentation" class="active"><a href="#scoreListPanel" aria-controls="scoreListPanel" role="tab" data-toggle="tab">比赛成绩列表</a></li>
			    	<li role="presentation" ><a href="<%=basePath %>Score/score_frontAdd.jsp" style="display:none;">添加比赛成绩</a></li>
				</ul>
			  	<!-- Tab panes -->
			  	<div class="tab-content">
				    <div role="tabpanel" class="tab-pane active" id="scoreListPanel">
				    		<div class="row">
				    			<div class="col-md-12 top5">
				    				<div class="table-responsive">
				    				<table class="table table-condensed table-hover">
				    					<tr class="success bold"><td>序号</td><td>成绩id</td><td>比赛名称</td><td>学生</td><td>比赛轮次</td><td>比赛积分</td><td>操作</td></tr>
				    					<% 
				    						/*计算起始序号*/
				    	            		int startIndex = (currentPage -1) * 5;
				    	            		/*遍历记录*/
				    	            		for(int i=0;i<scoreList.size();i++) {
					    	            		int currentIndex = startIndex + i + 1; //当前记录的序号
					    	            		Score score = scoreList.get(i); //获取到比赛成绩对象
 										%>
 										<tr>
 											<td><%=currentIndex %></td>
 											<td><%=score.getScoreId() %></td>
 											<td><%=score.getContestObj().getContestName() %></td>
 											<td><%=score.getStudentObj().getName() %></td>
 											<td><%=score.getContentRound() %></td>
 											<td><%=score.getScoreValue() %></td>
 											<td>
 												<a href="<%=basePath  %>Score/<%=score.getScoreId() %>/frontshow"><i class="fa fa-info"></i>&nbsp;查看</a>&nbsp;
 												<a href="#" onclick="scoreEdit('<%=score.getScoreId() %>');" style="display:none;"><i class="fa fa-pencil fa-fw"></i>编辑</a>&nbsp;
 												<a href="#" onclick="scoreDelete('<%=score.getScoreId() %>');" style="display:none;"><i class="fa fa-trash-o fa-fw"></i>删除</a>
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
    		<h1>比赛成绩查询</h1>
		</div>
		<form name="scoreQueryForm" id="scoreQueryForm" action="<%=basePath %>Score/frontlist" class="mar_t15">
            <div class="form-group">
            	<label for="contestObj_contestId">比赛名称：</label>
                <select id="contestObj_contestId" name="contestObj.contestId" class="form-control">
                	<option value="0">不限制</option>
	 				<%
	 				for(Contest contestTemp:contestList) {
	 					String selected = "";
 					if(contestObj!=null && contestObj.getContestId()!=null && contestObj.getContestId().intValue()==contestTemp.getContestId().intValue())
 						selected = "selected";
	 				%>
 				 <option value="<%=contestTemp.getContestId() %>" <%=selected %>><%=contestTemp.getContestName() %></option>
	 				<%
	 				}
	 				%>
 			</select>
            </div>
            <div class="form-group">
            	<label for="studentObj_user_name">学生：</label>
                <select id="studentObj_user_name" name="studentObj.user_name" class="form-control">
                	<option value="">不限制</option>
	 				<%
	 				for(Student studentTemp:studentList) {
	 					String selected = "";
 					if(studentObj!=null && studentObj.getUser_name()!=null && studentObj.getUser_name().equals(studentTemp.getUser_name()))
 						selected = "selected";
	 				%>
 				 <option value="<%=studentTemp.getUser_name() %>" <%=selected %>><%=studentTemp.getName() %></option>
	 				<%
	 				}
	 				%>
 			</select>
            </div>
			<div class="form-group">
				<label for="contentRound">比赛轮次:</label>
				<input type="text" id="contentRound" name="contentRound" value="<%=contentRound %>" class="form-control" placeholder="请输入比赛轮次">
			</div>






            <input type=hidden name=currentPage value="<%=currentPage %>" />
            <button type="submit" class="btn btn-primary">查询</button>
        </form>
	</div>

		</div>
	</div> 
<div id="scoreEditDialog" class="modal fade" tabindex="-1" role="dialog">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title"><i class="fa fa-edit"></i>&nbsp;比赛成绩信息编辑</h4>
      </div>
      <div class="modal-body" style="height:450px; overflow: scroll;">
      	<form class="form-horizontal" name="scoreEditForm" id="scoreEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="score_scoreId_edit" class="col-md-3 text-right">成绩id:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="score_scoreId_edit" name="score.scoreId" class="form-control" placeholder="请输入成绩id" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="score_contestObj_contestId_edit" class="col-md-3 text-right">比赛名称:</label>
		  	 <div class="col-md-9">
			    <select id="score_contestObj_contestId_edit" name="score.contestObj.contestId" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="score_studentObj_user_name_edit" class="col-md-3 text-right">学生:</label>
		  	 <div class="col-md-9">
			    <select id="score_studentObj_user_name_edit" name="score.studentObj.user_name" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="score_contentRound_edit" class="col-md-3 text-right">比赛轮次:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="score_contentRound_edit" name="score.contentRound" class="form-control" placeholder="请输入比赛轮次">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="score_scoreValue_edit" class="col-md-3 text-right">比赛积分:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="score_scoreValue_edit" name="score.scoreValue" class="form-control" placeholder="请输入比赛积分">
			 </div>
		  </div>
		</form> 
	    <style>#scoreEditForm .form-group {margin-bottom:5px;}  </style>
      </div>
      <div class="modal-footer"> 
      	<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
      	<button type="button" class="btn btn-primary" onclick="ajaxScoreModify();">提交</button>
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
<script>
var basePath = "<%=basePath%>";
/*跳转到查询结果的某页*/
function GoToPage(currentPage,totalPage) {
    if(currentPage==0) return;
    if(currentPage>totalPage) return;
    document.scoreQueryForm.currentPage.value = currentPage;
    document.scoreQueryForm.submit();
}

/*可以直接跳转到某页*/
function changepage(totalPage)
{
    var pageValue=document.scoreQueryForm.pageValue.value;
    if(pageValue>totalPage) {
        alert('你输入的页码超出了总页数!');
        return ;
    }
    document.scoreQueryForm.currentPage.value = pageValue;
    documentscoreQueryForm.submit();
}

/*弹出修改比赛成绩界面并初始化数据*/
function scoreEdit(scoreId) {
	$.ajax({
		url :  basePath + "Score/" + scoreId + "/update",
		type : "get",
		dataType: "json",
		success : function (score, response, status) {
			if (score) {
				$("#score_scoreId_edit").val(score.scoreId);
				$.ajax({
					url: basePath + "Contest/listAll",
					type: "get",
					success: function(contests,response,status) { 
						$("#score_contestObj_contestId_edit").empty();
						var html="";
		        		$(contests).each(function(i,contest){
		        			html += "<option value='" + contest.contestId + "'>" + contest.contestName + "</option>";
		        		});
		        		$("#score_contestObj_contestId_edit").html(html);
		        		$("#score_contestObj_contestId_edit").val(score.contestObjPri);
					}
				});
				$.ajax({
					url: basePath + "Student/listAll",
					type: "get",
					success: function(students,response,status) { 
						$("#score_studentObj_user_name_edit").empty();
						var html="";
		        		$(students).each(function(i,student){
		        			html += "<option value='" + student.user_name + "'>" + student.name + "</option>";
		        		});
		        		$("#score_studentObj_user_name_edit").html(html);
		        		$("#score_studentObj_user_name_edit").val(score.studentObjPri);
					}
				});
				$("#score_contentRound_edit").val(score.contentRound);
				$("#score_scoreValue_edit").val(score.scoreValue);
				$('#scoreEditDialog').modal('show');
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*删除比赛成绩信息*/
function scoreDelete(scoreId) {
	if(confirm("确认删除这个记录")) {
		$.ajax({
			type : "POST",
			url : basePath + "Score/deletes",
			data : {
				scoreIds : scoreId,
			},
			success : function (obj) {
				if (obj.success) {
					alert("删除成功");
					$("#scoreQueryForm").submit();
					//location.href= basePath + "Score/frontlist";
				}
				else 
					alert(obj.message);
			},
		});
	}
}

/*ajax方式提交比赛成绩信息表单给服务器端修改*/
function ajaxScoreModify() {
	$.ajax({
		url :  basePath + "Score/" + $("#score_scoreId_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#scoreEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                $("#scoreQueryForm").submit();
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

})
</script>
</body>
</html>

