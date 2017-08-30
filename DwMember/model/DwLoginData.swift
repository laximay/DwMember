//
//	DwLoginData.swift
//
//	Create by 靖 温 on 16/8/2017
//	Copyright © 2017. All rights reserved.
//	模型生成器（小波汉化）JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct DwLoginData{

	var card : DwLoginCard!


	/**
	 * 用字典来初始化一个实例并设置各个属性值
	 */
	init(fromDictionary dictionary: NSDictionary){
		if let cardData = dictionary["card"] as? NSDictionary{
				card = DwLoginCard(fromDictionary: cardData)
			}
	}

	/**
	 * 把所有属性值存到一个NSDictionary对象，键是相应的属性名。
	 */
	func toDictionary() -> NSDictionary
	{
		let dictionary = NSMutableDictionary()
		if card != nil{
			dictionary["card"] = card.toDictionary()
		}
		return dictionary
	}

}
