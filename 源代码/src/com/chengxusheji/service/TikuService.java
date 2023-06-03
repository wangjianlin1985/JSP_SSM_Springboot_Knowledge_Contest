package com.chengxusheji.service;

import java.util.ArrayList;
import javax.annotation.Resource; 
import org.springframework.stereotype.Service;
import com.chengxusheji.po.TikuType;
import com.chengxusheji.po.Tiku;

import com.chengxusheji.mapper.TikuMapper;
@Service
public class TikuService {

	@Resource TikuMapper tikuMapper;
    /*每页显示记录数目*/
    private int rows = 10;;
    public int getRows() {
		return rows;
	}
	public void setRows(int rows) {
		this.rows = rows;
	}

    /*保存查询后总的页数*/
    private int totalPage;
    public void setTotalPage(int totalPage) {
        this.totalPage = totalPage;
    }
    public int getTotalPage() {
        return totalPage;
    }

    /*保存查询到的总记录数*/
    private int recordNumber;
    public void setRecordNumber(int recordNumber) {
        this.recordNumber = recordNumber;
    }
    public int getRecordNumber() {
        return recordNumber;
    }

    /*添加题库测试记录*/
    public void addTiku(Tiku tiku) throws Exception {
    	tikuMapper.addTiku(tiku);
    }

    /*按照查询条件分页查询题库测试记录*/
    public ArrayList<Tiku> queryTiku(TikuType tikuTypeObj,String tikuName,String addTime,int currentPage) throws Exception { 
     	String where = "where 1=1";
    	if(null != tikuTypeObj && tikuTypeObj.getTypeId()!= null && tikuTypeObj.getTypeId()!= 0)  where += " and t_tiku.tikuTypeObj=" + tikuTypeObj.getTypeId();
    	if(!tikuName.equals("")) where = where + " and t_tiku.tikuName like '%" + tikuName + "%'";
    	if(!addTime.equals("")) where = where + " and t_tiku.addTime like '%" + addTime + "%'";
    	int startIndex = (currentPage-1) * this.rows;
    	return tikuMapper.queryTiku(where, startIndex, this.rows);
    }

    /*按照查询条件查询所有记录*/
    public ArrayList<Tiku> queryTiku(TikuType tikuTypeObj,String tikuName,String addTime) throws Exception  { 
     	String where = "where 1=1";
    	if(null != tikuTypeObj && tikuTypeObj.getTypeId()!= null && tikuTypeObj.getTypeId()!= 0)  where += " and t_tiku.tikuTypeObj=" + tikuTypeObj.getTypeId();
    	if(!tikuName.equals("")) where = where + " and t_tiku.tikuName like '%" + tikuName + "%'";
    	if(!addTime.equals("")) where = where + " and t_tiku.addTime like '%" + addTime + "%'";
    	return tikuMapper.queryTikuList(where);
    }

    /*查询所有题库测试记录*/
    public ArrayList<Tiku> queryAllTiku()  throws Exception {
        return tikuMapper.queryTikuList("where 1=1");
    }

    /*当前查询条件下计算总的页数和记录数*/
    public void queryTotalPageAndRecordNumber(TikuType tikuTypeObj,String tikuName,String addTime) throws Exception {
     	String where = "where 1=1";
    	if(null != tikuTypeObj && tikuTypeObj.getTypeId()!= null && tikuTypeObj.getTypeId()!= 0)  where += " and t_tiku.tikuTypeObj=" + tikuTypeObj.getTypeId();
    	if(!tikuName.equals("")) where = where + " and t_tiku.tikuName like '%" + tikuName + "%'";
    	if(!addTime.equals("")) where = where + " and t_tiku.addTime like '%" + addTime + "%'";
        recordNumber = tikuMapper.queryTikuCount(where);
        int mod = recordNumber % this.rows;
        totalPage = recordNumber / this.rows;
        if(mod != 0) totalPage++;
    }

    /*根据主键获取题库测试记录*/
    public Tiku getTiku(int tikuId) throws Exception  {
        Tiku tiku = tikuMapper.getTiku(tikuId);
        return tiku;
    }

    /*更新题库测试记录*/
    public void updateTiku(Tiku tiku) throws Exception {
        tikuMapper.updateTiku(tiku);
    }

    /*删除一条题库测试记录*/
    public void deleteTiku (int tikuId) throws Exception {
        tikuMapper.deleteTiku(tikuId);
    }

    /*删除多条题库测试信息*/
    public int deleteTikus (String tikuIds) throws Exception {
    	String _tikuIds[] = tikuIds.split(",");
    	for(String _tikuId: _tikuIds) {
    		tikuMapper.deleteTiku(Integer.parseInt(_tikuId));
    	}
    	return _tikuIds.length;
    }
}
