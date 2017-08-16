//
//	DwLoginCard.swift
//
//	Create by 靖 温 on 16/8/2017
//	Copyright © 2017. All rights reserved.
//	模型生成器（小波汉化）JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct DwLoginCard{

	var balance : Float!
	var cardno : String!
	var closedt : String!
	var giftBalance : Double!
	var integral : Int!
	var memberName : String!
	var stat : String!


	/**
	 * 用字典来初始化一个实例并设置各个属性值
	 */
	init(fromDictionary dictionary: NSDictionary){
		balance = dictionary["balance"] as? Float
		cardno = dictionary["cardno"] as? String
		closedt = dictionary["closedt"] as? String
		giftBalance = dictionary["giftBalance"] as? Double
		integral = dictionary["integral"] as? Int
		memberName = dictionary["memberName"] as? String
		stat = dictionary["stat"] as? String
	}

	/**
	 * 把所有属性值存到一个NSDictionary对象，键是相应的属性名。
	 */
	func toDictionary() -> NSDictionary
	{
		var dictionary = NSMutableDictionary()
		if balance != nil{
			dictionary["balance"] = balance
		}
		if cardno != nil{
			dictionary["cardno"] = cardno
		}
		if closedt != nil{
			dictionary["closedt"] = closedt
		}
		if giftBalance != nil{
			dictionary["giftBalance"] = giftBalance
		}
		if integral != nil{
			dictionary["integral"] = integral
		}
		if memberName != nil{
			dictionary["memberName"] = memberName
		}
		if stat != nil{
			dictionary["stat"] = stat
		}
		return dictionary
	}

}
