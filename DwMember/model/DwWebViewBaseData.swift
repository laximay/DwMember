//
//	DwWebViewBaseData.swift
//
//	Create by 靖 温 on 16/8/2017
//	Copyright © 2017. All rights reserved.
//	模型生成器（小波汉化）JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct DwWebViewBaseData{

	var random : String!
	var url : String!


	/**
	 * 用字典来初始化一个实例并设置各个属性值
	 */
	init(fromDictionary dictionary: NSDictionary){
		random = dictionary["random"] as? String
		url = dictionary["url"] as? String
	}

	/**
	 * 把所有属性值存到一个NSDictionary对象，键是相应的属性名。
	 */
	func toDictionary() -> NSDictionary
	{
		var dictionary = NSMutableDictionary()
		if random != nil{
			dictionary["random"] = random
		}
		if url != nil{
			dictionary["url"] = url
		}
		return dictionary
	}

}