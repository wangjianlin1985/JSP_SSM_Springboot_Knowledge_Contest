package com.chengxusheji.mapper;

import java.util.ArrayList;
import org.apache.ibatis.annotations.Param;
import com.chengxusheji.po.Contest;

public interface ContestMapper {
	/*添加比赛信息*/
	public void addContest(Contest contest) throws Exception;

	/*按照查询条件分页查询比赛记录*/
	public ArrayList<Contest> queryContest(@Param("where") String where,@Param("startIndex") int startIndex,@Param("pageSize") int pageSize) throws Exception;

	/*学生按照查询条件分页查询比赛记录*/
	public ArrayList<Contest> userQueryContest(@Param("where") String where,@Param("startIndex") int startIndex,@Param("pageSize") int pageSize) throws Exception;

	
	/*按照查询条件查询所有比赛记录*/
	public ArrayList<Contest> queryContestList(@Param("where") String where) throws Exception;

	/*按照查询条件的比赛记录数*/
	public int queryContestCount(@Param("where") String where) throws Exception;
	
	/*用户按照查询条件的比赛记录数*/
	public int userQueryContestCount(@Param("where") String where) throws Exception; 

	/*根据主键查询某条比赛记录*/
	public Contest getContest(int contestId) throws Exception;

	/*更新比赛记录*/
	public void updateContest(Contest contest) throws Exception;

	/*删除比赛记录*/
	public void deleteContest(int contestId) throws Exception;

}
