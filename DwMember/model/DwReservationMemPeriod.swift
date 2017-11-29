//
//	DwReservationMemPeriod.swift
//
//	Create by 靖 温 on 29/11/2017
//	Copyright © 2017. All rights reserved.
//	模型生成器（小波汉化）JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct DwReservationMemPeriod{

	var branch : AnyObject!
	var code : String!
	var etime : String!
	var id : String!
	var isvalid : String!
	var lastUpdateNameId : AnyObject!
	var lastUpdateTime : AnyObject!
	var name : String!
	var outlet : String!
	var regionId : AnyObject!
	var remark1 : String!
	var remark2 : AnyObject!
	var remark3 : AnyObject!
	var sort : String!
	var stime : String!
	var version : Int!


	/**
	 * 用字典来初始化一个实例并设置各个属性值
	 */
	init(fromDictionary dictionary: NSDictionary){
		branch = dictionary["branch"] as? AnyObject
		code = dictionary["code"] as? String
		etime = dictionary["etime"] as? String
		id = dictionary["id"] as? String
		isvalid = dictionary["isvalid"] as? String
		lastUpdateNameId = dictionary["lastUpdateNameId"] as? AnyObject
		lastUpdateTime = dictionary["lastUpdateTime"] as? AnyObject
		name = dictionary["name"] as? String
		outlet = dictionary["outlet"] as? String
		regionId = dictionary["regionId"] as? AnyObject
		remark1 = dictionary["remark1"] as? String
		remark2 = dictionary["remark2"] as? AnyObject
		remark3 = dictionary["remark3"] as? AnyObject
		sort = dictionary["sort"] as? String
		stime = dictionary["stime"] as? String
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
		if etime != nil{
			dictionary["etime"] = etime
		}
		if id != nil{
			dictionary["id"] = id
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
		if name != nil{
			dictionary["name"] = name
		}
		if outlet != nil{
			dictionary["outlet"] = outlet
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
		if sort != nil{
			dictionary["sort"] = sort
		}
		if stime != nil{
			dictionary["stime"] = stime
		}
		if version != nil{
			dictionary["version"] = version
		}
		return dictionary
	}

}