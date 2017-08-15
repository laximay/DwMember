//
//	DwHomeData.swift
//
//	Create by 靖 温 on 11/8/2017
//	Copyright © 2017. All rights reserved.
//	模型生成器（小波汉化）JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct DwHomeData{

	var activitys : [DwHomeActivity]!
	var ads : [DwHomeActivity]!
	var features : [DwHomeFeature]!


	/**
	 * 用字典来初始化一个实例并设置各个属性值
	 */
	init(fromDictionary dictionary: NSDictionary){
		activitys = [DwHomeActivity]()
		if let activitysArray = dictionary["activitys"] as? [NSDictionary]{
			for dic in activitysArray{
				let value = DwHomeActivity(fromDictionary: dic)
				activitys.append(value)
			}
		}
		ads = [DwHomeActivity]()
		if let adsArray = dictionary["ads"] as? [NSDictionary]{
			for dic in adsArray{
				let value = DwHomeActivity(fromDictionary: dic)
				ads.append(value)
			}
		}
		features = [DwHomeFeature]()
		if let featuresArray = dictionary["features"] as? [NSDictionary]{
			for dic in featuresArray{
				let value = DwHomeFeature(fromDictionary: dic)
				features.append(value)
			}
		}
	}

	/**
	 * 把所有属性值存到一个NSDictionary对象，键是相应的属性名。
	 */
	func toDictionary() -> NSDictionary
	{
		let dictionary = NSMutableDictionary()
		if activitys != nil{
			var dictionaryElements = [NSDictionary]()
			for activitysElement in activitys {
				dictionaryElements.append(activitysElement.toDictionary())
			}
			dictionary["activitys"] = dictionaryElements
		}
		if ads != nil{
			var dictionaryElements = [NSDictionary]()
			for adsElement in ads {
				dictionaryElements.append(adsElement.toDictionary())
			}
			dictionary["ads"] = dictionaryElements
		}
		if features != nil{
			var dictionaryElements = [NSDictionary]()
			for featuresElement in features {
				dictionaryElements.append(featuresElement.toDictionary())
			}
			dictionary["features"] = dictionaryElements
		}
		return dictionary
	}

}
