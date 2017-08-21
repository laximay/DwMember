//
//	DwReservationReList.swift
//
//	Create by 靖 温 on 21/8/2017
//	Copyright © 2017. All rights reserved.
//	模型生成器（小波汉化）JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct DwReservationReList{

	var branch : DwReservationBranch!
	var cardno : String!
	var custDetail : DwReservationCustDetail!
	var custName : String!
	var id : String!
	var indate : String!
	var intime : String!
	var iscomfrim : String!
	var lastUpdateNameId : AnyObject!
	var lastUpdateTime : AnyObject!
	var meals : [DwReservationMeal]!
	var memPeriod : DwReservationMemPeriod!
	var orderNo : String!
	var orderType : String!
	var outlet : AnyObject!
	var period : AnyObject!
	var person : String!
	var phoneNo : String!
	var remark1 : AnyObject!
	var remark2 : AnyObject!
	var remark3 : AnyObject!
	var remarks : [DwReservationRemark]!
	var reservationType : DwReservationReservationType!
	var tableNo : AnyObject!
	var type : AnyObject!
	var version : Int!


	/**
	 * 用字典来初始化一个实例并设置各个属性值
	 */
	init(fromDictionary dictionary: NSDictionary){
		if let branchData = dictionary["branch"] as? NSDictionary{
				branch = DwReservationBranch(fromDictionary: branchData)
			}
		cardno = dictionary["cardno"] as? String
		if let custDetailData = dictionary["custDetail"] as? NSDictionary{
				custDetail = DwReservationCustDetail(fromDictionary: custDetailData)
			}
		custName = dictionary["custName"] as? String
		id = dictionary["id"] as? String
		indate = dictionary["indate"] as? String
		intime = dictionary["intime"] as? String
		iscomfrim = dictionary["iscomfrim"] as? String
		lastUpdateNameId = dictionary["lastUpdateNameId"] as? AnyObject
		lastUpdateTime = dictionary["lastUpdateTime"] as? AnyObject
		meals = [DwReservationMeal]()
		if let mealsArray = dictionary["meals"] as? [NSDictionary]{
			for dic in mealsArray{
				let value = DwReservationMeal(fromDictionary: dic)
				meals.append(value)
			}
		}
		if let memPeriodData = dictionary["memPeriod"] as? NSDictionary{
				memPeriod = DwReservationMemPeriod(fromDictionary: memPeriodData)
			}
		orderNo = dictionary["orderNo"] as? String
		orderType = dictionary["orderType"] as? String
		outlet = dictionary["outlet"] as? AnyObject
		period = dictionary["period"] as? AnyObject
		person = dictionary["person"] as? String
		phoneNo = dictionary["phoneNo"] as? String
		remark1 = dictionary["remark1"] as? AnyObject
		remark2 = dictionary["remark2"] as? AnyObject
		remark3 = dictionary["remark3"] as? AnyObject
		remarks = [DwReservationRemark]()
		if let remarksArray = dictionary["remarks"] as? [NSDictionary]{
			for dic in remarksArray{
				let value = DwReservationRemark(fromDictionary: dic)
				remarks.append(value)
			}
		}
		if let reservationTypeData = dictionary["reservationType"] as? NSDictionary{
				reservationType = DwReservationReservationType(fromDictionary: reservationTypeData)
			}
		tableNo = dictionary["tableNo"] as? AnyObject
		type = dictionary["type"] as? AnyObject
		version = dictionary["version"] as? Int
	}

	/**
	 * 把所有属性值存到一个NSDictionary对象，键是相应的属性名。
	 */
	func toDictionary() -> NSDictionary
	{
		var dictionary = NSMutableDictionary()
		if branch != nil{
			dictionary["branch"] = branch.toDictionary()
		}
		if cardno != nil{
			dictionary["cardno"] = cardno
		}
		if custDetail != nil{
			dictionary["custDetail"] = custDetail.toDictionary()
		}
		if custName != nil{
			dictionary["custName"] = custName
		}
		if id != nil{
			dictionary["id"] = id
		}
		if indate != nil{
			dictionary["indate"] = indate
		}
		if intime != nil{
			dictionary["intime"] = intime
		}
		if iscomfrim != nil{
			dictionary["iscomfrim"] = iscomfrim
		}
		if lastUpdateNameId != nil{
			dictionary["lastUpdateNameId"] = lastUpdateNameId
		}
		if lastUpdateTime != nil{
			dictionary["lastUpdateTime"] = lastUpdateTime
		}
		if meals != nil{
			var dictionaryElements = [NSDictionary]()
			for mealsElement in meals {
				dictionaryElements.append(mealsElement.toDictionary())
			}
			dictionary["meals"] = dictionaryElements
		}
		if memPeriod != nil{
			dictionary["memPeriod"] = memPeriod.toDictionary()
		}
		if orderNo != nil{
			dictionary["orderNo"] = orderNo
		}
		if orderType != nil{
			dictionary["orderType"] = orderType
		}
		if outlet != nil{
			dictionary["outlet"] = outlet
		}
		if period != nil{
			dictionary["period"] = period
		}
		if person != nil{
			dictionary["person"] = person
		}
		if phoneNo != nil{
			dictionary["phoneNo"] = phoneNo
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
		if remarks != nil{
			var dictionaryElements = [NSDictionary]()
			for remarksElement in remarks {
				dictionaryElements.append(remarksElement.toDictionary())
			}
			dictionary["remarks"] = dictionaryElements
		}
		if reservationType != nil{
			dictionary["reservationType"] = reservationType.toDictionary()
		}
		if tableNo != nil{
			dictionary["tableNo"] = tableNo
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