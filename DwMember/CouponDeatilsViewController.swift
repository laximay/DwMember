//
//  CouponDeatilsTableViewController.swift
//  DwMember
//
//  Created by Wen Jing on 2017/8/19.
//  Copyright © 2017年 Wen Jing. All rights reserved.
//

import UIKit
import Just
import swiftScan
class CouponDeatilsViewController: UIViewController {
    
    
    @IBOutlet weak var bgImg: UIImageView!
    @IBOutlet weak var titleLab: UILabel!
    
    @IBOutlet weak var briefingLab: UILabel!
    
    @IBOutlet weak var validperiod: UILabel!
    
    @IBOutlet weak var exchangeMsgLab: UILabel!
    
    @IBOutlet weak var couponNumImg: UIImageView!
    
    @IBOutlet weak var submitView: UIView!
    @IBOutlet weak var couponNumView: UIView!
    @IBOutlet weak var closeBtn: UIButton!
    @IBOutlet weak var branchs: UILabel!
    @IBOutlet weak var branchsView: UIView!
    
    //基礎券列表:未用，已用，過期
    var couponBase:  CouponDetailsData?
    //商城券列表
    var couponMall: CouponMallDetailsData?
    
    var couponS: couponStatus = .unuse
    
    var couponId = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        switch couponS {
        case .mall:
            self.couponNumView.isHidden = true
            self.branchsView.isHidden = true
            self.submitView.isHidden = false
            getcouponMall()
        default:
            self.couponNumView.isHidden = false
            self.branchsView.isHidden = false
            self.submitView.isHidden = true
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
    
    @IBAction func exchangebtn(_ sender: Any) {
        exchange()
    }
    
    
    //加載未用優惠券列表
    func getcouponbase() {
            var avgs = ApiUtil.frontFunc()
            avgs.updateValue(couponId, forKey: "id")
            let sign = ApiUtil.sign(data: avgs, sender: self)
            avgs.updateValue(sign, forKey: "sign")
            dump(avgs)
            
            Just.post(ApiUtil.couponbaseApi ,  data: avgs) { (result) in
                guard let json = result.json as? NSDictionary else{
                    return
                }
                print("基礎详情：",json)
                if result.ok {
                    if  CouponDetailsRootClass(fromDictionary: json).code == 1 {
                        self.couponBase = CouponDetailsRootClass(fromDictionary: json).data
                        let attribstr = try! NSAttributedString.init(data:(self.couponBase?.descriptionField.data(using: String.Encoding.unicode))! , options: [NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType], documentAttributes: nil)
                        let barImg: UIImage = LBXScanWrapper.createCode128(codeString: (self.couponBase?.couponNo)!, size: self.couponNumImg.bounds.size, qrColor: UIColor.black, bkColor: UIColor.white)!
                        let blurEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .light))
                        blurEffectView.frame = self.bgImg.frame
                        
                        OperationQueue.main.addOperation {
                            
                            self.exchangeMsgLab.attributedText = attribstr
                            self.titleLab.text = self.couponBase?.title
                            self.briefingLab.text = self.couponBase?.couponNo
                            
                            self.validperiod.text = "使用期" + (self.couponBase?.useStartTime)! + "至" + (self.couponBase?.useEndTime)! + " " + (self.couponBase?.useDaysMsg)!
                            
                            self.bgImg.addSubview(blurEffectView)
                            let imgUrl = URL(string: (self.couponBase?.image)!)
                            self.bgImg.kf.setImage(with: imgUrl)
                            self.couponNumImg.image = barImg
                            self.branchs.text = "适用分店:" + (self.couponBase?.branchs)!
                            
                            
                            
                            
                        }
                    }else {
                        //異常處理
                        if let error: DwCountBaseRootClass = DwCountBaseRootClass(fromDictionary: json){
                            print("錯誤代碼:\(error.code as Int);信息:\(error.msg)原因:\(error.result)")
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
    
    
    //加載未用優惠券列表
    func getcouponMall() {
            var avgs = ApiUtil.frontFunc()
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
                            
                            let blurEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .light))
                            blurEffectView.frame = self.bgImg.frame
                            self.bgImg.addSubview(blurEffectView)
                            let imgUrl = URL(string: (self.couponMall?.image)!)
                            self.bgImg.kf.setImage(with: imgUrl)
                        }
                    }else {
                        //異常處理
                        if let error: DwCountBaseRootClass = DwCountBaseRootClass(fromDictionary: json){
                            print("錯誤代碼:\(error.code as Int);信息:\(error.msg)原因:\(error.result)")
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
    
    func exchange() {
            var avgs = ApiUtil.frontFunc()
            avgs.updateValue(couponId, forKey: "couponId")
            let sign = ApiUtil.sign(data: avgs, sender: self)
            avgs.updateValue(sign, forKey: "sign")
            dump(avgs)
            
            Just.post(ApiUtil.coupongetApi ,  data: avgs) { (result) in
                guard let json = result.json as? NSDictionary else{
                    return
                }
                print("商城详情：",json)
                if result.ok {
                    if  DwCountBaseRootClass(fromDictionary: json).code == 1 {
                        OperationQueue.main.addOperation {
                            self.openAlert()
                        }
                    }else{
                        if let error: DwCountBaseRootClass = DwCountBaseRootClass(fromDictionary: json){
                            print("錯誤代碼:\(error.code as Int);信息:\(error.msg)原因:\(error.result)")
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
    
    func openAlert()  {
        let menu = UIAlertController(title: "prompt", message: "exchange success", preferredStyle: .alert)
        let optionOK = UIAlertAction(title: "OK", style: .default) { (_) in
            //self.performSegue(withIdentifier: "couponMallSegue", sender: self)
            
//            if let pageVC = self.storyboard?.instantiateViewController(withIdentifier: "CouponViewController") as? CouponViewController {
//                pageVC.selectIndex = 0
//                //self.navigationController?.pushViewController(pageVC, animated: true)
//                self.present(pageVC, animated: true, completion: nil)
//            }
            self.performSegue(withIdentifier: "unwindToCouponList", sender: self)
            // self.dismiss(animated: true, completion: nil)
        }
        
        
        
        
        menu.addAction(optionOK)
        self.present(menu, animated: true, completion: nil)
    }
    
    
}
