package com.chengxusheji.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class Score {
    /*成绩id*/
    private Integer scoreId;
    public Integer getScoreId(){
        return scoreId;
    }
    public void setScoreId(Integer scoreId){
        this.scoreId = scoreId;
    }

    /*比赛名称*/
    private Contest contestObj;
    public Contest getContestObj() {
        return contestObj;
    }
    public void setContestObj(Contest contestObj) {
        this.contestObj = contestObj;
    }

    /*学生*/
    private Student studentObj;
    public Student getStudentObj() {
        return studentObj;
    }
    public void setStudentObj(Student studentObj) {
        this.studentObj = studentObj;
    }

    /*比赛轮次*/
    @NotEmpty(message="比赛轮次不能为空")
    private String contentRound;
    public String getContentRound() {
        return contentRound;
    }
    public void setContentRound(String contentRound) {
        this.contentRound = contentRound;
    }

    /*比赛积分*/
    @NotNull(message="必须输入比赛积分")
    private Float scoreValue;
    public Float getScoreValue() {
        return scoreValue;
    }
    public void setScoreValue(Float scoreValue) {
        this.scoreValue = scoreValue;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonScore=new JSONObject(); 
		jsonScore.accumulate("scoreId", this.getScoreId());
		jsonScore.accumulate("contestObj", this.getContestObj().getContestName());
		jsonScore.accumulate("contestObjPri", this.getContestObj().getContestId());
		jsonScore.accumulate("studentObj", this.getStudentObj().getName());
		jsonScore.accumulate("studentObjPri", this.getStudentObj().getUser_name());
		jsonScore.accumulate("contentRound", this.getContentRound());
		jsonScore.accumulate("scoreValue", this.getScoreValue());
		return jsonScore;
    }}