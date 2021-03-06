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

enum couponStatus: String{
    case unuse , //首頁廣告
    use,  //活動
    over, //功能
    mall //商城
}


//内部WEBVIEW请求参数CODE
enum webViewType: String{
    case BIND //註冊
    case MPWD //忘記密碼
    case DZXQ //訂座
    case FPWD //修改密碼
    case JFCX //積分記錄
    
    
}


enum articleType: String{
    case MEMINFO //會員須知
    case INTERULE //積分規則
    case COUPONRULE //優惠券規則
    case MEMTERMS //會員條款
    case ABOUTUS //關於我們
    case OTHERS //其他
}


// 原生跳轉映射[viewCode : Segue]
let nativeViews: [String: String] = ["couponNav": "couponMallSegue"]

// 內部H5配置[viewCode : Segue]
let inrwebView: [String: webViewConfig] = ["BIND": webViewConfig(code : "BIND", verif: false),
                                           "MPWD": webViewConfig(code : "MPWD", verif: false),
                                           "DZXQ": webViewConfig(code: "DZXQ", verif: true),
                                           "FPWD": webViewConfig(code: "FPWD", verif: true),
                                           "HDXQ": webViewConfig(code: "HDXQ", verif: false),
                                           "JFCX": webViewConfig(code: "JFCX", verif: true),
                            "HYJH": webViewConfig(code: "HYJH", verif: true)]

open class ApiUtil{
    
    class func shareInstance()->ApiUtil{
        let apiUtil = ApiUtil();
        return apiUtil;
    }
    
    //服務鏈接
    //static let serverUrl = "https://cloud.ablegenius.com/a"
    static var serverUrl = "http://192.168.90.220:8088"
    //公司代碼
    static let companyCode = "EPOT"
    //公司代碼
    static let channel = "IOS"
    //啟動頁Api
    static let launchApi = serverUrl + "/api/app/start"
    //引導頁Api
    static let guideApi = serverUrl + "/api/app/guide"
    //首頁Api
    static let homeApi = serverUrl + "/api/home"
    //登錄Api
    static let loginApi = serverUrl + "/api/member/login"
    //會員卡信息Api
    static let cardinfoApi = serverUrl + "/api/member/card"
    //未讀消息數量Api
    static let msgcountApi = serverUrl + "/api/message/count"
    //未用優惠券數量Api
    static let couponcountApi = serverUrl + "/api/coupon/count"
    //消息列表Api
    static let msglistApi = serverUrl + "/api/message/list"
    //已讀消息Api
    static let msgupdateApi = serverUrl + "/api/message/update"
    //未用優惠券Api
    static let couponunuseApi = serverUrl + "/api/coupon/unuse"
    //已用優惠券Api
    static let couponuseApi = serverUrl + "/api/coupon/used"
    //過期優惠券Api
    static let couponoverApi = serverUrl + "/api/coupon/over"
    //商城优惠券列表Api
    static let couponlistApi = serverUrl + "/api/coupon/list"
    //优惠券详情接口（未使用、已使用、已过期处调用）Api
    static let couponbaseApi = serverUrl + "/api/coupon/base/view"
    //优惠券详情接口（商城处调用）Api
    static let coupomallApi = serverUrl + "/api/coupon/view"
    //優惠券兌換Api
    static let coupongetApi = serverUrl + "/api/coupon/get"
    //付款码生成Ap
    static let paycodeApi = serverUrl + "/api/pay/code"
    //订座列表Api
    static let reservationApi = serverUrl + "/api/reservation/getMyReservation"
    //會員信息修改Api
    static let userinfoApi = serverUrl + "/api/member/update"
    //分店信息列表接口Api
    static let outletApi = serverUrl + "/api/outlet/list"
    
    //webView統一接口Api
    static let webviewApi = serverUrl + "/api/url"
    //webView統一接口Api
    static let webviewverifApi = serverUrl + "/api/verify/url"
    //版本更新Api
    static let updataApi = serverUrl + "/api/app/version"
    //文章獲取Api
    static let articleApi = serverUrl + "/api/app/article"
    
    //統一編碼
    static let encoding: String.Encoding = String.Encoding.utf8
    
