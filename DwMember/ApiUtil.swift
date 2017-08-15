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

enum imageType: String{
    case ads = "ads" //首頁廣告
    case activitys = "activitys" //活動
    case features = "features" //功能
}

enum opentype: String{
    case WV , //WEBVIEW方式打開
     NA  //原生形式

}

open class ApiUtil{
    
    class func shareInstance()->ApiUtil{
        let apiUtil = ApiUtil();
        return apiUtil;
    }
    //服務鏈接
    static var serverUrl = "http://47.52.25.198"
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
    static func launchCache()   {
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
    
    
    
    
   
    
    
    
    func sign(data: [String: String] = [:]) -> String {
        var signStr = ""
        let defaults = UserDefaults.standard
        if let sercet = defaults.string(forKey: "dwsercet"){
            var data2 = data.sorted { (s1, s2) -> Bool in
                return s1 < s2
            }
            signStr = data2.map{ "\($0)=\($1)" }.joined(separator: "&")
            
            signStr.append("key=\(sercet)")
        }
        
        return signStr.md5().uppercased()
        
    }
    
    
    
    
    
    
    
}
