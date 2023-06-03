package com.chengxusheji.mapper;

import java.util.ArrayList;
import org.apache.ibatis.annotations.Param;
import com.chengxusheji.po.TikuType;

public interface TikuTypeMapper {
	/*添加题库类别信息*/
	public void addTikuType(TikuType tikuType) throws Exception;

	/*按照查询条件分页查询题库类别记录*/
	public ArrayList<TikuType> queryTikuType(@Param("where") String where,@Param("startIndex") int startIndex,@Param("pageSize") int pageSize) throws Exception;

	/*按照查询条件查询所有题库类别记录*/
	public ArrayList<TikuType> queryTikuTypeList(@Param("where") String where) throws Exception;

	/*按照查询条件的题库类别记录数*/
	public int queryTikuTypeCount(@Param("where") String where) throws Exception; 

	/*根据主键查询某条题库类别记录*/
	public TikuType getTikuType(int typeId) throws Exception;

	/*更新题库类别记录*/
	public void updateTikuType(TikuType tikuType) throws Exception;

	/*删除题库类别记录*/
	public void deleteTikuType(int typeId) throws Exception;

}
