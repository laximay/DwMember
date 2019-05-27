//
//	DwReservationPerson.swift
//
//	Create by 靖 温 on 29/11/2017
//	Copyright © 2017. All rights reserved.
//	模型生成器（小波汉化）JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct DwReservationPerson{

	var calculateSeat : String!
	var code : String!
	var feeTips : String!
	var name : String!
	var personId : String!
	var personNum : Int!
	var remark : String!
	var reservationId : String!
    var viewName : String!


	/**
	 * 用字典来初始化一个实例并设置各个属性值
	 */
	init(fromDictionary dictionary: NSDictionary){
		calculateSeat = dictionary["calculateSeat"] as? String
		code = dictionary["code"] as? String
		feeTips = dictionary["feeTips"] as? String
		name = dictionary["name"] as? String
		personId = dictionary["personId"] as? String
		personNum = dictionary["personNum"] as? Int
		remark = dictionary["remark"] as? String
		reservationId = dictionary["reservationId"] as? String
        viewName = dictionary["viewName"] as? String
	}

	/**
	 * 把所有属性值存到一个NSDictionary对象，键是相应的属性名。
	 */
	func toDictionary() -> NSDictionary
	{
        let dictionary = NSMutableDictionary()
		if calculateSeat != nil{
			dictionary["calculateSeat"] = calculateSeat
		}
		if code != nil{
			dictionary["code"] = code
		}
		if feeTips != nil{
			dictionary["feeTips"] = feeTips
		}
		if name != nil{
			dictionary["name"] = name
		}
		if personId != nil{
			dictionary["personId"] = personId
		}
		if personNum != nil{
			dictionary["personNum"] = personNum
		}
		if remark != nil{
			dictionary["remark"] = remark
		}
		if reservationId != nil{
			dictionary["reservationId"] = reservationId
		}
        if viewName != nil{
            dictionary["viewName"] = reservationId
        }
		return dictionary
	}

}
