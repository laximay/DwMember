//
//	DwPageListData.swift
//
//	Create by 靖 温 on 26/1/2018
//	Copyright © 2018. All rights reserved.
//	模型生成器（小波汉化）JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct DwPageListData{

	var pageList : [DwPageListPageList]!


	/**
	 * 用字典来初始化一个实例并设置各个属性值
	 */
	init(fromDictionary dictionary: NSDictionary){
		pageList = [DwPageListPageList]()
		if let pageListArray = dictionary["pageList"] as? [NSDictionary]{
			for dic in pageListArray{
				let value = DwPageListPageList(fromDictionary: dic)
				pageList.append(value)
			}
		}
	}

	/**
	 * 把所有属性值存到一个NSDictionary对象，键是相应的属性名。
	 */
	func toDictionary() -> NSDictionary
	{
		var dictionary = NSMutableDictionary()
		if pageList != nil{
			var dictionaryElements = [NSDictionary]()
			for pageListElement in pageList {
				dictionaryElements.append(pageListElement.toDictionary())
			}
			dictionary["pageList"] = dictionaryElements
		}
		return dictionary
	}

}