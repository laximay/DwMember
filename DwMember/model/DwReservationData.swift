//
//	DwReservationData.swift
//
//	Create by 靖 温 on 21/8/2017
//	Copyright © 2017. All rights reserved.
//	模型生成器（小波汉化）JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct DwReservationData{

	var reList : [DwReservationReList]!


	/**
	 * 用字典来初始化一个实例并设置各个属性值
	 */
	init(fromDictionary dictionary: NSDictionary){
		reList = [DwReservationReList]()
		if let reListArray = dictionary["reList"] as? [NSDictionary]{
			for dic in reListArray{
				let value = DwReservationReList(fromDictionary: dic)
				reList.append(value)
			}
		}
	}

	/**
	 * 把所有属性值存到一个NSDictionary对象，键是相应的属性名。
	 */
	func toDictionary() -> NSDictionary
	{
		let dictionary = NSMutableDictionary()
		if reList != nil{
			var dictionaryElements = [NSDictionary]()
			for reListElement in reList {
				dictionaryElements.append(reListElement.toDictionary())
			}
			dictionary["reList"] = dictionaryElements
		}
		return dictionary
	}

}
