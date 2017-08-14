//
//  File.swift
//  DwMember
//
//  Created by Wen Jing on 2017/8/10.
//  Copyright © 2017年 Wen Jing. All rights reserved.
//

import Foundation
import CoreData
import Just
class ApiUtil{
    
    class func shareInstance()->ApiUtil{
        let apiUtil = ApiUtil();
        return apiUtil;
    }
    //服務鏈接
    static var serverUrl = "http://192.168.90.78:8080"
    //公司代碼
    static var companyCode = "TaoHeung"
    //公司代碼
    static var channel = "IOS"
    //啟動頁Api
    static var launchApi = serverUrl + "/api/app/start"
    //引導頁Api
    static var guideApi = serverUrl + "/api/app/guide"
    //首頁Api
    static var homeApi = serverUrl + "/api/home"
    
    let encoding: String.Encoding = String.Encoding.utf8
    
    
    //加載引導頁的遠程資源
    func launchCache()   {
        Just.post(ApiUtil.launchApi ,  data: ["company": ApiUtil.companyCode]) { (result) in
            guard let json = result.json as? NSDictionary else{
                return
            }
            let datas = DwStartRootClass(fromDictionary: json).data!
            
            let defaults = UserDefaults.standard
            //如果点击了则把点过的动作标志保存到存储空间，以便启动时候检查
            defaults.set(datas.ads.image, forKey: "launchImageUrl")
        }
    }
    
    
    
    
    
    //加載首頁的遠程資源
    func homeCache()   {
        Just.post(ApiUtil.homeApi ,  data: ["company": ApiUtil.companyCode]) { (result) in
            guard let json = result.json as? NSDictionary else{
                return
            }
            let datas = DwHomeRootClass(fromDictionary: json).data!
            
            
            
          
        }
    }
    
    func sign(data: [String: Any] = [:]) -> String {
        var signStr = ""
        
       //排序并遍歷參數數據
        for key in data.keys.sorted(by: <) {
        let valueToSend: Any? = data[key] is NSNull ? "null" : data[key]
           signStr.append("\(key))=\(valueToSend)&")
        }
       
        let defaults = UserDefaults.standard
        
        if let sercet = defaults.string(forKey: "dwsercet"){
            signStr.append("key=\(sercet)")
        }

       
        return signStr.md5().uppercased()
        
    }
    
    func sign2(data: [String: Any] = [:]) -> String {
        var signStr = ""
        
        signStr = data.map{ "\($0)=\($1)" }.joined(separator: "&")
        
        
        let defaults = UserDefaults.standard
        
        if let sercet = defaults.string(forKey: "dwsercet"){
            signStr.append("key=\(sercet)")
        }
        
        
        
        return signStr.md5().uppercased()
        
    }
    
    
    
    
    

    
}
