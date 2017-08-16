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

struct webViewConfig{
    var code: String
    var verif: Bool
}

enum imageType: String{
    case ads = "ads" //首頁廣告
    case activitys = "activitys" //活動
    case features = "features" //功能
}

enum opentype: String{
    case WV , //WEBVIEW功能網頁方式打開
    NA,  //原生形式
    OV //外部第三方網頁
    
}

enum webViewType{
    case BIND(needFront : Bool,code : String)
    
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
    //登錄Api
    static var loginApi = serverUrl + "/api/member/login"
    //會員卡信息Api
    static var cardinfoApi = serverUrl + "/api/member/card"
    //未讀消息數量Api
    static var msgcountApi = serverUrl + "/api/message/count"
    //webView統一接口Api
    static var webviewApi = serverUrl + "/api/url"
    //統一編碼
    let encoding: String.Encoding = String.Encoding.utf8
    static let BIND = webViewConfig(code : "BIND", verif: false)
    static let mainSB = UIStoryboard(name: "Main", bundle: Bundle.main)

    
    static let idfv: String = "823676274628746"//UIDevice.current.identifierForVendor!.uuidString
    
    
    //加載引導頁的遠程資源-下次緩存
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
    
    //webView統一跳轉控制器
    static func webViewHandle(webCode: webViewConfig, sender: UIViewController ) {
        
        
        var avgs: [String: Any] = [:]
        if webCode.verif{
        
            let defaults = UserDefaults.standard
            let cardNo = defaults.string(forKey: "cardNo")
            avgs = ApiUtil.frontFunc()
            avgs.updateValue(cardNo!, forKey: "cardNo")
            let sign = ApiUtil.sign(data: avgs)
            avgs.updateValue(sign, forKey: "sign")
        }else{
            avgs.updateValue(ApiUtil.idfv, forKey: "imei")
        }
        avgs.updateValue(webCode.code, forKey: "type")
        dump(avgs)
        
        Just.post(ApiUtil.webviewApi ,  data: avgs) { (result) in
            guard let json = result.json as? NSDictionary else{
                return
            }
            print(json)
            if  DwCountBaseRootClass(fromDictionary: json).code == 1 {
                let datas = DwWebViewBaseRootClass(fromDictionary: json).data
                OperationQueue.main.addOperation {
                    if let datas = datas {
                        if let pageVC = ApiUtil.mainSB.instantiateViewController(withIdentifier: "WebViewController") as? WebViewController {
                            pageVC.url = datas.url
                            pageVC.random = datas.random
                            sender.navigationController?.pushViewController(pageVC, animated: true)
                        }
                    }
                }
                
            }else {
                
                //異常處理
            }
            
        }
    }
    
    //前置參數
    static func frontFunc()->[String: Any]{
        let timeInterval =  Int(NSDate().timeIntervalSince1970*1000)
        return  ["channel": ApiUtil.channel, "imei": ApiUtil.idfv, "timestamp": timeInterval]
    }
    
    //簽名方法
    static func sign(data: [String: Any] = [:]) -> String {
        var signStr = ""
        let defaults = UserDefaults.standard
        if let sercet = defaults.string(forKey: "dwsercet"){
            let data2 = data.sorted { (s1, s2) -> Bool in
                return s1.key > s2.key
            }
            signStr = data2.map{ "\($0)=\($1)" }.joined(separator: "&")
            
            signStr.append("&key=\(sercet)")
        }
        
        // dump(signStr)
        
        return signStr.md5().uppercased()
        
    }
    
    
    
    
    
    
    
}
