package com.chengxusheji.service;

import java.util.ArrayList;
import javax.annotation.Resource; 
import org.springframework.stereotype.Service;
import com.chengxusheji.po.School;
import com.chengxusheji.po.Project;
import com.chengxusheji.po.Contest;

import com.chengxusheji.mapper.ContestMapper;
@Service
public class ContestService {

	@Resource ContestMapper contestMapper;
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

    /*添加比赛记录*/
    public void addContest(Contest contest) throws Exception {
    	contestMapper.addContest(contest);
    }

    /*按照查询条件分页查询比赛记录*/
    public ArrayList<Contest> queryContest(School schoolObj,Project projectObj,String contestName,String signUpTime,int currentPage) throws Exception { 
     	String where = "where 1=1";
    	if(null != schoolObj && schoolObj.getSchoolId()!= null && schoolObj.getSchoolId()!= 0)  where += " and t_contest.schoolObj=" + schoolObj.getSchoolId();
    	if(null != projectObj && projectObj.getProjectId()!= null && projectObj.getProjectId()!= 0)  where += " and t_contest.projectObj=" + projectObj.getProjectId();
    	if(!contestName.equals("")) where = where + " and t_contest.contestName like '%" + contestName + "%'";
    	if(!signUpTime.equals("")) where = where + " and t_contest.signUpTime like '%" + signUpTime + "%'";
    	int startIndex = (currentPage-1) * this.rows;
    	return contestMapper.queryContest(where, startIndex, this.rows);
    }
    
    
    /*按照查询条件分页查询比赛记录*/
    public ArrayList<Contest> userQueryContest(String user_name,School schoolObj,Project projectObj,String contestName,String signUpTime,int currentPage) throws Exception { 
     	String where = "where t_student.user_name = '" + user_name + "'";
    	if(null != schoolObj && schoolObj.getSchoolId()!= null && schoolObj.getSchoolId()!= 0)  where += " and t_contest.schoolObj=" + schoolObj.getSchoolId();
    	if(null != projectObj && projectObj.getProjectId()!= null && projectObj.getProjectId()!= 0)  where += " and t_contest.projectObj=" + projectObj.getProjectId();
    	if(!contestName.equals("")) where = where + " and t_contest.contestName like '%" + contestName + "%'";
    	if(!signUpTime.equals("")) where = where + " and t_contest.signUpTime like '%" + signUpTime + "%'";
    	int startIndex = (currentPage-1) * this.rows;
    	return contestMapper.userQueryContest(where, startIndex, this.rows);
    }
    
     
    /*按照查询条件查询所有记录*/
    public ArrayList<Contest> queryContest(School schoolObj,Project projectObj,String contestName,String signUpTime) throws Exception  { 
     	String where = "where 1=1";
    	if(null != schoolObj && schoolObj.getSchoolId()!= null && schoolObj.getSchoolId()!= 0)  where += " and t_contest.schoolObj=" + schoolObj.getSchoolId();
    	if(null != projectObj && projectObj.getProjectId()!= null && projectObj.getProjectId()!= 0)  where += " and t_contest.projectObj=" + projectObj.getProjectId();
    	if(!contestName.equals("")) where = where + " and t_contest.contestName like '%" + contestName + "%'";
    	if(!signUpTime.equals("")) where = where + " and t_contest.signUpTime like '%" + signUpTime + "%'";
    	return contestMapper.queryContestList(where);
    }

    /*查询所有比赛记录*/
    public ArrayList<Contest> queryAllContest()  throws Exception {
        return contestMapper.queryContestList("where 1=1");
    }

    /*当前查询条件下计算总的页数和记录数*/
    public void queryTotalPageAndRecordNumber(School schoolObj,Project projectObj,String contestName,String signUpTime) throws Exception {
     	String where = "where 1=1";
    	if(null != schoolObj && schoolObj.getSchoolId()!= null && schoolObj.getSchoolId()!= 0)  where += " and t_contest.schoolObj=" + schoolObj.getSchoolId();
    	if(null != projectObj && projectObj.getProjectId()!= null && projectObj.getProjectId()!= 0)  where += " and t_contest.projectObj=" + projectObj.getProjectId();
    	if(!contestName.equals("")) where = where + " and t_contest.contestName like '%" + contestName + "%'";
    	if(!signUpTime.equals("")) where = where + " and t_contest.signUpTime like '%" + signUpTime + "%'";
        recordNumber = contestMapper.queryContestCount(where);
        int mod = recordNumber % this.rows;
        totalPage = recordNumber / this.rows;
        if(mod != 0) totalPage++;
    }
    
    
    /*当前查询条件下计算总的页数和记录数*/
    public void userQueryTotalPageAndRecordNumber(String user_name,School schoolObj,Project projectObj,String contestName,String signUpTime) throws Exception {
     	String where = "where t_student.user_name='" + user_name + "'";
    	if(null != schoolObj && schoolObj.getSchoolId()!= null && schoolObj.getSchoolId()!= 0)  where += " and t_contest.schoolObj=" + schoolObj.getSchoolId();
    	if(null != projectObj && projectObj.getProjectId()!= null && projectObj.getProjectId()!= 0)  where += " and t_contest.projectObj=" + projectObj.getProjectId();
    	if(!contestName.equals("")) where = where + " and t_contest.contestName like '%" + contestName + "%'";
    	if(!signUpTime.equals("")) where = where + " and t_contest.signUpTime like '%" + signUpTime + "%'";
        recordNumber = contestMapper.userQueryContestCount(where);
        int mod = recordNumber % this.rows;
        totalPage = recordNumber / this.rows;
        if(mod != 0) totalPage++;
    }
    

    /*根据主键获取比赛记录*/
    public Contest getContest(int contestId) throws Exception  {
        Contest contest = contestMapper.getContest(contestId);
        return contest;
    }

    /*更新比赛记录*/
    public void updateContest(Contest contest) throws Exception {
        contestMapper.updateContest(contest);
    }

    /*删除一条比赛记录*/
    public void deleteContest (int contestId) throws Exception {
        contestMapper.deleteContest(contestId);
    }

    /*删除多条比赛信息*/
    public int deleteContests (String contestIds) throws Exception {
    	String _contestIds[] = contestIds.split(",");
    	for(String _contestId: _contestIds) {
    		contestMapper.deleteContest(Integer.parseInt(_contestId));
    	}
    	return _contestIds.length;
    }
}
