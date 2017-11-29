//
//  WebViewController.swift
//  DwMember
//
//  Created by Wen Jing on 2017/8/7.
//  Copyright © 2017年 Wen Jing. All rights reserved.
//

import UIKit
import WebKit
class WebViewController: UIViewController, WKUIDelegate, WKNavigationDelegate {
    
    var url = ""
    var random = ""
    var cardNo = ""
    var type = ""
    var id = ""
    
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
        //webview.load(URLRequest.init(url: URL.init(string: "https://www.baidu.com/")!))
       
        if type == "OV" {
            webview.load(URLRequest.init(url: URL.init(string: url)!))
        }else {
        
            if let url = URL(string: "\(url)?imei=\(ApiUtil.idfv)&code=\(random)&cardNo=\(cardNo)&company=\(ApiUtil.companyCode)&id=\(id)"){
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
}