    static let mainSB = UIStoryboard(name: "Main", bundle: Bundle.main)
    
    
    static let idfv: String =  UIDevice.current.identifierForVendor!.uuidString.replacingOccurrences(of: "-", with: "")
    
    
    
    //加載引導頁的遠程資源-下次緩存
    static func launchCache()   {
        Just.post(ApiUtil.launchApi ,  data: ["company": ApiUtil.companyCode]) { (result) in
            if result.ok {
                guard let json = result.json as? NSDictionary else{
                    return
                }
                let datas = DwStartRootClass(fromDictionary: json).data!
                
                let defaults = UserDefaults.standard
                //如果点击了则把点过的动作标志保存到存储空间，以便启动时候检查
                defaults.set(datas.ads.image, forKey: "launchImageUrl")
            }
            
        }
    }
    
    static func launchCache_New(_ completion: @escaping (String)->()) -> Void {
        Just.post(ApiUtil.launchApi ,  data: ["company": ApiUtil.companyCode]) { (result) in
            if result.ok {
                guard let json = result.json as? NSDictionary else{
                    return
                }
               // print(json)
                let datas = DwStartRootClass(fromDictionary: json).data!
                if let ads = datas.ads{
                   // let idx = Int(arc4random()) % ads.count
                     let launchUrl = ads.image
                    completion(launchUrl!)
                        
                    
                }
                
                
                
                
            }
            
        }
    }
    
    
    
    
    
