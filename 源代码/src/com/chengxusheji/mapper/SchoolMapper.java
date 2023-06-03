package com.chengxusheji.mapper;

import java.util.ArrayList;
import org.apache.ibatis.annotations.Param;
import com.chengxusheji.po.School;

public interface SchoolMapper {
	/*添加学校信息*/
	public void addSchool(School school) throws Exception;

	/*按照查询条件分页查询学校记录*/
	public ArrayList<School> querySchool(@Param("where") String where,@Param("startIndex") int startIndex,@Param("pageSize") int pageSize) throws Exception;

	/*按照查询条件查询所有学校记录*/
	public ArrayList<School> querySchoolList(@Param("where") String where) throws Exception;

	/*按照查询条件的学校记录数*/
	public int querySchoolCount(@Param("where") String where) throws Exception; 

	/*根据主键查询某条学校记录*/
	public School getSchool(int schoolId) throws Exception;

	/*更新学校记录*/
	public void updateSchool(School school) throws Exception;

	/*删除学校记录*/
	public void deleteSchool(int schoolId) throws Exception;

}
