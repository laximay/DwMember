//
//	DwCouponBaseData.swift
//
//	Create by 靖 温 on 17/8/2017
//	Copyright © 2017. All rights reserved.
//	模型生成器（小波汉化）JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct DwCouponBaseData{

	var endTime : String!
	var id : String!
	var image : String!
	var rate : String!
	var title : String!
	var type : String!


	/**
	 * 用字典来初始化一个实例并设置各个属性值
	 */
	init(fromDictionary dictionary: NSDictionary){
		endTime = dictionary["endTime"] as? String
		id = dictionary["id"] as? String
		image = dictionary["image"] as? String
		rate = dictionary["rate"] as? String
		title = dictionary["title"] as? String
		type = dictionary["type"] as? String
	}

	/**
	 * 把所有属性值存到一个NSDictionary对象，键是相应的属性名。
	 */
	func toDictionary() -> NSDictionary
	{
		var dictionary = NSMutableDictionary()
		if endTime != nil{
			dictionary["endTime"] = endTime
		}
		if id != nil{
			dictionary["id"] = id
		}
		if image != nil{
			dictionary["image"] = image
		}
		if rate != nil{
			dictionary["rate"] = rate
		}
		if title != nil{
			dictionary["title"] = title
		}
		if type != nil{
			dictionary["type"] = type
		}
		return dictionary
	}

}