package com.chengxusheji.controller;

import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import com.chengxusheji.utils.ExportExcelUtil;
import com.chengxusheji.utils.UserException;
import com.chengxusheji.service.ContestService;
import com.chengxusheji.service.StudentService;
import com.chengxusheji.po.Contest;
import com.chengxusheji.po.Student;
import com.chengxusheji.service.ProjectService;
import com.chengxusheji.po.Project;
import com.chengxusheji.service.SchoolService;
import com.chengxusheji.po.School;

//Contest管理控制层
@Controller
@RequestMapping("/Contest")
public class ContestController extends BaseController {

    /*业务层对象*/
    @Resource ContestService contestService;
    @Resource StudentService studentService;

    @Resource ProjectService projectService;
    @Resource SchoolService schoolService;
	@InitBinder("schoolObj")
	public void initBinderschoolObj(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("schoolObj.");
	}
	@InitBinder("projectObj")
	public void initBinderprojectObj(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("projectObj.");
	}
	@InitBinder("contest")
	public void initBinderContest(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("contest.");
	}
	/*跳转到添加Contest视图*/
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String add(Model model,HttpServletRequest request) throws Exception {
		model.addAttribute(new Contest());
		/*查询所有的Project信息*/
		List<Project> projectList = projectService.queryAllProject();
		request.setAttribute("projectList", projectList);
		/*查询所有的School信息*/
		List<School> schoolList = schoolService.queryAllSchool();
		request.setAttribute("schoolList", schoolList);
		return "Contest_add";
	}

