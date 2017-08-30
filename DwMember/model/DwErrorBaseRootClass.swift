//
//	DwErrorBaseRootClass.swift
//
//	Create by 靖 温 on 17/8/2017
//	Copyright © 2017. All rights reserved.
//	模型生成器（小波汉化）JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct DwErrorBaseRootClass{

	var error : String!
	var exception : String!
	var message : String!
	var path : String!
	var status : Int!
	var timestamp : String!


	/**
	 * 用字典来初始化一个实例并设置各个属性值
	 */
	init(fromDictionary dictionary: NSDictionary){
		error = dictionary["error"] as? String
		exception = dictionary["exception"] as? String
		message = dictionary["message"] as? String
		path = dictionary["path"] as? String
		status = dictionary["status"] as? Int
		timestamp = dictionary["timestamp"] as? String
	}

	/**
	 * 把所有属性值存到一个NSDictionary对象，键是相应的属性名。
	 */
	func toDictionary() -> NSDictionary
	{
		let dictionary = NSMutableDictionary()
		if error != nil{
			dictionary["error"] = error
		}
		if exception != nil{
			dictionary["exception"] = exception
		}
		if message != nil{
			dictionary["message"] = message
		}
		if path != nil{
			dictionary["path"] = path
		}
		if status != nil{
			dictionary["status"] = status
		}
		if timestamp != nil{
			dictionary["timestamp"] = timestamp
		}
		return dictionary
	}

}
