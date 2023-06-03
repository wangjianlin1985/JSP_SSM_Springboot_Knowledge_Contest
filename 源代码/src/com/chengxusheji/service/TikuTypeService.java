package com.chengxusheji.service;

import java.util.ArrayList;
import javax.annotation.Resource; 
import org.springframework.stereotype.Service;
import com.chengxusheji.po.TikuType;

import com.chengxusheji.mapper.TikuTypeMapper;
@Service
public class TikuTypeService {

	@Resource TikuTypeMapper tikuTypeMapper;
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

    /*添加题库类别记录*/
    public void addTikuType(TikuType tikuType) throws Exception {
    	tikuTypeMapper.addTikuType(tikuType);
    }

    /*按照查询条件分页查询题库类别记录*/
    public ArrayList<TikuType> queryTikuType(int currentPage) throws Exception { 
     	String where = "where 1=1";
    	int startIndex = (currentPage-1) * this.rows;
    	return tikuTypeMapper.queryTikuType(where, startIndex, this.rows);
    }

    /*按照查询条件查询所有记录*/
    public ArrayList<TikuType> queryTikuType() throws Exception  { 
     	String where = "where 1=1";
    	return tikuTypeMapper.queryTikuTypeList(where);
    }

    /*查询所有题库类别记录*/
    public ArrayList<TikuType> queryAllTikuType()  throws Exception {
        return tikuTypeMapper.queryTikuTypeList("where 1=1");
    }

    /*当前查询条件下计算总的页数和记录数*/
    public void queryTotalPageAndRecordNumber() throws Exception {
     	String where = "where 1=1";
        recordNumber = tikuTypeMapper.queryTikuTypeCount(where);
        int mod = recordNumber % this.rows;
        totalPage = recordNumber / this.rows;
        if(mod != 0) totalPage++;
    }

    /*根据主键获取题库类别记录*/
    public TikuType getTikuType(int typeId) throws Exception  {
        TikuType tikuType = tikuTypeMapper.getTikuType(typeId);
        return tikuType;
    }

    /*更新题库类别记录*/
    public void updateTikuType(TikuType tikuType) throws Exception {
        tikuTypeMapper.updateTikuType(tikuType);
    }

    /*删除一条题库类别记录*/
    public void deleteTikuType (int typeId) throws Exception {
        tikuTypeMapper.deleteTikuType(typeId);
    }

    /*删除多条题库类别信息*/
    public int deleteTikuTypes (String typeIds) throws Exception {
    	String _typeIds[] = typeIds.split(",");
    	for(String _typeId: _typeIds) {
    		tikuTypeMapper.deleteTikuType(Integer.parseInt(_typeId));
    	}
    	return _typeIds.length;
    }
}
