//
//	DwReservationCustDetail.swift
//
//	Create by 靖 温 on 21/8/2017
//	Copyright © 2017. All rights reserved.
//	模型生成器（小波汉化）JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct DwReservationCustDetail{

	var addr : AnyObject!
	var ageRange : AnyObject!
	var bindtype : String!
	var birthMonth : String!
	var birthday : Int!
	var cardNo : String!
	var companyId : AnyObject!
	var ctid : AnyObject!
	var custna : String!
	var email : String!
	var gender : String!
	var id : String!
	var lastUpdateNameId : AnyObject!
	var lastUpdateTime : AnyObject!
	var lastname : AnyObject!
	var mobile : String!
	var opendid : AnyObject!
	var outlet : AnyObject!
	var pwd : AnyObject!
	var region : AnyObject!
	var remark1 : AnyObject!
	var remark2 : AnyObject!
	var remark3 : AnyObject!
	var stat : Bool!
	var tel : AnyObject!
	var version : Int!
	var zipcode : AnyObject!


	/**
	 * 用字典来初始化一个实例并设置各个属性值
	 */
	init(fromDictionary dictionary: NSDictionary){
		addr = dictionary["addr"] as? AnyObject
		ageRange = dictionary["ageRange"] as? AnyObject
		bindtype = dictionary["bindtype"] as? String
		birthMonth = dictionary["birthMonth"] as? String
		birthday = dictionary["birthday"] as? Int
		cardNo = dictionary["cardNo"] as? String
		companyId = dictionary["companyId"] as? AnyObject
		ctid = dictionary["ctid"] as? AnyObject
		custna = dictionary["custna"] as? String
		email = dictionary["email"] as? String
		gender = dictionary["gender"] as? String
		id = dictionary["id"] as? String
		lastUpdateNameId = dictionary["lastUpdateNameId"] as? AnyObject
		lastUpdateTime = dictionary["lastUpdateTime"] as? AnyObject
		lastname = dictionary["lastname"] as? AnyObject
		mobile = dictionary["mobile"] as? String
		opendid = dictionary["opendid"] as? AnyObject
		outlet = dictionary["outlet"] as? AnyObject
		pwd = dictionary["pwd"] as? AnyObject
		region = dictionary["region"] as? AnyObject
		remark1 = dictionary["remark1"] as? AnyObject
		remark2 = dictionary["remark2"] as? AnyObject
		remark3 = dictionary["remark3"] as? AnyObject
		stat = dictionary["stat"] as? Bool
		tel = dictionary["tel"] as? AnyObject
		version = dictionary["version"] as? Int
		zipcode = dictionary["zipcode"] as? AnyObject
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
		if ageRange != nil{
			dictionary["ageRange"] = ageRange
		}
		if bindtype != nil{
			dictionary["bindtype"] = bindtype
		}
		if birthMonth != nil{
			dictionary["birthMonth"] = birthMonth
		}
		if birthday != nil{
			dictionary["birthday"] = birthday
		}
		if cardNo != nil{
			dictionary["cardNo"] = cardNo
		}
		if companyId != nil{
			dictionary["companyId"] = companyId
		}
		if ctid != nil{
			dictionary["ctid"] = ctid
		}
		if custna != nil{
			dictionary["custna"] = custna
		}
		if email != nil{
			dictionary["email"] = email
		}
		if gender != nil{
			dictionary["gender"] = gender
		}
		if id != nil{
			dictionary["id"] = id
		}
		if lastUpdateNameId != nil{
			dictionary["lastUpdateNameId"] = lastUpdateNameId
		}
		if lastUpdateTime != nil{
			dictionary["lastUpdateTime"] = lastUpdateTime
		}
		if lastname != nil{
			dictionary["lastname"] = lastname
		}
		if mobile != nil{
			dictionary["mobile"] = mobile
		}
		if opendid != nil{
			dictionary["opendid"] = opendid
		}
		if outlet != nil{
			dictionary["outlet"] = outlet
		}
		if pwd != nil{
			dictionary["pwd"] = pwd
		}
		if region != nil{
			dictionary["region"] = region
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
		if stat != nil{
			dictionary["stat"] = stat
		}
		if tel != nil{
			dictionary["tel"] = tel
		}
		if version != nil{
			dictionary["version"] = version
		}
		if zipcode != nil{
			dictionary["zipcode"] = zipcode
		}
		return dictionary
	}

}