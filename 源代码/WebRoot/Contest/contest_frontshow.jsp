<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.Contest" %>
<%@ page import="com.chengxusheji.po.Project" %>
<%@ page import="com.chengxusheji.po.School" %>
<%@ page import="com.chengxusheji.po.Student" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    //获取所有的projectObj信息
    List<Project> projectList = (List<Project>)request.getAttribute("projectList");
    //获取所有的schoolObj信息
    List<School> schoolList = (List<School>)request.getAttribute("schoolList");
    Contest contest = (Contest)request.getAttribute("contest");
    List<Student> studentList = (ArrayList<Student>)request.getAttribute("studentList");
%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
  <TITLE>查看比赛详情</TITLE>
  <link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
  <link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
  <link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
  <link href="<%=basePath %>plugins/animate.css" rel="stylesheet"> 
</head>
<body style="margin-top:70px;"> 
<jsp:include page="../header.jsp"></jsp:include>
<div class="container">
	<ul class="breadcrumb">
  		<li><a href="<%=basePath %>index.jsp">首页</a></li>
  		<li><a href="<%=basePath %>Contest/frontlist">比赛信息</a></li>
  		<li class="active">详情查看</li>
	</ul>
	<div class="row bottom15"> 
		<div class="col-md-2 col-xs-4 text-right bold">比赛id:</div>
		<div class="col-md-10 col-xs-6"><%=contest.getContestId()%></div>
	</div>
	<div class="row bottom15"> 
		<div class="col-md-2 col-xs-4 text-right bold">举办学校:</div>
		<div class="col-md-10 col-xs-6"><%=contest.getSchoolObj().getSchoolName() %></div>
	</div>
	<div class="row bottom15"> 
		<div class="col-md-2 col-xs-4 text-right bold">比赛项目:</div>
		<div class="col-md-10 col-xs-6"><%=contest.getProjectObj().getProjectName() %></div>
	</div>
	<div class="row bottom15"> 
		<div class="col-md-2 col-xs-4 text-right bold">比赛名称:</div>
		<div class="col-md-10 col-xs-6"><%=contest.getContestName()%></div>
	</div>
	<div class="row bottom15"> 
		<div class="col-md-2 col-xs-4 text-right bold">比赛介绍:</div>
		<div class="col-md-10 col-xs-6"><%=contest.getContestDesc()%></div>
	</div>
	<div class="row bottom15"> 
		<div class="col-md-2 col-xs-4 text-right bold">比赛地点:</div>
		<div class="col-md-10 col-xs-6"><%=contest.getContestPlace()%></div>
	</div>
	<div class="row bottom15"> 
		<div class="col-md-2 col-xs-4 text-right bold">人数限制:</div>
		<div class="col-md-10 col-xs-6"><%=contest.getPersonNumber()%></div>
	</div>
	<div class="row bottom15"> 
		<div class="col-md-2 col-xs-4 text-right bold">报名时间:</div>
		<div class="col-md-10 col-xs-6"><%=contest.getSignUpTime()%></div>
	</div>
	<div class="row bottom15"> 
		<div class="col-md-2 col-xs-4 text-right bold">截止时间:</div>
		<div class="col-md-10 col-xs-6"><%=contest.getEndTime()%></div>
	</div>
	
	<div class="row bottom15"> 
		<div class="col-md-2 col-xs-4 text-right bold">已有<font color="red"><%=studentList.size() %></font>人报名:</div>
		<div class="col-md-8 col-xs-7">
			<div class="row" style="margin-top: 20px;">
				<div class="col-md-4 col-xs-3  text-center bold">
					报名用户
				</div>
				 
				<div class="col-md-8 col-xs-4 text-center bold">报名时间</div>
			</div>
		
			 
			<% for(Student student: studentList) { %>
			<div class="row" style="margin-top: 20px;">
				<div class="col-md-4 col-xs-3">
					<div class="row text-center"><img src="<%=basePath %><%=student.getUserPhoto() %>" style="border: none;width:60px;height:60px;border-radius: 50%;" /></div>
					<div class="row text-center" style="margin: 5px 0px;"><%=student.getUser_name() %></div>
				</div>
				 
				<div class="col-md-8 col-xs-4 text-center" ><%=student.getSignUpTime() %></div>
			</div>
		
			<% } %> 
		</div>
	</div>
	
	<div class="row bottom15">
		<div class="col-md-2 col-xs-4"></div>
		<div class="col-md-6 col-xs-6">
			<button onclick="history.back();" class="btn btn-primary">返回</button>
		</div>
	</div>
</div> 
<jsp:include page="../footer.jsp"></jsp:include>
<script src="<%=basePath %>plugins/jquery.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap.js"></script>
<script src="<%=basePath %>plugins/wow.min.js"></script>
<script>
var basePath = "<%=basePath%>";
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

