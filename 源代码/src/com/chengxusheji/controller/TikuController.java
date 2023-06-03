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
import com.chengxusheji.service.TikuService;
import com.chengxusheji.po.Tiku;
import com.chengxusheji.service.TikuTypeService;
import com.chengxusheji.po.TikuType;

//Tiku管理控制层
@Controller
@RequestMapping("/Tiku")
public class TikuController extends BaseController {

    /*业务层对象*/
    @Resource TikuService tikuService;

    @Resource TikuTypeService tikuTypeService;
	@InitBinder("tikuTypeObj")
	public void initBindertikuTypeObj(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("tikuTypeObj.");
	}
	@InitBinder("tiku")
	public void initBinderTiku(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("tiku.");
	}
	/*跳转到添加Tiku视图*/
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String add(Model model,HttpServletRequest request) throws Exception {
		model.addAttribute(new Tiku());
		/*查询所有的TikuType信息*/
		List<TikuType> tikuTypeList = tikuTypeService.queryAllTikuType();
		request.setAttribute("tikuTypeList", tikuTypeList);
		return "Tiku_add";
	}

	/*客户端ajax方式提交添加题库测试信息*/
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public void add(@Validated Tiku tiku, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
		boolean success = false;
		if (br.hasErrors()) {
			message = "输入信息不符合要求！";
			writeJsonResponse(response, success, message);
			return ;
		}
        tikuService.addTiku(tiku);
        message = "题库测试添加成功!";
        success = true;
        writeJsonResponse(response, success, message);
	}
	/*ajax方式按照查询条件分页查询题库测试信息*/
	@RequestMapping(value = { "/list" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void list(@ModelAttribute("tikuTypeObj") TikuType tikuTypeObj,String tikuName,String addTime,Integer page,Integer rows, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		if (page==null || page == 0) page = 1;
		if (tikuName == null) tikuName = "";
		if (addTime == null) addTime = "";
		if(rows != 0)tikuService.setRows(rows);
		List<Tiku> tikuList = tikuService.queryTiku(tikuTypeObj, tikuName, addTime, page);
	    /*计算总的页数和总的记录数*/
	    tikuService.queryTotalPageAndRecordNumber(tikuTypeObj, tikuName, addTime);
	    /*获取到总的页码数目*/
	    int totalPage = tikuService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = tikuService.getRecordNumber();
        response.setContentType("text/json;charset=UTF-8");
		PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象
		JSONObject jsonObj=new JSONObject();
		jsonObj.accumulate("total", recordNumber);
		JSONArray jsonArray = new JSONArray();
		for(Tiku tiku:tikuList) {
			JSONObject jsonTiku = tiku.getJsonObject();
			jsonArray.put(jsonTiku);
		}
		jsonObj.accumulate("rows", jsonArray);
		out.println(jsonObj.toString());
		out.flush();
		out.close();
	}

	/*ajax方式按照查询条件分页查询题库测试信息*/
	@RequestMapping(value = { "/listAll" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void listAll(HttpServletResponse response) throws Exception {
		List<Tiku> tikuList = tikuService.queryAllTiku();
        response.setContentType("text/json;charset=UTF-8"); 
		PrintWriter out = response.getWriter();
		JSONArray jsonArray = new JSONArray();
		for(Tiku tiku:tikuList) {
			JSONObject jsonTiku = new JSONObject();
			jsonTiku.accumulate("tikuId", tiku.getTikuId());
			jsonTiku.accumulate("tikuName", tiku.getTikuName());
			jsonArray.put(jsonTiku);
		}
		out.println(jsonArray.toString());
		out.flush();
		out.close();
	}

	/*前台按照查询条件分页查询题库测试信息*/
	@RequestMapping(value = { "/frontlist" }, method = {RequestMethod.GET,RequestMethod.POST})
	public String frontlist(@ModelAttribute("tikuTypeObj") TikuType tikuTypeObj,String tikuName,String addTime,Integer currentPage, Model model, HttpServletRequest request) throws Exception  {
		if (currentPage==null || currentPage == 0) currentPage = 1;
		if (tikuName == null) tikuName = "";
		if (addTime == null) addTime = "";
		List<Tiku> tikuList = tikuService.queryTiku(tikuTypeObj, tikuName, addTime, currentPage);
	    /*计算总的页数和总的记录数*/
	    tikuService.queryTotalPageAndRecordNumber(tikuTypeObj, tikuName, addTime);
	    /*获取到总的页码数目*/
	    int totalPage = tikuService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = tikuService.getRecordNumber();
	    request.setAttribute("tikuList",  tikuList);
	    request.setAttribute("totalPage", totalPage);
	    request.setAttribute("recordNumber", recordNumber);
	    request.setAttribute("currentPage", currentPage);
	    request.setAttribute("tikuTypeObj", tikuTypeObj);
	    request.setAttribute("tikuName", tikuName);
	    request.setAttribute("addTime", addTime);
	    List<TikuType> tikuTypeList = tikuTypeService.queryAllTikuType();
	    request.setAttribute("tikuTypeList", tikuTypeList);
		return "Tiku/tiku_frontquery_result"; 
	}

     /*前台查询Tiku信息*/
	@RequestMapping(value="/{tikuId}/frontshow",method=RequestMethod.GET)
	public String frontshow(@PathVariable Integer tikuId,Model model,HttpServletRequest request) throws Exception {
		/*根据主键tikuId获取Tiku对象*/
        Tiku tiku = tikuService.getTiku(tikuId);
        
        tiku.setHitNum(tiku.getHitNum() + 1);
        tikuService.updateTiku(tiku);

        List<TikuType> tikuTypeList = tikuTypeService.queryAllTikuType();
        request.setAttribute("tikuTypeList", tikuTypeList);
        request.setAttribute("tiku",  tiku);
        return "Tiku/tiku_frontshow";
	}

	/*ajax方式显示题库测试修改jsp视图页*/
	@RequestMapping(value="/{tikuId}/update",method=RequestMethod.GET)
	public void update(@PathVariable Integer tikuId,Model model,HttpServletRequest request,HttpServletResponse response) throws Exception {
        /*根据主键tikuId获取Tiku对象*/
        Tiku tiku = tikuService.getTiku(tikuId);

        response.setContentType("text/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象 
		JSONObject jsonTiku = tiku.getJsonObject();
		out.println(jsonTiku.toString());
		out.flush();
		out.close();
	}

	/*ajax方式更新题库测试信息*/
	@RequestMapping(value = "/{tikuId}/update", method = RequestMethod.POST)
	public void update(@Validated Tiku tiku, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
    	boolean success = false;
		if (br.hasErrors()) { 
			message = "输入的信息有错误！";
			writeJsonResponse(response, success, message);
			return;
		}
		try {
			tikuService.updateTiku(tiku);
			message = "题库测试更新成功!";
			success = true;
			writeJsonResponse(response, success, message);
		} catch (Exception e) {
			e.printStackTrace();
			message = "题库测试更新失败!";
			writeJsonResponse(response, success, message); 
		}
	}
    /*删除题库测试信息*/
	@RequestMapping(value="/{tikuId}/delete",method=RequestMethod.GET)
	public String delete(@PathVariable Integer tikuId,HttpServletRequest request) throws UnsupportedEncodingException {
		  try {
			  tikuService.deleteTiku(tikuId);
	            request.setAttribute("message", "题库测试删除成功!");
	            return "message";
	        } catch (Exception e) { 
	            e.printStackTrace();
	            request.setAttribute("error", "题库测试删除失败!");
				return "error";

	        }

	}

	/*ajax方式删除多条题库测试记录*/
	@RequestMapping(value="/deletes",method=RequestMethod.POST)
	public void delete(String tikuIds,HttpServletRequest request,HttpServletResponse response) throws IOException, JSONException {
		String message = "";
    	boolean success = false;
        try { 
        	int count = tikuService.deleteTikus(tikuIds);
        	success = true;
        	message = count + "条记录删除成功";
        	writeJsonResponse(response, success, message);
        } catch (Exception e) { 
            //e.printStackTrace();
            message = "有记录存在外键约束,删除失败";
            writeJsonResponse(response, success, message);
        }
	}

	/*按照查询条件导出题库测试信息到Excel*/
	@RequestMapping(value = { "/OutToExcel" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void OutToExcel(@ModelAttribute("tikuTypeObj") TikuType tikuTypeObj,String tikuName,String addTime, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
        if(tikuName == null) tikuName = "";
        if(addTime == null) addTime = "";
        List<Tiku> tikuList = tikuService.queryTiku(tikuTypeObj,tikuName,addTime);
        ExportExcelUtil ex = new ExportExcelUtil();
        String _title = "Tiku信息记录"; 
        String[] headers = { "题库id","题库分类","题库名称","点击率","发布时间"};
        List<String[]> dataset = new ArrayList<String[]>(); 
        for(int i=0;i<tikuList.size();i++) {
        	Tiku tiku = tikuList.get(i); 
        	dataset.add(new String[]{tiku.getTikuId() + "",tiku.getTikuTypeObj().getTikuTypeName(),tiku.getTikuName(),tiku.getHitNum() + "",tiku.getAddTime()});
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
			response.setHeader("Content-disposition","attachment; filename="+"Tiku.xls");//filename是下载的xls的名，建议最好用英文 
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