    //檢測更新
    static func checkUpdata(sender: UIViewController)   {
        Just.post(ApiUtil.updataApi ,  data: ["company": ApiUtil.companyCode, "channel" : ApiUtil.channel]) { (result) in
            if result.ok {
                guard let json = result.json as? NSDictionary else{
                    return
                }
                //print(json)
                if let datas = DwUpdataRootClass(fromDictionary: json).data {
                    let cluodVersion = datas.versions
                    let defaults = UserDefaults.standard
                    if let localVersion = defaults.string(forKey: "localVersion"){
                        if localVersion != cluodVersion {
                            OperationQueue.main.addOperation {
                                
                                let menu = UIAlertController(title: nil, message: "please updata your apps", preferredStyle: .alert)
                                let optionOK = UIAlertAction(title: "Ok", style: .default, handler: { (_) in
                                    
                                    if let url = URL(string: datas.downloadUrl) {
                                        //根据iOS系统版本，分别处理
                                        if #available(iOS 10, *) {
                                            UIApplication.shared.open(url, options: [:],
                                                                      completionHandler: {
                                                                        (success) in
                                            })
                                        } else {
                                            UIApplication.shared.openURL(url)
                                        }
                                    }
                                    
                                })
                                if !datas.isMust {
                                    let optionCancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                                    menu.addAction(optionCancel)
                                    
                                }
                                
                                menu.addAction(optionOK)
                                sender.present(menu, animated: true, completion: nil)
                                
                            }
                        }
                    }else {
                        defaults.set(cluodVersion, forKey: "localVersion")
                    }
                    //如果点击了则把点过的动作标志保存到存储空间，以便启动时候检查
                    
                    
                }
                
                
                
            }
            
        }
    }
    
    //webView統一跳轉控制器
    static func webViewHandle(withIdentifier: String, id: String, sender: UIViewController ) {
        
        let webCode = inrwebView[withIdentifier]!
        //dump(webCode)
        var avgs: [String: Any] = [:]
        var url = ""
        if webCode.verif{
            avgs = ApiUtil.frontFunc()
            avgs.updateValue(webCode.code, forKey: "type")
            let sign = ApiUtil.sign(data: avgs, sender: sender)
            avgs.updateValue(sign, forKey: "sign")
            url = ApiUtil.webviewverifApi
            
        }else{
            
            avgs.updateValue(ApiUtil.idfv, forKey: "imei")
            avgs.updateValue(webCode.code, forKey: "type")
            url = ApiUtil.webviewApi
        }
        

        Just.post(url ,  data: avgs) { (result) in
            guard let json = result.json as? NSDictionary else{
                return
            }
            // print(json)
            if result.ok {
                if  DwCountBaseRootClass(fromDictionary: json).code == 1 {
                    let datas = DwWebViewBaseRootClass(fromDictionary: json).data
                    OperationQueue.main.addOperation {
                        if let datas = datas {
                            if let pageVC = ApiUtil.mainSB.instantiateViewController(withIdentifier: "WebViewController") as? WebViewController {
                                pageVC.url = datas.url
                                pageVC.random = datas.random
                                pageVC.id = id
                                if let cardNo: String = avgs["cardNo"] as? String {
                                    pageVC.cardNo = cardNo
                                }
                                sender.navigationController?.pushViewController(pageVC, animated: true)
                            }
                        }
                    }
                    
                }else {
                    //異常處理
                    if let error: DwCountBaseRootClass = DwCountBaseRootClass(fromDictionary: json){
                      //  print("錯誤代碼:\(error.code as Int);信息:\(error.msg)原因:\(error.result)")
                        OperationQueue.main.addOperation {
                            ApiUtil.openAlert(msg: error.msg, sender: sender)
                        }
                    }
                    
                }
            }else{
                //處理接口系統錯誤
                if let error: DwErrorBaseRootClass = DwErrorBaseRootClass(fromDictionary: json){
                   // print("錯誤代碼:\(error.status);信息:\(error.message)原因:\(error.exception)")
                    OperationQueue.main.addOperation {
                        ApiUtil.openAlert(msg: error.message, sender: sender)
                    }
                }
            }
            
        }
    }
    
    //前置參數
    static func frontFunc()->[String: Any]{
        let timeInterval =  Int(NSDate().timeIntervalSince1970*1000)
        let defaults = UserDefaults.standard
        
        
        guard (defaults.string(forKey: "cardNo") != nil) else {
            return  ["channel": ApiUtil.channel, "imei": ApiUtil.idfv, "timestamp": timeInterval]
        }
        let cardNo: String = defaults.string(forKey: "cardNo")!
        return  ["channel": ApiUtil.channel, "imei": ApiUtil.idfv, "timestamp": timeInterval, "cardNo" : cardNo]
        
    }
    
    //簽名方法
    static func sign(data: [String: Any] = [:], sender: UIViewController) -> String {
        var signStr = ""
        let defaults = UserDefaults.standard
        if let sercet = defaults.string(forKey: "dwsercet"){
            let data2 = data.sorted { (s1, s2) -> Bool in
                return s1.key > s2.key
            }
            signStr = data2.map{ "\($0)=\($1)" }.joined(separator: "&")
            
            signStr.append("&key=\(sercet)")
        }else {
            checklogin(sender: sender)
        }
        
        
        
        return signStr.md5().uppercased()
        
    }
    
    static func checklogin( sender: UIViewController){
        let defaults = UserDefaults.standard
        guard (defaults.string(forKey: "dwsercet") != nil) else{
            let menu = UIAlertController(title: nil, message: "please sign in", preferredStyle: .alert)
            let optionOK = UIAlertAction(title: "Ok", style: .default, handler: { (_) in
                
                if let pageVC = ApiUtil.mainSB.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController {
                    
                    //sender.self.navigationController?.pushViewController(pageVC, animated: true)
                    //sender.present(pageVC, animated: true, completion: nil)
                }
            })
            let optionCancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            menu.addAction(optionOK)
            menu.addAction(optionCancel)
            
            sender.present(menu, animated: true, completion: nil)
            
            return
        }
        
    }
    
    static func checklogin_me( sender: UIViewController){
        let defaults = UserDefaults.standard
        guard (defaults.string(forKey: "dwsercet") != nil) else{
            if let pageVC = ApiUtil.mainSB.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController {
                
                sender.self.navigationController?.pushViewController(pageVC, animated: true)
                //sender.present(pageVC, animated: true, completion: nil)
            }
            
            return
        }
        
    }
    
    
    static func openAlert(msg: String ,sender: UIViewController){
        
        let menu = UIAlertController(title: nil, message: msg, preferredStyle: .alert)
        
        let optionOK = UIAlertAction(title: "Ok", style: .default, handler: nil)
        menu.addAction(optionOK)
        
        sender.present(menu, animated: true, completion: nil)
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
}
