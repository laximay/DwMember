//
//	DwReservationRemark.swift
//
//	Create by 靖 温 on 29/11/2017
//	Copyright © 2017. All rights reserved.
//	模型生成器（小波汉化）JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct DwReservationRemark{

	var cardno : String!
	var custname : String!
	var id : String!
	var remarkId : String!
	var remarkName : String!
	var reservationId : String!


	/**
	 * 用字典来初始化一个实例并设置各个属性值
	 */
	init(fromDictionary dictionary: NSDictionary){
		cardno = dictionary["cardno"] as? String
		custname = dictionary["custname"] as? String
		id = dictionary["id"] as? String
		remarkId = dictionary["remarkId"] as? String
		remarkName = dictionary["remarkName"] as? String
		reservationId = dictionary["reservationId"] as? String
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
		if remarkId != nil{
			dictionary["remarkId"] = remarkId
		}
		if remarkName != nil{
			dictionary["remarkName"] = remarkName
		}
		if reservationId != nil{
			dictionary["reservationId"] = reservationId
		}
		return dictionary
	}

}