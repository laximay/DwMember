//
//	DwReservationBranch.swift
//
//	Create by 靖 温 on 29/11/2017
//	Copyright © 2017. All rights reserved.
//	模型生成器（小波汉化）JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct DwReservationBranch{

	var addr : String!
	var appAuthToken : AnyObject!
	var companyId : AnyObject!
	var eid : AnyObject!
	var ename : AnyObject!
	var epoiId : AnyObject!
	var id : String!
	var image : String!
	var ip : AnyObject!
	var ishao : String!
	var isreservation : String!
	var lastUpdateNameId : AnyObject!
	var lastUpdateTime : AnyObject!
	var latitude : String!
	var longitude : String!
	var name1 : String!
	var name2 : String!
	var networkStatus : AnyObject!
	var onlinebill : Int!
	var onlineorder : Int!
	var outlet : String!
	var region : AnyObject!
	var regionId : AnyObject!
	var remark1 : AnyObject!
	var remark2 : AnyObject!
	var remark3 : AnyObject!
	var tel : String!
	var timeRemind : AnyObject!
	var timeSpan : AnyObject!
	var type : String!
	var version : Int!


	/**
	 * 用字典来初始化一个实例并设置各个属性值
	 */
	init(fromDictionary dictionary: NSDictionary){
		addr = dictionary["addr"] as? String
		appAuthToken = dictionary["appAuthToken"] as? AnyObject
		companyId = dictionary["companyId"] as? AnyObject
		eid = dictionary["eid"] as? AnyObject
		ename = dictionary["ename"] as? AnyObject
		epoiId = dictionary["epoiId"] as? AnyObject
		id = dictionary["id"] as? String
		image = dictionary["image"] as? String
		ip = dictionary["ip"] as? AnyObject
		ishao = dictionary["ishao"] as? String
		isreservation = dictionary["isreservation"] as? String
		lastUpdateNameId = dictionary["lastUpdateNameId"] as? AnyObject
		lastUpdateTime = dictionary["lastUpdateTime"] as? AnyObject
		latitude = dictionary["latitude"] as? String
		longitude = dictionary["longitude"] as? String
		name1 = dictionary["name1"] as? String
		name2 = dictionary["name2"] as? String
		networkStatus = dictionary["networkStatus"] as? AnyObject
		onlinebill = dictionary["onlinebill"] as? Int
		onlineorder = dictionary["onlineorder"] as? Int
		outlet = dictionary["outlet"] as? String
		region = dictionary["region"] as? AnyObject
		regionId = dictionary["regionId"] as? AnyObject
		remark1 = dictionary["remark1"] as? AnyObject
		remark2 = dictionary["remark2"] as? AnyObject
		remark3 = dictionary["remark3"] as? AnyObject
		tel = dictionary["tel"] as? String
		timeRemind = dictionary["timeRemind"] as? AnyObject
		timeSpan = dictionary["timeSpan"] as? AnyObject
		type = dictionary["type"] as? String
		version = dictionary["version"] as? Int
	}

	/**
	 * 把所有属性值存到一个NSDictionary对象，键是相应的属性名。
	 */
	func toDictionary() -> NSDictionary
	{
		var dictionary = NSMutableDictionary()
		if addr != nil{
			dictionary["addr"] = addr
		}
		if appAuthToken != nil{
			dictionary["appAuthToken"] = appAuthToken
		}
		if companyId != nil{
			dictionary["companyId"] = companyId
		}
		if eid != nil{
			dictionary["eid"] = eid
		}
		if ename != nil{
			dictionary["ename"] = ename
		}
		if epoiId != nil{
			dictionary["epoiId"] = epoiId
		}
		if id != nil{
			dictionary["id"] = id
		}
		if image != nil{
			dictionary["image"] = image
		}
		if ip != nil{
			dictionary["ip"] = ip
		}
		if ishao != nil{
			dictionary["ishao"] = ishao
		}
		if isreservation != nil{
			dictionary["isreservation"] = isreservation
		}
		if lastUpdateNameId != nil{
			dictionary["lastUpdateNameId"] = lastUpdateNameId
		}
		if lastUpdateTime != nil{
			dictionary["lastUpdateTime"] = lastUpdateTime
		}
		if latitude != nil{
			dictionary["latitude"] = latitude
		}
		if longitude != nil{
			dictionary["longitude"] = longitude
		}
		if name1 != nil{
			dictionary["name1"] = name1
		}
		if name2 != nil{
			dictionary["name2"] = name2
		}
		if networkStatus != nil{
			dictionary["networkStatus"] = networkStatus
		}
		if onlinebill != nil{
			dictionary["onlinebill"] = onlinebill
		}
		if onlineorder != nil{
			dictionary["onlineorder"] = onlineorder
		}
		if outlet != nil{
			dictionary["outlet"] = outlet
		}
		if region != nil{
			dictionary["region"] = region
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
		if tel != nil{
			dictionary["tel"] = tel
		}
		if timeRemind != nil{
			dictionary["timeRemind"] = timeRemind
		}
		if timeSpan != nil{
			dictionary["timeSpan"] = timeSpan
		}
		if type != nil{
			dictionary["type"] = type
		}
		if version != nil{
			dictionary["version"] = version
		}
		return dictionary
	}

}