//
//  WebViewController.swift
//  DwMember
//
//  Created by Wen Jing on 2017/8/7.
//  Copyright © 2017年 Wen Jing. All rights reserved.
//

import UIKit
import WebKit
class WebViewController: UIViewController, WKUIDelegate, WKNavigationDelegate, WKScriptMessageHandler {
    /*H5頁面調用原生代碼
     1.繼承:WKScriptMessageHandler
     2.實現 userContentController方法
     3.註冊 WKWebViewConfiguration
     */
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        ApiUtil.checklogin(sender: self)
        switch message.name {
        case "externalsite":
             let prams = getDictionaryFromJSONString(jsonString: message.body as! String)
              let url = prams["url"] as! String
              let id =  prams["id"] as! String
              ApiUtil.webViewHandleNativ(webCode: url , id: id , sender: self)
            
            
            
        case "openQrCode":
            if let payVC = mainSB.instantiateViewController(withIdentifier: "PayViewController") as? PayViewController{
//            self.navigationController?.pushViewController(payVC, animated: true)
              self.present(payVC, animated: true, completion: nil)
            }
         case "clearCache":
            clearCacheBtnClick();
        case "loginOut":
            if let loginVC = loginSB.instantiateViewController(withIdentifier: "LoginViewController")  as? LoginViewController{
            self.navigationController?.pushViewController(loginVC, animated: true)
            }
//            self.present(loginVC, animated: true, completion: nil)
        case "branchMap":
            if let pageVC = barnchsSB.instantiateViewController(withIdentifier: "BranchsMapViewController")   as? BranchsMapViewController{
                self.navigationController?.pushViewController(pageVC, animated: true)
            }
        case "scan":
            if let scanVC = mainSB.instantiateViewController(withIdentifier: "ScanViewController")   as? ScanViewController{
                self.navigationController?.pushViewController(scanVC, animated: true)
            }
        case "encrypt":
            //H5請求如需加密,則需調用此方法進行簽名
            var avgs = ApiUtil.frontFunc()
          
             let prams = getDictionaryFromJSONString(jsonString: message.body as! String)
                for (key, value) in prams{
                    let valueStr = value as! String
                    if(!valueStr.isEmpty ){
                    avgs.updateValue(valueStr, forKey: key as! String)
                    }
                }
            
            let sign = ApiUtil.sign(data: avgs, sender: self)
            avgs.updateValue(sign, forKey: "sign")
            let data : NSData! = try! JSONSerialization.data(withJSONObject: avgs, options: []) as NSData?
                let JSONString = NSString(data:data as Data,encoding: String.Encoding.utf8.rawValue)
                webview.evaluateJavaScript("window.nativeCallBack('\(JSONString!)')") { (a, b) in
                    print(#function)
                }
        case "currentVersion":
            let data : NSData! = try! JSONSerialization.data(withJSONObject: ["currentVersion": currentVersion], options: []) as NSData?
            let JSONString = NSString(data:data as Data,encoding: String.Encoding.utf8.rawValue)
            webview.evaluateJavaScript("window.nativeCallBack('\(JSONString!)')") { (a, b) in
                print(#function)
            }
        case "pagelist":
             let prams = getDictionaryFromJSONString(jsonString: message.body as! String)
                let index = prams["index"] as! String
                ApiUtil.getPageList(sender: self, index: Int(index)!)
            
        default: break
            
        }
        
    }
    let barnchsSB = UIStoryboard(name: "Find", bundle: Bundle.main)
    let mainSB = UIStoryboard(name: "Main", bundle: Bundle.main)
    let loginSB = UIStoryboard(name: "Login", bundle: Bundle.main)
    var url = ""
    var random = ""
    var cardNo = ""
    var type = ""
    var id = ""
    let currentVersion = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String

    lazy private var webview: WKWebView = {
        //註冊H5調用原生 WKWebViewConfiguration
        let config = WKWebViewConfiguration()
        config.userContentController.add(self, name: "externalsite")
        config.userContentController.add(self, name: "openQrCode")
        config.userContentController.add(self, name: "clearCache")
        config.userContentController.add(self, name: "loginOut")
        config.userContentController.add(self, name: "branchMap")
        config.userContentController.add(self, name: "scan")
        config.userContentController.add(self, name: "encrypt")
        config.userContentController.add(self, name: "currentVersion")
        config.userContentController.add(self, name: "pagelist")
       //注入JS到H5
       // let script = WKUserScript(source: self.script, injectionTime: .atDocumentEnd, forMainFrameOnly: true)
       //config.userContentController.addUserScript(script)
        self.webview = WKWebView.init(frame: self.view.bounds, configuration: config)
        self.webview.uiDelegate = self
        self.webview.navigationDelegate = self
        return self.webview
    }()
    
    lazy private var progressView: UIProgressView = {
        self.progressView = UIProgressView.init(frame: CGRect(x: CGFloat(0), y: CGFloat(0), width: UIScreen.main.bounds.width, height: 3))
        self.progressView.tintColor = UIColor.green      // 进度条颜色
        self.progressView.trackTintColor = UIColor.white // 进度条背景色
        return self.progressView
    }()
    //如果首頁隱藏了導航欄一定要加上這句
        override func viewWillAppear(_ animated: Bool) {
            webview.evaluateJavaScript("window.refPage()") { (a, b) in
                print(#function)
            }
            
            if type == "index" {
            navigationController?.setNavigationBarHidden(true, animated: true)
            }else {
            navigationController?.setNavigationBarHidden(false, animated: true)
            }
            navigationController?.navigationBar.isTranslucent = false;
        }

    override var prefersStatusBarHidden: Bool{
        return true
    }
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    override func viewDidLoad() {
        
        super.viewDidLoad()
        //設置頂部欄顏色
        setStatusBarBackgroundColor(color: UIColor(red: 195/255.0, green: 33/255.0, blue: 1/255.0, alpha: 1))
        
        //註冊推送
        JPUSHService.setAlias(ApiUtil.idfv, completion: nil, seq: 1)
        JPUSHService.setTags([ApiUtil.companyCode+ApiUtil.serial], completion: nil, seq: 2)
        
        view.addSubview(webview)
        view.addSubview(progressView)
        webview.autoresizingMask = [.flexibleHeight]
        webview.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
        //webview.load(URLRequest.init(url: URL.init(string: "https://www.baidu.com/")!))
//        let timeInterval =  Int(NSDate().timeIntervalSince1970*1000)
        if cardNo == "" {
            let defaults = UserDefaults.standard
            if (defaults.string(forKey: "cardNo") != nil) {
            cardNo = defaults.string(forKey: "cardNo")!
            }
        }
       
       
        if  type == "index" {
            webview.load(URLRequest.init(url: URL.init(string: url)!))
        }else if type == "OV" {
            if let url = URL(string: "\(url)&imei=\(ApiUtil.idfv)&cardNo=\(cardNo)&company=\(ApiUtil.companyCode)&serial=\(ApiUtil.serial)"){
              print(url.absoluteString)
                let request = URLRequest(url: url)
                // webView.loadRequest(request)
                webview.load(request) //使用更快，内存占用更小的的WKWEBVIEW 使用wkwebview需要注意在所在VIEW里面不勾选under top bars，要不然顶部会缩进去导航条里面
            }
        }else {
            if let url = URL(string: "\(url)?imei=\(ApiUtil.idfv)&code=\(random)&cardNo=\(cardNo)&company=\(ApiUtil.companyCode)&id=\(id)&serial=\(ApiUtil.serial)"){
                let request = URLRequest(url: url)
                // webView.loadRequest(request)
                webview.load(request) //使用更快，内存占用更小的的WKWEBVIEW 使用wkwebview需要注意在所在VIEW里面不勾选under top bars，要不然顶部会缩进去导航条里面
            }
        }
    }
    
    
    
    
 
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        if keyPath == "estimatedProgress"{
            progressView.alpha = 1.0
            progressView.setProgress(Float(webview.estimatedProgress), animated: true)
            if webview.estimatedProgress >= 1.0 {
                UIView.animate(withDuration: 0.3, delay: 0.1, options: .curveEaseOut, animations: {
                    self.progressView.alpha = 0
                }, completion: { (finish) in
                    self.progressView.setProgress(0.0, animated: false)
                })
            }
        }
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        //print("开始加载")
    }
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        //print("开始获取网页内容")
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        //print("加载完成")
        self.title = webView.title
        
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        //print("加载失败")
        ApiUtil.openAlert(msg: "加载失败", sender: self)
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        decisionHandler(.allow);
    }
    
    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            completionHandler()
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    // 监听通过JS调用提示框
    func webView(_ webView: WKWebView, runJavaScriptConfirmPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (Bool) -> Void) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            completionHandler(true)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { (action) in
            completionHandler(false)
        }))
        self.present(alert, animated: true, completion: nil)
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    deinit {
        webview.removeObserver(self, forKeyPath: "estimatedProgress")
        webview.uiDelegate = nil
        webview.navigationDelegate = nil
    }
    
    //開始清除緩存
    func clearCacheBtnClick(){
        
        //提示框
        let message = self.cacheSize
        let alert = UIAlertController(title: "清除缓存", message: message, preferredStyle:UIAlertController.Style.alert)
        let alertConfirm = UIAlertAction(title: "确定", style:UIAlertAction.Style.default) { (alertConfirm) ->Void in
            self.clearCache()
        }
        alert.addAction(alertConfirm)
        let cancle = UIAlertAction(title: "取消", style:UIAlertAction.Style.cancel) { (cancle) ->Void in
        }
        alert.addAction(cancle)
        //提示框弹出
        self.present(alert, animated: true, completion: nil)
    }
    
    var cacheSize: String{
        get{
            // 路径
            let basePath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first
            let fileManager = FileManager.default
            // 遍历出所有缓存文件加起来的大小
            func caculateCache() -> Float{
                var total: Float = 0
                if fileManager.fileExists(atPath: basePath!){
                    let childrenPath = fileManager.subpaths(atPath: basePath!)
                    if childrenPath != nil{
                        for path in childrenPath!{
                            let childPath = basePath!.appending("/").appending(path)
                            do{
                                let attr:NSDictionary = try fileManager.attributesOfItem(atPath: childPath) as NSDictionary
                                let fileSize = attr["NSFileSize"] as! Float
                                total += fileSize
                                
                            }catch _{
                                
                            }
                        }
                    }
                }
                // 缓存文件大小
                return total
            }
            // 调用函数
            let totalCache = caculateCache()
            return NSString(format: "%.2f MB", totalCache / 1024.0 / 1024.0 ) as String
        }
    }
    
    /// 清除缓存
    ///
    /// - returns: 是否清理成功
    func clearCache()  {
        var result = true
        // 取出cache文件夹目录 缓存文件都在这个目录下
        let cachePath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first
        // 取出文件夹下所有文件数组
        let fileArr = FileManager.default.subpaths(atPath: cachePath!)
        // 遍历删除
        for file in fileArr! {
            // 拼接文件路径
            let path = cachePath?.appending("/\(file)")
            if FileManager.default.fileExists(atPath: path!) {
                // 循环删除
                do {
                    try FileManager.default.removeItem(atPath: path!)
                } catch {
                    // 删除失败
                    result = false
                }
            }
        }
        // return result
    }
    
    
    func setStatusBarBackgroundColor(color : UIColor) {
        let statusBarWindow : UIView = UIApplication.shared.value(forKey: "statusBarWindow") as! UIView
        let statusBar : UIView = statusBarWindow.value(forKey: "statusBar") as! UIView
        /*
         if statusBar.responds(to:Selector("setBackgroundColor:")) {
         statusBar.backgroundColor = color
         }*/
        if statusBar.responds(to:#selector(setter: UIView.backgroundColor)) {
            statusBar.backgroundColor = color
        }
    }
    
    func getDictionaryFromJSONString(jsonString:String) ->NSDictionary{
        
        let jsonData:Data = jsonString.data(using: .utf8)!
        
        let dict = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers)
        if dict != nil {
            return dict as! NSDictionary
        }
        return NSDictionary()
        
        
    }
}
