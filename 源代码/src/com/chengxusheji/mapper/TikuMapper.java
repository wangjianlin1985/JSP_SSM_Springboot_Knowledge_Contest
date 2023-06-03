package com.chengxusheji.mapper;

import java.util.ArrayList;
import org.apache.ibatis.annotations.Param;
import com.chengxusheji.po.Tiku;

public interface TikuMapper {
	/*添加题库测试信息*/
	public void addTiku(Tiku tiku) throws Exception;

	/*按照查询条件分页查询题库测试记录*/
	public ArrayList<Tiku> queryTiku(@Param("where") String where,@Param("startIndex") int startIndex,@Param("pageSize") int pageSize) throws Exception;

	/*按照查询条件查询所有题库测试记录*/
	public ArrayList<Tiku> queryTikuList(@Param("where") String where) throws Exception;

	/*按照查询条件的题库测试记录数*/
	public int queryTikuCount(@Param("where") String where) throws Exception; 

	/*根据主键查询某条题库测试记录*/
	public Tiku getTiku(int tikuId) throws Exception;

	/*更新题库测试记录*/
	public void updateTiku(Tiku tiku) throws Exception;

	/*删除题库测试记录*/
	public void deleteTiku(int tikuId) throws Exception;

}
