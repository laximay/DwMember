//
//	DwStartRootClass.swift
//
//	Create by 靖 温 on 10/8/2017
//	Copyright © 2017. All rights reserved.
//	模型生成器（小波汉化）JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct DwStartRootClass{

	var apiVerify : Bool!
	var code : Int!
	var data : DwStartData!
	var msg : String!
	var result : String!
	var singleLogin : Bool!


	/**
	 * 用字典来初始化一个实例并设置各个属性值
	 */
	init(fromDictionary dictionary: NSDictionary){
		apiVerify = dictionary["apiVerify"] as? Bool
		code = dictionary["code"] as? Int
		if let dataData = dictionary["data"] as? NSDictionary{
				data = DwStartData(fromDictionary: dataData)
			}
		msg = dictionary["msg"] as? String
		result = dictionary["result"] as? String
		singleLogin = dictionary["singleLogin"] as? Bool
	}

	/**
	 * 把所有属性值存到一个NSDictionary对象，键是相应的属性名。
	 */
	func toDictionary() -> NSDictionary
	{
		let dictionary = NSMutableDictionary()
		if apiVerify != nil{
			dictionary["apiVerify"] = apiVerify
		}
		if code != nil{
			dictionary["code"] = code
		}
		if data != nil{
			dictionary["data"] = data.toDictionary()
		}
		if msg != nil{
			dictionary["msg"] = msg
		}
		if result != nil{
			dictionary["result"] = result
		}
		if singleLogin != nil{
			dictionary["singleLogin"] = singleLogin
		}
		return dictionary
	}

}
