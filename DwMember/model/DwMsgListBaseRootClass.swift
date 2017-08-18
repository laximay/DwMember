//
//	DwMsgListBaseRootClass.swift
//
//	Create by 靖 温 on 17/8/2017
//	Copyright © 2017. All rights reserved.
//	模型生成器（小波汉化）JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct DwMsgListBaseRootClass{

	var apiVerify : Bool!
	var code : Int!
	var data : [DwMsgListBaseData]!
	var msg : String!
	var result : String!
	var sign : AnyObject!
	var singleLogin : Bool!


	/**
	 * 用字典来初始化一个实例并设置各个属性值
	 */
	init(fromDictionary dictionary: NSDictionary){
		apiVerify = dictionary["apiVerify"] as? Bool
		code = dictionary["code"] as? Int
		data = [DwMsgListBaseData]()
		if let dataArray = dictionary["data"] as? [NSDictionary]{
			for dic in dataArray{
				let value = DwMsgListBaseData(fromDictionary: dic)
				data.append(value)
			}
		}
		msg = dictionary["msg"] as? String
		result = dictionary["result"] as? String
		sign = dictionary["sign"] as? AnyObject
		singleLogin = dictionary["singleLogin"] as? Bool
	}

	/**
	 * 把所有属性值存到一个NSDictionary对象，键是相应的属性名。
	 */
	func toDictionary() -> NSDictionary
	{
		var dictionary = NSMutableDictionary()
		if apiVerify != nil{
			dictionary["apiVerify"] = apiVerify
		}
		if code != nil{
			dictionary["code"] = code
		}
		if data != nil{
			var dictionaryElements = [NSDictionary]()
			for dataElement in data {
				dictionaryElements.append(dataElement.toDictionary())
			}
			dictionary["data"] = dictionaryElements
		}
		if msg != nil{
			dictionary["msg"] = msg
		}
		if result != nil{
			dictionary["result"] = result
		}
		if sign != nil{
			dictionary["sign"] = sign
		}
		if singleLogin != nil{
			dictionary["singleLogin"] = singleLogin
		}
		return dictionary
	}

}