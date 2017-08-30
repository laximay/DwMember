//
//	CouponMallData.swift
//
//	Create by 靖 温 on 17/8/2017
//	Copyright © 2017. All rights reserved.
//	模型生成器（小波汉化）JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct CouponMallData{

	var endTime : String!
	var exchangeFactor : Int!
	var exchangeType : String!
    var exchangeMsg : String!
	var id : String!
	var image : String!
	var title : String!


	/**
	 * 用字典来初始化一个实例并设置各个属性值
	 */
	init(fromDictionary dictionary: NSDictionary){
		endTime = dictionary["endTime"] as? String
		exchangeFactor = dictionary["exchangeFactor"] as? Int
		exchangeType = dictionary["exchangeType"] as? String
        exchangeMsg = dictionary["exchangeMsg"] as? String
		id = dictionary["id"] as? String
		image = dictionary["image"] as? String
		title = dictionary["title"] as? String
	}

	/**
	 * 把所有属性值存到一个NSDictionary对象，键是相应的属性名。
	 */
	func toDictionary() -> NSDictionary
	{
		let dictionary = NSMutableDictionary()
		if endTime != nil{
			dictionary["endTime"] = endTime
		}
		if exchangeFactor != nil{
			dictionary["exchangeFactor"] = exchangeFactor
		}
		if exchangeType != nil{
			dictionary["exchangeType"] = exchangeType
		}
        if exchangeMsg != nil{
            dictionary["exchangeMsg"] = exchangeMsg
        }
		if id != nil{
			dictionary["id"] = id
		}
		if image != nil{
			dictionary["image"] = image
		}
		if title != nil{
			dictionary["title"] = title
		}
		return dictionary
	}

}
