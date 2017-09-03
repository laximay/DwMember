//
//	DwUpdataData.swift
//
//	Create by 靖 温 on 3/9/2017
//	Copyright © 2017. All rights reserved.
//	模型生成器（小波汉化）JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct DwUpdataData{

	var downloadCount : Int!
	var downloadUrl : String!
	var explain : String!
	var inner : Int!
	var isMust : Bool!
	var time : String!
	var type : String!
	var versions : String!


	/**
	 * 用字典来初始化一个实例并设置各个属性值
	 */
	init(fromDictionary dictionary: NSDictionary){
		downloadCount = dictionary["downloadCount"] as? Int
		downloadUrl = dictionary["downloadUrl"] as? String
		explain = dictionary["explain"] as? String
		inner = dictionary["inner"] as? Int
		isMust = dictionary["isMust"] as? Bool
		time = dictionary["time"] as? String
		type = dictionary["type"] as? String
		versions = dictionary["versions"] as? String
	}

	/**
	 * 把所有属性值存到一个NSDictionary对象，键是相应的属性名。
	 */
	func toDictionary() -> NSDictionary
	{
		var dictionary = NSMutableDictionary()
		if downloadCount != nil{
			dictionary["downloadCount"] = downloadCount
		}
		if downloadUrl != nil{
			dictionary["downloadUrl"] = downloadUrl
		}
		if explain != nil{
			dictionary["explain"] = explain
		}
		if inner != nil{
			dictionary["inner"] = inner
		}
		if isMust != nil{
			dictionary["isMust"] = isMust
		}
		if time != nil{
			dictionary["time"] = time
		}
		if type != nil{
			dictionary["type"] = type
		}
		if versions != nil{
			dictionary["versions"] = versions
		}
		return dictionary
	}

}