package com.chengxusheji.service;

import java.util.ArrayList;
import javax.annotation.Resource; 
import org.springframework.stereotype.Service;
import com.chengxusheji.po.School;

import com.chengxusheji.mapper.SchoolMapper;
@Service
public class SchoolService {

	@Resource SchoolMapper schoolMapper;
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

    /*添加学校记录*/
    public void addSchool(School school) throws Exception {
    	schoolMapper.addSchool(school);
    }

    /*按照查询条件分页查询学校记录*/
    public ArrayList<School> querySchool(int currentPage) throws Exception { 
     	String where = "where 1=1";
    	int startIndex = (currentPage-1) * this.rows;
    	return schoolMapper.querySchool(where, startIndex, this.rows);
    }

    /*按照查询条件查询所有记录*/
    public ArrayList<School> querySchool() throws Exception  { 
     	String where = "where 1=1";
    	return schoolMapper.querySchoolList(where);
    }

    /*查询所有学校记录*/
    public ArrayList<School> queryAllSchool()  throws Exception {
        return schoolMapper.querySchoolList("where 1=1");
    }

    /*当前查询条件下计算总的页数和记录数*/
    public void queryTotalPageAndRecordNumber() throws Exception {
     	String where = "where 1=1";
        recordNumber = schoolMapper.querySchoolCount(where);
        int mod = recordNumber % this.rows;
        totalPage = recordNumber / this.rows;
        if(mod != 0) totalPage++;
    }

    /*根据主键获取学校记录*/
    public School getSchool(int schoolId) throws Exception  {
        School school = schoolMapper.getSchool(schoolId);
        return school;
    }

    /*更新学校记录*/
    public void updateSchool(School school) throws Exception {
        schoolMapper.updateSchool(school);
    }

    /*删除一条学校记录*/
    public void deleteSchool (int schoolId) throws Exception {
        schoolMapper.deleteSchool(schoolId);
    }

    /*删除多条学校信息*/
    public int deleteSchools (String schoolIds) throws Exception {
    	String _schoolIds[] = schoolIds.split(",");
    	for(String _schoolId: _schoolIds) {
    		schoolMapper.deleteSchool(Integer.parseInt(_schoolId));
    	}
    	return _schoolIds.length;
    }
}
