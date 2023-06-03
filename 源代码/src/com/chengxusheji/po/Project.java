package com.chengxusheji.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class Project {
    /*项目id*/
    private Integer projectId;
    public Integer getProjectId(){
        return projectId;
    }
    public void setProjectId(Integer projectId){
        this.projectId = projectId;
    }

    /*项目名称*/
    @NotEmpty(message="项目名称不能为空")
    private String projectName;
    public String getProjectName() {
        return projectName;
    }
    public void setProjectName(String projectName) {
        this.projectName = projectName;
    }

    /*项目介绍*/
    @NotEmpty(message="项目介绍不能为空")
    private String projectDesc;
    public String getProjectDesc() {
        return projectDesc;
    }
    public void setProjectDesc(String projectDesc) {
        this.projectDesc = projectDesc;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonProject=new JSONObject(); 
		jsonProject.accumulate("projectId", this.getProjectId());
		jsonProject.accumulate("projectName", this.getProjectName());
		jsonProject.accumulate("projectDesc", this.getProjectDesc());
		return jsonProject;
    }}