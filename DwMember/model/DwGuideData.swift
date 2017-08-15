//
//	DwGuideData.swift
//
//	Create by 靖 温 on 10/8/2017
//	Copyright © 2017. All rights reserved.
//	模型生成器（小波汉化）JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct DwGuideData{

	var ads : [DwGuideAd]!


	/**
	 * 用字典来初始化一个实例并设置各个属性值
	 */
	init(fromDictionary dictionary: NSDictionary){
		ads = [DwGuideAd]()
		if let adsArray = dictionary["ads"] as? [NSDictionary]{
			for dic in adsArray{
				let value = DwGuideAd(fromDictionary: dic)
				ads.append(value)
			}
		}
	}

	/**
	 * 把所有属性值存到一个NSDictionary对象，键是相应的属性名。
	 */
	func toDictionary() -> NSDictionary
	{
		let dictionary = NSMutableDictionary()
		if ads != nil{
			var dictionaryElements = [NSDictionary]()
			for adsElement in ads {
				dictionaryElements.append(adsElement.toDictionary())
			}
			dictionary["ads"] = dictionaryElements
		}
		return dictionary
	}

}
