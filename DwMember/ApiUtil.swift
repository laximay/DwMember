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
    static var serverUrl = "http://192.168.90.52:8080"
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
    
    
    
    
    //加載首頁的遠程資源
    static func homeCache()  {
        Just.post(ApiUtil.homeApi ,  data: ["company": ApiUtil.companyCode]) { (result) in
            guard let json = result.json as? NSDictionary else{
                return
            }
            let datas = DwHomeRootClass(fromDictionary: json).data!
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            do{
                let allData : [DwCache] = try appDelegate.persistentContainer.viewContext.fetch(DwCache.fetchRequest())
                
                for ad in allData {
                   appDelegate.persistentContainer.viewContext.delete(ad)
                   appDelegate.saveContext()
                }
               
                
                datas.ads.map({(ad)  in
                    let ads  =  DwCache(context: appDelegate.persistentContainer.viewContext)
                    ads.image = ad.image
                    ads.briefing = ad.briefing
                    ads.english = ad.english
                    ads.name = ad.name
                    ads.opentype = ad.opentype
                    ads.simpChinese = ad.simpChinese
                    ads.sort = Int64(ad.sort)
                    ads.thumb = ad.thumb as! String
                    ads.url = ad.url
                    ads.type = "ads"
                    appDelegate.saveContext()
                    
                    
                })
                
                datas.activitys.map({(ad)  in
                    let activitys  =  DwCache(context: appDelegate.persistentContainer.viewContext)
                    activitys.image = ad.image
                    activitys.briefing = ad.briefing
                    activitys.english = ad.english
                    activitys.name = ad.name
                    activitys.opentype = ad.opentype
                    activitys.simpChinese = ad.simpChinese
                    activitys.sort = Int64(ad.sort)
                    activitys.thumb = ad.thumb as! String
                    activitys.url = ad.url
                    activitys.type = "activitys"
                    appDelegate.saveContext()
                    
                    
                })
            }catch{
                print(error)
            }
            
            
            
            
            
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
