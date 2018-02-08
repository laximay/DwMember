//
//	DwLoginCard.swift
//
//	Create by 靖 温 on 16/8/2017
//	Copyright © 2017. All rights reserved.
//	模型生成器（小波汉化）JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct DwLoginCard{

    var address : String!
    var balance : Double!
    var birthMonth : String!
    var cardno : String!
    var closedt : String!
    var email : String!
    var giftBalance : Double!
    var integral : Int!
    var memberName : String!
    var mobile : String!
    var sex : String!
    var stat : String!
    var isCustBirthMonth : Bool!
    var integralDesc : String!
    
    
    /**
     * 用字典来初始化一个实例并设置各个属性值
     */
    init(fromDictionary dictionary: NSDictionary){
        address = dictionary["address"] as? String
        balance = dictionary["balance"] as? Double
        birthMonth = dictionary["birthMonth"] as? String
        cardno = dictionary["cardno"] as? String
        closedt = dictionary["closedt"] as? String
        email = dictionary["email"] as? String
        giftBalance = dictionary["giftBalance"] as? Double
        integral = dictionary["integral"] as? Int
        memberName = dictionary["memberName"] as? String
        mobile = dictionary["mobile"] as? String
        sex = dictionary["sex"] as? String
        stat = dictionary["stat"] as? String
        isCustBirthMonth = dictionary["isCustBirthMonth"] as? Bool
        integralDesc = dictionary["integralDesc"] as? String
    }
    
    /**
     * 把所有属性值存到一个NSDictionary对象，键是相应的属性名。
     */
    func toDictionary() -> NSDictionary
    {
        let dictionary = NSMutableDictionary()
        if address != nil{
            dictionary["address"] = address
        }
        if balance != nil{
            dictionary["balance"] = balance
        }
        if birthMonth != nil{
            dictionary["birthMonth"] = birthMonth
        }
        if cardno != nil{
            dictionary["cardno"] = cardno
        }
        if closedt != nil{
            dictionary["closedt"] = closedt
        }
        if email != nil{
            dictionary["email"] = email
        }
        if giftBalance != nil{
            dictionary["giftBalance"] = giftBalance
        }
        if integral != nil{
            dictionary["integral"] = integral
        }
        if memberName != nil{
            dictionary["memberName"] = memberName
        }
        if mobile != nil{
            dictionary["mobile"] = mobile
        }
        if sex != nil{
            dictionary["sex"] = sex
        }
        if stat != nil{
            dictionary["stat"] = stat
        }
        if isCustBirthMonth != nil{
            dictionary["isCustBirthMonth"] = isCustBirthMonth
        }
        if integralDesc != nil{
            dictionary["integralDesc"] = integralDesc
        }
        return dictionary
    }
    
}
