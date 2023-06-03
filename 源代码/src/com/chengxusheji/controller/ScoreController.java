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
import com.chengxusheji.service.ScoreService;
import com.chengxusheji.po.Score;
import com.chengxusheji.service.ContestService;
import com.chengxusheji.po.Contest;
import com.chengxusheji.service.StudentService;
import com.chengxusheji.po.Student;

//Score管理控制层
@Controller
@RequestMapping("/Score")
public class ScoreController extends BaseController {

    /*业务层对象*/
    @Resource ScoreService scoreService;

    @Resource ContestService contestService;
    @Resource StudentService studentService;
	@InitBinder("contestObj")
	public void initBindercontestObj(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("contestObj.");
	}
	@InitBinder("studentObj")
	public void initBinderstudentObj(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("studentObj.");
	}
	@InitBinder("score")
	public void initBinderScore(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("score.");
	}
	/*跳转到添加Score视图*/
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String add(Model model,HttpServletRequest request) throws Exception {
		model.addAttribute(new Score());
		/*查询所有的Contest信息*/
		List<Contest> contestList = contestService.queryAllContest();
		request.setAttribute("contestList", contestList);
		/*查询所有的Student信息*/
		List<Student> studentList = studentService.queryAllStudent();
		request.setAttribute("studentList", studentList);
		return "Score_add";
	}

