//
//	DwHomeActivity.swift
//
//	Create by 靖 温 on 11/8/2017
//	Copyright © 2017. All rights reserved.
//	模型生成器（小波汉化）JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct DwHomeActivity{

	var briefing : String!
	var descriptionField : String!
	var english : String!
	var image : String!
	var name : String!
	var opentype : String!
	var simpChinese : String!
	var sort : Int!
	var thumb : String!
	var url : String!
    var id : String!


	/**
	 * 用字典来初始化一个实例并设置各个属性值
	 */
	init(fromDictionary dictionary: NSDictionary){
		briefing = dictionary["briefing"] as? String
		descriptionField = dictionary["description"] as? String
		english = dictionary["english"] as? String
		image = dictionary["image"] as? String
		name = dictionary["name"] as? String
		opentype = dictionary["opentype"] as? String
		simpChinese = dictionary["simpChinese"] as? String
		sort = dictionary["sort"] as? Int
		thumb = dictionary["thumb"] as? String
		url = dictionary["url"] as? String
        id = dictionary["id"] as? String
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
		if descriptionField != nil{
			dictionary["description"] = descriptionField
		}
		if english != nil{
			dictionary["english"] = english
		}
		if image != nil{
			dictionary["image"] = image
		}
		if name != nil{
			dictionary["name"] = name
		}
		if opentype != nil{
			dictionary["opentype"] = opentype
		}
		if simpChinese != nil{
			dictionary["simpChinese"] = simpChinese
		}
		if sort != nil{
			dictionary["sort"] = sort
		}
		if thumb != nil{
			dictionary["thumb"] = thumb
		}
		if url != nil{
			dictionary["url"] = url
		}
        if id != nil{
            dictionary["id"] = id
        }
		return dictionary
	}


}