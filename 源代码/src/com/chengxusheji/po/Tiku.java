package com.chengxusheji.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class Tiku {
    /*题库id*/
    private Integer tikuId;
    public Integer getTikuId(){
        return tikuId;
    }
    public void setTikuId(Integer tikuId){
        this.tikuId = tikuId;
    }

    /*题库分类*/
    private TikuType tikuTypeObj;
    public TikuType getTikuTypeObj() {
        return tikuTypeObj;
    }
    public void setTikuTypeObj(TikuType tikuTypeObj) {
        this.tikuTypeObj = tikuTypeObj;
    }

    /*题库名称*/
    @NotEmpty(message="题库名称不能为空")
    private String tikuName;
    public String getTikuName() {
        return tikuName;
    }
    public void setTikuName(String tikuName) {
        this.tikuName = tikuName;
    }

    /*题库内容*/
    @NotEmpty(message="题库内容不能为空")
    private String tikuContent;
    public String getTikuContent() {
        return tikuContent;
    }
    public void setTikuContent(String tikuContent) {
        this.tikuContent = tikuContent;
    }

    /*点击率*/
    @NotNull(message="必须输入点击率")
    private Integer hitNum;
    public Integer getHitNum() {
        return hitNum;
    }
    public void setHitNum(Integer hitNum) {
        this.hitNum = hitNum;
    }

    /*发布时间*/
    @NotEmpty(message="发布时间不能为空")
    private String addTime;
    public String getAddTime() {
        return addTime;
    }
    public void setAddTime(String addTime) {
        this.addTime = addTime;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonTiku=new JSONObject(); 
		jsonTiku.accumulate("tikuId", this.getTikuId());
		jsonTiku.accumulate("tikuTypeObj", this.getTikuTypeObj().getTikuTypeName());
		jsonTiku.accumulate("tikuTypeObjPri", this.getTikuTypeObj().getTypeId());
		jsonTiku.accumulate("tikuName", this.getTikuName());
		jsonTiku.accumulate("tikuContent", this.getTikuContent());
		jsonTiku.accumulate("hitNum", this.getHitNum());
		jsonTiku.accumulate("addTime", this.getAddTime().length()>19?this.getAddTime().substring(0,19):this.getAddTime());
		return jsonTiku;
    }}