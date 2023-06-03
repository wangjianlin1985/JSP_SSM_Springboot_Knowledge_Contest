package com.chengxusheji.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class Contest {
    /*比赛id*/
    private Integer contestId;
    public Integer getContestId(){
        return contestId;
    }
    public void setContestId(Integer contestId){
        this.contestId = contestId;
    }

    /*举办学校*/
    private School schoolObj;
    public School getSchoolObj() {
        return schoolObj;
    }
    public void setSchoolObj(School schoolObj) {
        this.schoolObj = schoolObj;
    }

    /*比赛项目*/
    private Project projectObj;
    public Project getProjectObj() {
        return projectObj;
    }
    public void setProjectObj(Project projectObj) {
        this.projectObj = projectObj;
    }

    /*比赛名称*/
    @NotEmpty(message="比赛名称不能为空")
    private String contestName;
    public String getContestName() {
        return contestName;
    }
    public void setContestName(String contestName) {
        this.contestName = contestName;
    }

    /*比赛介绍*/
    @NotEmpty(message="比赛介绍不能为空")
    private String contestDesc;
    public String getContestDesc() {
        return contestDesc;
    }
    public void setContestDesc(String contestDesc) {
        this.contestDesc = contestDesc;
    }

    /*比赛地点*/
    @NotEmpty(message="比赛地点不能为空")
    private String contestPlace;
    public String getContestPlace() {
        return contestPlace;
    }
    public void setContestPlace(String contestPlace) {
        this.contestPlace = contestPlace;
    }

    /*人数限制*/
    @NotNull(message="必须输入人数限制")
    private Integer personNumber;
    public Integer getPersonNumber() {
        return personNumber;
    }
    public void setPersonNumber(Integer personNumber) {
        this.personNumber = personNumber;
    }

    /*报名时间*/
    @NotEmpty(message="报名时间不能为空")
    private String signUpTime;
    public String getSignUpTime() {
        return signUpTime;
    }
    public void setSignUpTime(String signUpTime) {
        this.signUpTime = signUpTime;
    }

    /*截止时间*/
    @NotEmpty(message="截止时间不能为空")
    private String endTime;
    public String getEndTime() {
        return endTime;
    }
    public void setEndTime(String endTime) {
        this.endTime = endTime;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonContest=new JSONObject(); 
		jsonContest.accumulate("contestId", this.getContestId());
		jsonContest.accumulate("schoolObj", this.getSchoolObj().getSchoolName());
		jsonContest.accumulate("schoolObjPri", this.getSchoolObj().getSchoolId());
		jsonContest.accumulate("projectObj", this.getProjectObj().getProjectName());
		jsonContest.accumulate("projectObjPri", this.getProjectObj().getProjectId());
		jsonContest.accumulate("contestName", this.getContestName());
		jsonContest.accumulate("contestDesc", this.getContestDesc());
		jsonContest.accumulate("contestPlace", this.getContestPlace());
		jsonContest.accumulate("personNumber", this.getPersonNumber());
		jsonContest.accumulate("signUpTime", this.getSignUpTime().length()>19?this.getSignUpTime().substring(0,19):this.getSignUpTime());
		jsonContest.accumulate("endTime", this.getEndTime().length()>19?this.getEndTime().substring(0,19):this.getEndTime());
		return jsonContest;
    }}