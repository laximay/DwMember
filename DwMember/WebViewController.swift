//
//  WebViewController.swift
//  DwMember
//
//  Created by Wen Jing on 2017/8/7.
//  Copyright © 2017年 Wen Jing. All rights reserved.
//

import UIKit
import WebKit
class WebViewController: UIViewController {

   
    @IBOutlet weak var webView: UIWebView!
    var url = ""
    var random = ""
    var cardNo = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //访问http协议的网址需要在info.plist里面打开限制
        webView.isHidden = true
        let wkWebView = WKWebView(frame: view.frame)
        view.addSubview(wkWebView)
        //加入高度自适应，这样底部也不会缩进去
        wkWebView.autoresizingMask = [.flexibleHeight]
        print( "\(url)?imei=\(ApiUtil.idfv)&code=\(random)&cardNo=\(cardNo)")
        if let url = URL(string: "\(url)?imei=\(ApiUtil.idfv)&code=\(random)&cardNo=\(cardNo)"){
            let request = URLRequest(url: url)
            // webView.loadRequest(request)
            wkWebView.load(request) //使用更快，内存占用更小的的WKWEBVIEW 使用wkwebview需要注意在所在VIEW里面不勾选under top bars，要不然顶部会缩进去导航条里面
        }
        
       

    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