	/*客户端ajax方式提交添加比赛成绩信息*/
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public void add(@Validated Score score, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
		boolean success = false;
		if (br.hasErrors()) {
			message = "输入信息不符合要求！";
			writeJsonResponse(response, success, message);
			return ;
		}
        scoreService.addScore(score);
        message = "比赛成绩添加成功!";
        success = true;
        writeJsonResponse(response, success, message);
	}
	/*ajax方式按照查询条件分页查询比赛成绩信息*/
	@RequestMapping(value = { "/list" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void list(@ModelAttribute("contestObj") Contest contestObj,@ModelAttribute("studentObj") Student studentObj,String contentRound,Integer page,Integer rows, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		if (page==null || page == 0) page = 1;
		if (contentRound == null) contentRound = "";
		if(rows != 0)scoreService.setRows(rows);
		List<Score> scoreList = scoreService.queryScore(contestObj, studentObj, contentRound, page);
	    /*计算总的页数和总的记录数*/
	    scoreService.queryTotalPageAndRecordNumber(contestObj, studentObj, contentRound);
	    /*获取到总的页码数目*/
	    int totalPage = scoreService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = scoreService.getRecordNumber();
        response.setContentType("text/json;charset=UTF-8");
		PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象
		JSONObject jsonObj=new JSONObject();
		jsonObj.accumulate("total", recordNumber);
		JSONArray jsonArray = new JSONArray();
		for(Score score:scoreList) {
			JSONObject jsonScore = score.getJsonObject();
			jsonArray.put(jsonScore);
		}
		jsonObj.accumulate("rows", jsonArray);
		out.println(jsonObj.toString());
		out.flush();
		out.close();
	}

	/*ajax方式按照查询条件分页查询比赛成绩信息*/
	@RequestMapping(value = { "/listAll" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void listAll(HttpServletResponse response) throws Exception {
		List<Score> scoreList = scoreService.queryAllScore();
        response.setContentType("text/json;charset=UTF-8"); 
		PrintWriter out = response.getWriter();
		JSONArray jsonArray = new JSONArray();
		for(Score score:scoreList) {
			JSONObject jsonScore = new JSONObject();
			jsonScore.accumulate("scoreId", score.getScoreId());
			jsonArray.put(jsonScore);
		}
		out.println(jsonArray.toString());
		out.flush();
		out.close();
	}

	/*前台按照查询条件分页查询比赛成绩信息*/
	@RequestMapping(value = { "/frontlist" }, method = {RequestMethod.GET,RequestMethod.POST})
	public String frontlist(@ModelAttribute("contestObj") Contest contestObj,@ModelAttribute("studentObj") Student studentObj,String contentRound,Integer currentPage, Model model, HttpServletRequest request) throws Exception  {
		if (currentPage==null || currentPage == 0) currentPage = 1;
		if (contentRound == null) contentRound = "";
		List<Score> scoreList = scoreService.queryScore(contestObj, studentObj, contentRound, currentPage);
	    /*计算总的页数和总的记录数*/
	    scoreService.queryTotalPageAndRecordNumber(contestObj, studentObj, contentRound);
	    /*获取到总的页码数目*/
	    int totalPage = scoreService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = scoreService.getRecordNumber();
	    request.setAttribute("scoreList",  scoreList);
	    request.setAttribute("totalPage", totalPage);
	    request.setAttribute("recordNumber", recordNumber);
	    request.setAttribute("currentPage", currentPage);
	    request.setAttribute("contestObj", contestObj);
	    request.setAttribute("studentObj", studentObj);
	    request.setAttribute("contentRound", contentRound);
	    List<Contest> contestList = contestService.queryAllContest();
	    request.setAttribute("contestList", contestList);
	    List<Student> studentList = studentService.queryAllStudent();
	    request.setAttribute("studentList", studentList);
		return "Score/score_frontquery_result"; 
	}
	
	
	/*用户前台按照查询条件分页查询比赛成绩信息*/
	@RequestMapping(value = { "/userFrontlist" }, method = {RequestMethod.GET,RequestMethod.POST})
	public String userFrontlist(@ModelAttribute("contestObj") Contest contestObj,@ModelAttribute("studentObj") Student studentObj,String contentRound,Integer currentPage, Model model, HttpServletRequest request,HttpSession session) throws Exception  {
		if (currentPage==null || currentPage == 0) currentPage = 1;
		if (contentRound == null) contentRound = "";
		String user_name = session.getAttribute("user_name").toString();
		studentObj = new Student();
		studentObj.setUser_name(user_name);
		List<Score> scoreList = scoreService.queryScore(contestObj, studentObj, contentRound, currentPage);
	    /*计算总的页数和总的记录数*/
	    scoreService.queryTotalPageAndRecordNumber(contestObj, studentObj, contentRound);
	    /*获取到总的页码数目*/
	    int totalPage = scoreService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = scoreService.getRecordNumber();
	    request.setAttribute("scoreList",  scoreList);
	    request.setAttribute("totalPage", totalPage);
	    request.setAttribute("recordNumber", recordNumber);
	    request.setAttribute("currentPage", currentPage);
	    request.setAttribute("contestObj", contestObj);
	    request.setAttribute("studentObj", studentObj);
	    request.setAttribute("contentRound", contentRound);
	    List<Contest> contestList = contestService.queryAllContest();
	    request.setAttribute("contestList", contestList);
	    List<Student> studentList = studentService.queryAllStudent();
	    request.setAttribute("studentList", studentList);
		return "Score/score_frontStudentquery_result"; 
	}
	

     /*前台查询Score信息*/
	@RequestMapping(value="/{scoreId}/frontshow",method=RequestMethod.GET)
	public String frontshow(@PathVariable Integer scoreId,Model model,HttpServletRequest request) throws Exception {
		/*根据主键scoreId获取Score对象*/
        Score score = scoreService.getScore(scoreId);

        List<Contest> contestList = contestService.queryAllContest();
        request.setAttribute("contestList", contestList);
        List<Student> studentList = studentService.queryAllStudent();
        request.setAttribute("studentList", studentList);
        request.setAttribute("score",  score);
        return "Score/score_frontshow";
	}

	/*ajax方式显示比赛成绩修改jsp视图页*/
	@RequestMapping(value="/{scoreId}/update",method=RequestMethod.GET)
	public void update(@PathVariable Integer scoreId,Model model,HttpServletRequest request,HttpServletResponse response) throws Exception {
        /*根据主键scoreId获取Score对象*/
        Score score = scoreService.getScore(scoreId);

        response.setContentType("text/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象 
		JSONObject jsonScore = score.getJsonObject();
		out.println(jsonScore.toString());
		out.flush();
		out.close();
	}

	/*ajax方式更新比赛成绩信息*/
	@RequestMapping(value = "/{scoreId}/update", method = RequestMethod.POST)
	public void update(@Validated Score score, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
    	boolean success = false;
		if (br.hasErrors()) { 
			message = "输入的信息有错误！";
			writeJsonResponse(response, success, message);
			return;
		}
		try {
			scoreService.updateScore(score);
			message = "比赛成绩更新成功!";
			success = true;
			writeJsonResponse(response, success, message);
		} catch (Exception e) {
			e.printStackTrace();
			message = "比赛成绩更新失败!";
			writeJsonResponse(response, success, message); 
		}
	}
    /*删除比赛成绩信息*/
	@RequestMapping(value="/{scoreId}/delete",method=RequestMethod.GET)
	public String delete(@PathVariable Integer scoreId,HttpServletRequest request) throws UnsupportedEncodingException {
		  try {
			  scoreService.deleteScore(scoreId);
	            request.setAttribute("message", "比赛成绩删除成功!");
	            return "message";
	        } catch (Exception e) { 
	            e.printStackTrace();
	            request.setAttribute("error", "比赛成绩删除失败!");
				return "error";

	        }

	}

	/*ajax方式删除多条比赛成绩记录*/
	@RequestMapping(value="/deletes",method=RequestMethod.POST)
	public void delete(String scoreIds,HttpServletRequest request,HttpServletResponse response) throws IOException, JSONException {
		String message = "";
    	boolean success = false;
        try { 
        	int count = scoreService.deleteScores(scoreIds);
        	success = true;
        	message = count + "条记录删除成功";
        	writeJsonResponse(response, success, message);
        } catch (Exception e) { 
            //e.printStackTrace();
            message = "有记录存在外键约束,删除失败";
            writeJsonResponse(response, success, message);
        }
	}

	/*按照查询条件导出比赛成绩信息到Excel*/
	@RequestMapping(value = { "/OutToExcel" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void OutToExcel(@ModelAttribute("contestObj") Contest contestObj,@ModelAttribute("studentObj") Student studentObj,String contentRound, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
        if(contentRound == null) contentRound = "";
        List<Score> scoreList = scoreService.queryScore(contestObj,studentObj,contentRound);
        ExportExcelUtil ex = new ExportExcelUtil();
        String _title = "Score信息记录"; 
        String[] headers = { "成绩id","比赛名称","学生","比赛轮次","比赛积分"};
        List<String[]> dataset = new ArrayList<String[]>(); 
        for(int i=0;i<scoreList.size();i++) {
        	Score score = scoreList.get(i); 
        	dataset.add(new String[]{score.getScoreId() + "",score.getContestObj().getContestName(),score.getStudentObj().getName(),score.getContentRound(),score.getScoreValue() + ""});
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
			response.setHeader("Content-disposition","attachment; filename="+"Score.xls");//filename是下载的xls的名，建议最好用英文 
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
