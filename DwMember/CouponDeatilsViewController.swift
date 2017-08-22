//
//  CouponDeatilsTableViewController.swift
//  DwMember
//
//  Created by Wen Jing on 2017/8/19.
//  Copyright © 2017年 Wen Jing. All rights reserved.
//

import UIKit
import Just
class CouponDeatilsViewController: UIViewController {
    
    
    @IBOutlet weak var bgImg: UIImageView!
    @IBOutlet weak var titleLab: UILabel!
    
    @IBOutlet weak var briefingLab: UILabel!
    
    @IBOutlet weak var validperiod: UILabel!
    
    @IBOutlet weak var exchangeMsgLab: UILabel!
   
    @IBOutlet weak var closeBtn: UIButton!
    @IBAction func exchangebtn(_ sender: Any) {
    }
    //基礎券列表:未用，已用，過期
    var couponBase:  CouponDetailsData?
    //商城券列表
    var couponMall: CouponMallDetailsData?
    
    var couponS: couponStatus = .unuse
    
    var couponId = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        getcouponbase()
        
        switch couponS {
        case .mall:
            getcouponMall()
        default:
            getcouponbase()
        }
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    //加載未用優惠券列表
    func getcouponbase() {
        let defaults = UserDefaults.standard
        if let cardNo = defaults.string(forKey: "cardNo"){
            var avgs = ApiUtil.frontFunc()
            avgs.updateValue(cardNo, forKey: "cardNo")
            avgs.updateValue(couponId, forKey: "couponId")
            let sign = ApiUtil.sign(data: avgs, sender: self)
            avgs.updateValue(sign, forKey: "sign")
            dump(avgs)
            
            Just.post(ApiUtil.couponbaseApi ,  data: avgs) { (result) in
                guard let json = result.json as? NSDictionary else{
                    return
                }
                print("详情：",json)
                if result.ok {
                    if  CouponDetailsRootClass(fromDictionary: json).code == 1 {
                        self.couponBase = CouponDetailsRootClass(fromDictionary: json).data
                        let attribstr = try! NSAttributedString.init(data:(self.couponBase?.descriptionField.data(using: ApiUtil.encoding))! , options: [NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType], documentAttributes: nil)
                        OperationQueue.main.addOperation {
                            
                          self.exchangeMsgLab.attributedText = attribstr
                            
                        }
                    }else {
                        print(result.error ?? "未知错误")
                        //異常處理
                    }
                }else{
                    //處理接口系統錯誤
                    if let error: DwErrorBaseRootClass = DwErrorBaseRootClass(fromDictionary: json){
                        print("錯誤代碼:\(error.status);信息:\(error.message)原因:\(error.exception)")
                    }
                }
                
            }}
    }
    
    
    //加載未用優惠券列表
    func getcouponMall() {
        let defaults = UserDefaults.standard
        if let cardNo = defaults.string(forKey: "cardNo"){
            var avgs = ApiUtil.frontFunc()
            avgs.updateValue(cardNo, forKey: "cardNo")
            avgs.updateValue(couponId, forKey: "couponId")
            let sign = ApiUtil.sign(data: avgs, sender: self)
            avgs.updateValue(sign, forKey: "sign")
            dump(avgs)
            
            Just.post(ApiUtil.coupomallApi ,  data: avgs) { (result) in
                guard let json = result.json as? NSDictionary else{
                    return
                }
                print("详情：",json)
                if result.ok {
                    if  CouponMallDetailsRootClass(fromDictionary: json).code == 1 {
                        self.couponMall = CouponMallDetailsRootClass(fromDictionary: json).data
                         let attribstr = try! NSAttributedString.init(data:(self.couponMall?.exchangeMsg.data(using: String.Encoding.unicode))! , options: [NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType], documentAttributes: nil)
                        OperationQueue.main.addOperation {
                             self.titleLab.text = self.couponMall?.title
                             self.briefingLab.text = self.couponMall?.briefing
                             self.validperiod.text = "使用期" + (self.couponMall?.starttime)! + "至" + (self.couponMall?.endtime)!
                             self.exchangeMsgLab.attributedText = attribstr
                            
                            let blurEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .prominent))
                                blurEffectView.frame = self.bgImg.frame
                            self.bgImg.addSubview(blurEffectView)
                             let imgUrl = URL(string: (self.couponMall?.image)!)
                            self.bgImg.kf.setImage(with: imgUrl)
                        }
                    }else {
                        print(result.error ?? "未知错误")
                        //異常處理
                    }
                }else{
                    //處理接口系統錯誤
                    if let error: DwErrorBaseRootClass = DwErrorBaseRootClass(fromDictionary: json){
                        print("錯誤代碼:\(error.status);信息:\(error.message)原因:\(error.exception)")
                    }
                }
                
            }}
    }
    
    
}
