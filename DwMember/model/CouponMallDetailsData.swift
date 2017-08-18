//
//	CouponMallDetailsData.swift
//
//	Create by 靖 温 on 17/8/2017
//	Copyright © 2017. All rights reserved.
//	模型生成器（小波汉化）JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct CouponMallDetailsData{

	var briefing : String!
	var counts : Int!
	var couponStatus : String!
	var endtime : String!
	var exchangeFactor : Int!
	var exchangeMsg : String!
	var exchangeType : String!
	var id : String!
	var image : String!
	var starttime : String!
	var surplus : Int!
	var times : Int!
	var title : String!
	var useValidPeriod : Int!


	/**
	 * 用字典来初始化一个实例并设置各个属性值
	 */
	init(fromDictionary dictionary: NSDictionary){
		briefing = dictionary["briefing"] as? String
		counts = dictionary["counts"] as? Int
		couponStatus = dictionary["couponStatus"] as? String
		endtime = dictionary["endtime"] as? String
		exchangeFactor = dictionary["exchangeFactor"] as? Int
		exchangeMsg = dictionary["exchangeMsg"] as? String
		exchangeType = dictionary["exchangeType"] as? String
		id = dictionary["id"] as? String
		image = dictionary["image"] as? String
		starttime = dictionary["starttime"] as? String
		surplus = dictionary["surplus"] as? Int
		times = dictionary["times"] as? Int
		title = dictionary["title"] as? String
		useValidPeriod = dictionary["useValidPeriod"] as? Int
	}

	/**
	 * 把所有属性值存到一个NSDictionary对象，键是相应的属性名。
	 */
	func toDictionary() -> NSDictionary
	{
		var dictionary = NSMutableDictionary()
		if briefing != nil{
			dictionary["briefing"] = briefing
		}
		if counts != nil{
			dictionary["counts"] = counts
		}
		if couponStatus != nil{
			dictionary["couponStatus"] = couponStatus
		}
		if endtime != nil{
			dictionary["endtime"] = endtime
		}
		if exchangeFactor != nil{
			dictionary["exchangeFactor"] = exchangeFactor
		}
		if exchangeMsg != nil{
			dictionary["exchangeMsg"] = exchangeMsg
		}
		if exchangeType != nil{
			dictionary["exchangeType"] = exchangeType
		}
		if id != nil{
			dictionary["id"] = id
		}
		if image != nil{
			dictionary["image"] = image
		}
		if starttime != nil{
			dictionary["starttime"] = starttime
		}
		if surplus != nil{
			dictionary["surplus"] = surplus
		}
		if times != nil{
			dictionary["times"] = times
		}
		if title != nil{
			dictionary["title"] = title
		}
		if useValidPeriod != nil{
			dictionary["useValidPeriod"] = useValidPeriod
		}
		return dictionary
	}

}