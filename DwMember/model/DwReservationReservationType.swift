//
//	DwReservationReservationType.swift
//
//	Create by 靖 温 on 29/11/2017
//	Copyright © 2017. All rights reserved.
//	模型生成器（小波汉化）JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct DwReservationReservationType{

	var branch : AnyObject!
	var code : String!
	var id : String!
	var isdefault : String!
	var isvalid : String!
	var lastUpdateNameId : AnyObject!
	var lastUpdateTime : AnyObject!
	var memPeriod : AnyObject!
	var name : String!
	var outlet : String!
	var period : String!
	var regionId : AnyObject!
	var remark1 : String!
	var remark2 : AnyObject!
	var remark3 : AnyObject!
	var version : Int!


	/**
	 * 用字典来初始化一个实例并设置各个属性值
	 */
	init(fromDictionary dictionary: NSDictionary){
		branch = dictionary["branch"] as? AnyObject
		code = dictionary["code"] as? String
		id = dictionary["id"] as? String
		isdefault = dictionary["isdefault"] as? String
		isvalid = dictionary["isvalid"] as? String
		lastUpdateNameId = dictionary["lastUpdateNameId"] as? AnyObject
		lastUpdateTime = dictionary["lastUpdateTime"] as? AnyObject
		memPeriod = dictionary["memPeriod"] as? AnyObject
		name = dictionary["name"] as? String
		outlet = dictionary["outlet"] as? String
		period = dictionary["period"] as? String
		regionId = dictionary["regionId"] as? AnyObject
		remark1 = dictionary["remark1"] as? String
		remark2 = dictionary["remark2"] as? AnyObject
		remark3 = dictionary["remark3"] as? AnyObject
		version = dictionary["version"] as? Int
	}

	/**
	 * 把所有属性值存到一个NSDictionary对象，键是相应的属性名。
	 */
	func toDictionary() -> NSDictionary
	{
		var dictionary = NSMutableDictionary()
		if branch != nil{
			dictionary["branch"] = branch
		}
		if code != nil{
			dictionary["code"] = code
		}
		if id != nil{
			dictionary["id"] = id
		}
		if isdefault != nil{
			dictionary["isdefault"] = isdefault
		}
		if isvalid != nil{
			dictionary["isvalid"] = isvalid
		}
		if lastUpdateNameId != nil{
			dictionary["lastUpdateNameId"] = lastUpdateNameId
		}
		if lastUpdateTime != nil{
			dictionary["lastUpdateTime"] = lastUpdateTime
		}
		if memPeriod != nil{
			dictionary["memPeriod"] = memPeriod
		}
		if name != nil{
			dictionary["name"] = name
		}
		if outlet != nil{
			dictionary["outlet"] = outlet
		}
		if period != nil{
			dictionary["period"] = period
		}
		if regionId != nil{
			dictionary["regionId"] = regionId
		}
		if remark1 != nil{
			dictionary["remark1"] = remark1
		}
		if remark2 != nil{
			dictionary["remark2"] = remark2
		}
		if remark3 != nil{
			dictionary["remark3"] = remark3
		}
		if version != nil{
			dictionary["version"] = version
		}
		return dictionary
	}

}