//
//	DwArticleData.swift
//
//	Create by 靖 温 on 4/9/2017
//	Copyright © 2017. All rights reserved.
//	模型生成器（小波汉化）JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct DwArticleData{

	var briefing : String!
	var content : String!
	var date : String!
	var image : String!
	var title : String!
	var type : String!


	/**
	 * 用字典来初始化一个实例并设置各个属性值
	 */
	init(fromDictionary dictionary: NSDictionary){
		briefing = dictionary["briefing"] as? String
		content = dictionary["content"] as? String
		date = dictionary["date"] as? String
		image = dictionary["image"] as? String
		title = dictionary["title"] as? String
		type = dictionary["type"] as? String
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
		if content != nil{
			dictionary["content"] = content
		}
		if date != nil{
			dictionary["date"] = date
		}
		if image != nil{
			dictionary["image"] = image
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
