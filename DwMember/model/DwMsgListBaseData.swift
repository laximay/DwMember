//
//	DwMsgListBaseData.swift
//
//	Create by 靖 温 on 17/8/2017
//	Copyright © 2017. All rights reserved.
//	模型生成器（小波汉化）JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct DwMsgListBaseData{

	var briefing : String!
	var dateTime : String!
	var descriptionField : String!
	var id : String!
	var image : String!
	var isread : Bool!
	var title : String!


	/**
	 * 用字典来初始化一个实例并设置各个属性值
	 */
	init(fromDictionary dictionary: NSDictionary){
		briefing = dictionary["briefing"] as? String
		dateTime = dictionary["dateTime"] as? String
		descriptionField = dictionary["description"] as? String
		id = dictionary["id"] as? String
		image = dictionary["image"] as? String
		isread = dictionary["isread"] as? Bool
		title = dictionary["title"] as? String
	}

	/**
	 * 把所有属性值存到一个NSDictionary对象，键是相应的属性名。
	 */
	func toDictionary() -> NSDictionary
	{
		let dictionary = NSMutableDictionary()
		if briefing != nil{
			dictionary["briefing"] = briefing
		}
		if dateTime != nil{
			dictionary["dateTime"] = dateTime
		}
		if descriptionField != nil{
			dictionary["description"] = descriptionField
		}
		if id != nil{
			dictionary["id"] = id
		}
		if image != nil{
			dictionary["image"] = image
		}
		if isread != nil{
			dictionary["isread"] = isread
		}
		if title != nil{
			dictionary["title"] = title
		}
		return dictionary
	}

}
