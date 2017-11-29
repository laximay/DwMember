//
//	DwReservationMeal.swift
//
//	Create by 靖 温 on 29/11/2017
//	Copyright © 2017. All rights reserved.
//	模型生成器（小波汉化）JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct DwReservationMeal{

	var cardno : String!
	var custname : String!
	var id : String!
	var meal : String!
	var mealCode : String!
	var mealId : String!
	var reservationId : String!
	var total : String!


	/**
	 * 用字典来初始化一个实例并设置各个属性值
	 */
	init(fromDictionary dictionary: NSDictionary){
		cardno = dictionary["cardno"] as? String
		custname = dictionary["custname"] as? String
		id = dictionary["id"] as? String
		meal = dictionary["meal"] as? String
		mealCode = dictionary["mealCode"] as? String
		mealId = dictionary["mealId"] as? String
		reservationId = dictionary["reservationId"] as? String
		total = dictionary["total"] as? String
	}

	/**
	 * 把所有属性值存到一个NSDictionary对象，键是相应的属性名。
	 */
	func toDictionary() -> NSDictionary
	{
		var dictionary = NSMutableDictionary()
		if cardno != nil{
			dictionary["cardno"] = cardno
		}
		if custname != nil{
			dictionary["custname"] = custname
		}
		if id != nil{
			dictionary["id"] = id
		}
		if meal != nil{
			dictionary["meal"] = meal
		}
		if mealCode != nil{
			dictionary["mealCode"] = mealCode
		}
		if mealId != nil{
			dictionary["mealId"] = mealId
		}
		if reservationId != nil{
			dictionary["reservationId"] = reservationId
		}
		if total != nil{
			dictionary["total"] = total
		}
		return dictionary
	}

}