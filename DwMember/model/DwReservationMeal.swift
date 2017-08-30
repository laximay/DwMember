//
//	DwReservationMeal.swift
//
//	Create by 靖 温 on 21/8/2017
//	Copyright © 2017. All rights reserved.
//	模型生成器（小波汉化）JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct DwReservationMeal{

	var cardno : String!
	var custname : String!
	var meal : String!
	var mealId : String!
	var reservationId : String!
	var total : String!


	/**
	 * 用字典来初始化一个实例并设置各个属性值
	 */
	init(fromDictionary dictionary: NSDictionary){
		cardno = dictionary["cardno"] as? String
		custname = dictionary["custname"] as? String
		meal = dictionary["meal"] as? String
		mealId = dictionary["mealId"] as? String
		reservationId = dictionary["reservationId"] as? String
		total = dictionary["total"] as? String
	}

	/**
	 * 把所有属性值存到一个NSDictionary对象，键是相应的属性名。
	 */
	func toDictionary() -> NSDictionary
	{
		let dictionary = NSMutableDictionary()
		if cardno != nil{
			dictionary["cardno"] = cardno
		}
		if custname != nil{
			dictionary["custname"] = custname
		}
		if meal != nil{
			dictionary["meal"] = meal
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
