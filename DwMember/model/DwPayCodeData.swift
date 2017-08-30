//
//	DwPayCodeData.swift
//
//	Create by 靖 温 on 19/8/2017
//	Copyright © 2017. All rights reserved.
//	模型生成器（小波汉化）JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct DwPayCodeData{

    var cardNo : String!
    var code : String!
    var timestamp : Int!
    
    
    /**
     * 用字典来初始化一个实例并设置各个属性值
     */
    init(fromDictionary dictionary: NSDictionary){
        cardNo = dictionary["cardNo"] as? String
        code = dictionary["code"] as? String
        timestamp = dictionary["timestamp"] as? Int
    }
    
    /**
     * 把所有属性值存到一个NSDictionary对象，键是相应的属性名。
     */
    func toDictionary() -> NSDictionary
    {
        let dictionary = NSMutableDictionary()
        if cardNo != nil{
            dictionary["cardNo"] = cardNo
        }
        if code != nil{
            dictionary["code"] = code
        }
        if timestamp != nil{
            dictionary["timestamp"] = timestamp
        }
        return dictionary
    }
    
}
