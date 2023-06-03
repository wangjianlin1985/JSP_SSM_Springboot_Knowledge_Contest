package com.chengxusheji.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class TikuType {
    /*题库类目id*/
    private Integer typeId;
    public Integer getTypeId(){
        return typeId;
    }
    public void setTypeId(Integer typeId){
        this.typeId = typeId;
    }

    /*题库类目名称*/
    @NotEmpty(message="题库类目名称不能为空")
    private String tikuTypeName;
    public String getTikuTypeName() {
        return tikuTypeName;
    }
    public void setTikuTypeName(String tikuTypeName) {
        this.tikuTypeName = tikuTypeName;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonTikuType=new JSONObject(); 
		jsonTikuType.accumulate("typeId", this.getTypeId());
		jsonTikuType.accumulate("tikuTypeName", this.getTikuTypeName());
		return jsonTikuType;
    }}