//
//	DwBranchsData.swift
//
//	Create by 靖 温 on 28/8/2017
//	Copyright © 2017. All rights reserved.
//	模型生成器（小波汉化）JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct DwBranchsData{

	var address : String!
	var code : String!
	var companyName : String!
	var id : String!
	var isReservation : String!
	var name1 : String!
	var name2 : String!
	var regionName : String!
	var telphone : String!
    var image : String!
    var latitude :  String!
    var longitude :  String!
    var distance :  Int!



	/**
	 * 用字典来初始化一个实例并设置各个属性值
	 */
	init(fromDictionary dictionary: NSDictionary){
		address = dictionary["address"] as? String
		code = dictionary["code"] as? String
		companyName = dictionary["companyName"] as? String
		id = dictionary["id"] as? String
		isReservation = dictionary["isReservation"] as? String
		name1 = dictionary["name1"] as? String
		name2 = dictionary["name2"] as? String
		regionName = dictionary["regionName"] as? String
		telphone = dictionary["telphone"] as? String
        distance = dictionary["distance"] as? Int
        image = dictionary["image"] as? String
        latitude = dictionary["latitude"] as? String
        longitude = dictionary["longitude"] as? String
	}

	/**
	 * 把所有属性值存到一个NSDictionary对象，键是相应的属性名。
	 */
	func toDictionary() -> NSDictionary
	{
		var dictionary = NSMutableDictionary()
		if address != nil{
			dictionary["address"] = address
		}
		if code != nil{
			dictionary["code"] = code
		}
		if companyName != nil{
			dictionary["companyName"] = companyName
		}
		if id != nil{
			dictionary["id"] = id
		}
		if isReservation != nil{
			dictionary["isReservation"] = isReservation
		}
		if name1 != nil{
			dictionary["name1"] = name1
		}
		if name2 != nil{
			dictionary["name2"] = name2
		}
		if regionName != nil{
			dictionary["regionName"] = regionName
		}
		if telphone != nil{
			dictionary["telphone"] = telphone
		}
        if image != nil{
            dictionary["image"] = image
        }
        if latitude != nil{
            dictionary["latitude"] = latitude
        }
        if longitude != nil{
            dictionary["longitude"] = longitude
        }
        if distance != nil{
            dictionary["distance"] = distance
        }
		return dictionary
	}

}
