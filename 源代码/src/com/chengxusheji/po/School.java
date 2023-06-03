package com.chengxusheji.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class School {
    /*学校id*/
    private Integer schoolId;
    public Integer getSchoolId(){
        return schoolId;
    }
    public void setSchoolId(Integer schoolId){
        this.schoolId = schoolId;
    }

    /*学校名称*/
    @NotEmpty(message="学校名称不能为空")
    private String schoolName;
    public String getSchoolName() {
        return schoolName;
    }
    public void setSchoolName(String schoolName) {
        this.schoolName = schoolName;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonSchool=new JSONObject(); 
		jsonSchool.accumulate("schoolId", this.getSchoolId());
		jsonSchool.accumulate("schoolName", this.getSchoolName());
		return jsonSchool;
    }}