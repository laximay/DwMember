//
//  TempViewController.swift
//  DwMember
// 這個VIEW是用在TABBUTTON上面的，平常不用
//  Created by Wen Jing on 2017/11/24.
//  Copyright © 2017年 Wen Jing. All rights reserved.
//

import UIKit
import WebKit
import Just
class TempViewController: UIViewController  , WKUIDelegate, WKNavigationDelegate {
    
    lazy private var webview: WKWebView = {
    
    self.webview = WKWebView.init(frame: self.view.bounds)
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
    //    override func viewWillAppear(_ animated: Bool) {
    //        navigationController?.setNavigationBarHidden(false, animated: true)
    //    }
    
    override func viewDidLoad() {
    super.viewDidLoad()
        view.addSubview(webview)
        view.addSubview(progressView)
        webview.autoresizingMask = [.flexibleHeight]
        webview.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
       
    }
    
    override func viewDidAppear(_ animated: Bool) {
         webViewHandle(withIdentifier: "HYJH")
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
    
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
    //print("加载失败")
    ApiUtil.openAlert(msg: "加载失败", sender: self)
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
    decisionHandler(.allow);
    }
    
    override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    }
    
    deinit {
    webview.removeObserver(self, forKeyPath: "estimatedProgress")
    webview.uiDelegate = nil
    webview.navigationDelegate = nil
    }
    
    //webView統一跳轉控制器
     func webViewHandle(withIdentifier: String ) {
        
        let webCode = inrwebView[withIdentifier]!
        //dump(webCode)
        var avgs: [String: Any] = [:]
        var url = ""
        if webCode.verif{
            avgs = ApiUtil.frontFunc()
            avgs.updateValue(webCode.code, forKey: "type")
            let sign = ApiUtil.sign(data: avgs, sender: self)
            avgs.updateValue(sign, forKey: "sign")
            url = ApiUtil.webviewverifApi
            
        }else{
            
            avgs.updateValue(ApiUtil.idfv, forKey: "imei")
            avgs.updateValue(webCode.code, forKey: "type")
            url = ApiUtil.webviewApi
        }
        
        //dump(avgs)
        
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
//                            if let pageVC = ApiUtil.mainSB.instantiateViewController(withIdentifier: "WebViewController") as? WebViewController {
//                                pageVC.url = datas.url
//                                pageVC.random = datas.random
//                                if let cardNo: String = avgs["cardNo"] as? String {
//                                    pageVC.cardNo = cardNo
//                                }
//                                sender.navigationController?.pushViewController(pageVC, animated: true)
//                            }
                            //将 String类型转为Optional String类型为 封包 let cardNo: String! = avgs["cardNo"] as! String
                            //将Optional String 类型强制转换为String类型 成为强制拆包 使用時候 cardNo！
                            let cardNo: String! = avgs["cardNo"] as! String
                            let url: String! = datas.url
                            let random: String! = datas.random
                          
                            if let url = URL(string: "\(url!)?imei=\(ApiUtil.idfv)&code=\(random!)&cardNo=\(cardNo!)&company=\(ApiUtil.companyCode)"){
                                let request = URLRequest(url: url)
                                // webView.loadRequest(request)
                                self.webview.load(request) //使用更快，内存占用更小的的WKWEBVIEW 使用wkwebview需要注意在所在VIEW里面不勾选under top bars，要不然顶部会缩进去导航条里面
                            }
                        }
                    }
                    
                }else {
                    //異常處理
                    if let error: DwCountBaseRootClass = DwCountBaseRootClass(fromDictionary: json){
                      //  print("錯誤代碼:\(error.code as Int);信息:\(error.msg)原因:\(error.result)")
                        OperationQueue.main.addOperation {
                            ApiUtil.openAlert(msg: error.msg, sender: self)
                        }
                    }
                    
                }
            }else{
                //處理接口系統錯誤
                if let error: DwErrorBaseRootClass = DwErrorBaseRootClass(fromDictionary: json){
                    print("錯誤代碼:\(error.status);信息:\(error.message)原因:\(error.exception)")
                }
            }
            
        }
    }

}