	/*客户端ajax方式提交添加比赛信息*/
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public void add(@Validated Contest contest, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
		boolean success = false;
		if (br.hasErrors()) {
			message = "输入信息不符合要求！";
			writeJsonResponse(response, success, message);
			return ;
		}
		  
        contestService.addContest(contest);
        message = "比赛添加成功!";
        success = true;
        writeJsonResponse(response, success, message);
	}
	/*ajax方式按照查询条件分页查询比赛信息*/
	@RequestMapping(value = { "/list" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void list(@ModelAttribute("schoolObj") School schoolObj,@ModelAttribute("projectObj") Project projectObj,String contestName,String signUpTime,Integer page,Integer rows, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		if (page==null || page == 0) page = 1;
		if (contestName == null) contestName = "";
		if (signUpTime == null) signUpTime = "";
		if(rows != 0)contestService.setRows(rows);
		List<Contest> contestList = contestService.queryContest(schoolObj, projectObj, contestName, signUpTime, page);
	    /*计算总的页数和总的记录数*/
	    contestService.queryTotalPageAndRecordNumber(schoolObj, projectObj, contestName, signUpTime);
	    /*获取到总的页码数目*/
	    int totalPage = contestService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = contestService.getRecordNumber();
        response.setContentType("text/json;charset=UTF-8");
		PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象
		JSONObject jsonObj=new JSONObject();
		jsonObj.accumulate("total", recordNumber);
		JSONArray jsonArray = new JSONArray();
		for(Contest contest:contestList) {
			JSONObject jsonContest = contest.getJsonObject();
			jsonArray.put(jsonContest);
		}
		jsonObj.accumulate("rows", jsonArray);
		out.println(jsonObj.toString());
		out.flush();
		out.close();
	}

	/*ajax方式按照查询条件分页查询比赛信息*/
	@RequestMapping(value = { "/listAll" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void listAll(HttpServletResponse response) throws Exception {
		List<Contest> contestList = contestService.queryAllContest();
        response.setContentType("text/json;charset=UTF-8"); 
		PrintWriter out = response.getWriter();
		JSONArray jsonArray = new JSONArray();
		for(Contest contest:contestList) {
			JSONObject jsonContest = new JSONObject();
			jsonContest.accumulate("contestId", contest.getContestId());
			jsonContest.accumulate("contestName", contest.getContestName());
			jsonArray.put(jsonContest);
		}
		out.println(jsonArray.toString());
		out.flush();
		out.close();
	}

	/*前台按照查询条件分页查询比赛信息*/
	@RequestMapping(value = { "/frontlist" }, method = {RequestMethod.GET,RequestMethod.POST})
	public String frontlist(@ModelAttribute("schoolObj") School schoolObj,@ModelAttribute("projectObj") Project projectObj,String contestName,String signUpTime,Integer currentPage, Model model, HttpServletRequest request) throws Exception  {
		if (currentPage==null || currentPage == 0) currentPage = 1;
		if (contestName == null) contestName = "";
		if (signUpTime == null) signUpTime = "";
		List<Contest> contestList = contestService.queryContest(schoolObj, projectObj, contestName, signUpTime, currentPage);
	    /*计算总的页数和总的记录数*/
	    contestService.queryTotalPageAndRecordNumber(schoolObj, projectObj, contestName, signUpTime);
	    /*获取到总的页码数目*/
	    int totalPage = contestService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = contestService.getRecordNumber();
	    request.setAttribute("contestList",  contestList);
	    request.setAttribute("totalPage", totalPage);
	    request.setAttribute("recordNumber", recordNumber);
	    request.setAttribute("currentPage", currentPage);
	    request.setAttribute("schoolObj", schoolObj);
	    request.setAttribute("projectObj", projectObj);
	    request.setAttribute("contestName", contestName);
	    request.setAttribute("signUpTime", signUpTime);
	    List<Project> projectList = projectService.queryAllProject();
	    request.setAttribute("projectList", projectList);
	    List<School> schoolList = schoolService.queryAllSchool();
	    request.setAttribute("schoolList", schoolList);
		return "Contest/contest_frontquery_result"; 
	}
	
	
	/*学生前台按照查询条件分页查询比赛信息*/
	@RequestMapping(value = { "/userFrontlist" }, method = {RequestMethod.GET,RequestMethod.POST})
	public String userFrontlist(@ModelAttribute("schoolObj") School schoolObj,@ModelAttribute("projectObj") Project projectObj,String contestName,String signUpTime,Integer currentPage, Model model, HttpServletRequest request,HttpSession session) throws Exception  {
		if (currentPage==null || currentPage == 0) currentPage = 1;
		if (contestName == null) contestName = "";
		if (signUpTime == null) signUpTime = "";
		
		String user_name = session.getAttribute("user_name").toString();
		
		List<Contest> contestList = contestService.userQueryContest(user_name,schoolObj, projectObj, contestName, signUpTime, currentPage);
	    /*计算总的页数和总的记录数*/
	    contestService.userQueryTotalPageAndRecordNumber(user_name,schoolObj, projectObj, contestName, signUpTime);
	    /*获取到总的页码数目*/
	    int totalPage = contestService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = contestService.getRecordNumber();
	    request.setAttribute("contestList",  contestList);
	    request.setAttribute("totalPage", totalPage);
	    request.setAttribute("recordNumber", recordNumber);
	    request.setAttribute("currentPage", currentPage);
	    request.setAttribute("schoolObj", schoolObj);
	    request.setAttribute("projectObj", projectObj);
	    request.setAttribute("contestName", contestName);
	    request.setAttribute("signUpTime", signUpTime);
	    List<Project> projectList = projectService.queryAllProject();
	    request.setAttribute("projectList", projectList);
	    List<School> schoolList = schoolService.queryAllSchool();
	    request.setAttribute("schoolList", schoolList);
		return "Contest/contest_frontStudentquery_result"; 
	}
	
	

     /*前台查询Contest信息*/
	@RequestMapping(value="/{contestId}/frontshow",method=RequestMethod.GET)
	public String frontshow(@PathVariable Integer contestId,Model model,HttpServletRequest request) throws Exception {
		/*根据主键contestId获取Contest对象*/
        Contest contest = contestService.getContest(contestId);
        ArrayList<Student> studentList = studentService.queryStudent("", contest, "", "","");
        List<Project> projectList = projectService.queryAllProject();
        request.setAttribute("projectList", projectList);
        List<School> schoolList = schoolService.queryAllSchool();
        request.setAttribute("schoolList", schoolList);
        request.setAttribute("contest",  contest);
        request.setAttribute("studentList", studentList);
        return "Contest/contest_frontshow";
	}

	/*ajax方式显示比赛修改jsp视图页*/
	@RequestMapping(value="/{contestId}/update",method=RequestMethod.GET)
	public void update(@PathVariable Integer contestId,Model model,HttpServletRequest request,HttpServletResponse response) throws Exception {
        /*根据主键contestId获取Contest对象*/
        Contest contest = contestService.getContest(contestId);

        response.setContentType("text/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象 
		JSONObject jsonContest = contest.getJsonObject();
		out.println(jsonContest.toString());
		out.flush();
		out.close();
	}

	/*ajax方式更新比赛信息*/
	@RequestMapping(value = "/{contestId}/update", method = RequestMethod.POST)
	public void update(@Validated Contest contest, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
    	boolean success = false;
		if (br.hasErrors()) { 
			message = "输入的信息有错误！";
			writeJsonResponse(response, success, message);
			return;
		}
		try {
			contestService.updateContest(contest);
			message = "比赛更新成功!";
			success = true;
			writeJsonResponse(response, success, message);
		} catch (Exception e) {
			e.printStackTrace();
			message = "比赛更新失败!";
			writeJsonResponse(response, success, message); 
		}
	}
    /*删除比赛信息*/
	@RequestMapping(value="/{contestId}/delete",method=RequestMethod.GET)
	public String delete(@PathVariable Integer contestId,HttpServletRequest request) throws UnsupportedEncodingException {
		  try {
			  contestService.deleteContest(contestId);
	            request.setAttribute("message", "比赛删除成功!");
	            return "message";
	        } catch (Exception e) { 
	            e.printStackTrace();
	            request.setAttribute("error", "比赛删除失败!");
				return "error";

	        }

	}

	/*ajax方式删除多条比赛记录*/
	@RequestMapping(value="/deletes",method=RequestMethod.POST)
	public void delete(String contestIds,HttpServletRequest request,HttpServletResponse response) throws IOException, JSONException {
		String message = "";
    	boolean success = false;
        try { 
        	int count = contestService.deleteContests(contestIds);
        	success = true;
        	message = count + "条记录删除成功";
        	writeJsonResponse(response, success, message);
        } catch (Exception e) { 
            //e.printStackTrace();
            message = "有记录存在外键约束,删除失败";
            writeJsonResponse(response, success, message);
        }
	}

	/*按照查询条件导出比赛信息到Excel*/
	@RequestMapping(value = { "/OutToExcel" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void OutToExcel(@ModelAttribute("schoolObj") School schoolObj,@ModelAttribute("projectObj") Project projectObj,String contestName,String signUpTime, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
        if(contestName == null) contestName = "";
        if(signUpTime == null) signUpTime = "";
        List<Contest> contestList = contestService.queryContest(schoolObj,projectObj,contestName,signUpTime);
        ExportExcelUtil ex = new ExportExcelUtil();
        String _title = "Contest信息记录"; 
        String[] headers = { "比赛id","举办学校","比赛项目","比赛名称","比赛地点","人数限制","报名时间","截止时间"};
        List<String[]> dataset = new ArrayList<String[]>(); 
        for(int i=0;i<contestList.size();i++) {
        	Contest contest = contestList.get(i); 
        	dataset.add(new String[]{contest.getContestId() + "",contest.getSchoolObj().getSchoolName(),contest.getProjectObj().getProjectName(),contest.getContestName(),contest.getContestPlace(),contest.getPersonNumber() + "",contest.getSignUpTime(),contest.getEndTime()});
        }
        /*
        OutputStream out = null;
		try {
			out = new FileOutputStream("C://output.xls");
			ex.exportExcel(title,headers, dataset, out);
		    out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		*/
		OutputStream out = null;//创建一个输出流对象 
		try { 
			out = response.getOutputStream();//
			response.setHeader("Content-disposition","attachment; filename="+"Contest.xls");//filename是下载的xls的名，建议最好用英文 
			response.setContentType("application/msexcel;charset=UTF-8");//设置类型 
			response.setHeader("Pragma","No-cache");//设置头 
			response.setHeader("Cache-Control","no-cache");//设置头 
			response.setDateHeader("Expires", 0);//设置日期头  
			String rootPath = request.getSession().getServletContext().getRealPath("/");
			ex.exportExcel(rootPath,_title,headers, dataset, out);
			out.flush();
		} catch (IOException e) { 
			e.printStackTrace(); 
		}finally{
			try{
				if(out!=null){ 
					out.close(); 
				}
			}catch(IOException e){ 
				e.printStackTrace(); 
			} 
		}
    }
}
