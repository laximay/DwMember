//
//	CouponDetailsData.swift
//
//	Create by 靖 温 on 17/8/2017
//	Copyright © 2017. All rights reserved.
//	模型生成器（小波汉化）JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct CouponDetailsData{

	var branchs : String!
	var couponConfig : String!
	var couponType : String!
	var descriptionField : String!
	var externalNum : String!
	var id : String!
	var image : String!
	var title : String!


	/**
	 * 用字典来初始化一个实例并设置各个属性值
	 */
	init(fromDictionary dictionary: NSDictionary){
		branchs = dictionary["branchs"] as? String
		couponConfig = dictionary["couponConfig"] as? String
		couponType = dictionary["couponType"] as? String
		descriptionField = dictionary["description"] as? String
		externalNum = dictionary["externalNum"] as? String
		id = dictionary["id"] as? String
		image = dictionary["image"] as? String
		title = dictionary["title"] as? String
	}

	/**
	 * 把所有属性值存到一个NSDictionary对象，键是相应的属性名。
	 */
	func toDictionary() -> NSDictionary
	{
		var dictionary = NSMutableDictionary()
		if branchs != nil{
			dictionary["branchs"] = branchs
		}
		if couponConfig != nil{
			dictionary["couponConfig"] = couponConfig
		}
		if couponType != nil{
			dictionary["couponType"] = couponType
		}
		if descriptionField != nil{
			dictionary["description"] = descriptionField
		}
		if externalNum != nil{
			dictionary["externalNum"] = externalNum
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