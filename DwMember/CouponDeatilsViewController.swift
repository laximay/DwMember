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
    
    
   
    @IBOutlet weak var titleLab: UILabel!
    
    @IBOutlet weak var briefingLab: UILabel!
    
    @IBOutlet weak var validperiod: UILabel!
    
    @IBOutlet weak var exchangeMsgLab: UILabel!
    
    @IBOutlet weak var couponNumImg: UIImageView!
    

    @IBOutlet weak var exchangeBtn: UIButton!
    
    @IBOutlet weak var branchs: UILabel!
  
    
    @IBOutlet weak var couponContentView: UIView!
    
    @IBOutlet weak var popLab: UILabel!
    
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
            self.popLab.isHidden = true
            self.briefingLab.isHidden = true
            self.couponNumImg.isHidden = true
            self.branchs.isHidden = true
            self.exchangeBtn.isHidden = false
            getcouponMall()
        default:
             self.popLab.isHidden = false
            self.couponNumImg.isHidden = false
             self.briefingLab.isHidden = false
            self.branchs.isHidden = false
            self.exchangeBtn.isHidden = true
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
           
            if result.ok {
                if  CouponDetailsRootClass(fromDictionary: json).code == 1 {
                    self.couponBase = CouponDetailsRootClass(fromDictionary: json).data
                    let attribstr = try! NSAttributedString.init(data:(self.couponBase?.descriptionField.data(using: String.Encoding.unicode))! , options: [NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType], documentAttributes: nil)
                       let barImg: UIImage = LBXScanWrapper.createCode128(codeString: (self.couponBase?.couponNo)!, size: self.couponNumImg.bounds.size, qrColor: UIColor.black, bkColor: UIColor.white)!
                  
                    
                    OperationQueue.main.addOperation {
                        
                        self.exchangeMsgLab.attributedText = attribstr
                        self.titleLab.text = self.couponBase?.title
                        self.briefingLab.text = self.couponBase?.couponNo
                        
                        self.validperiod.text = NSLocalizedString("Valid period", comment: "有效期") + (self.couponBase?.useStartTime)! + NSLocalizedString("To", comment: "至") + (self.couponBase?.useEndTime)! + " " + (self.couponBase?.useDaysMsg)!
                        
                          self.couponNumImg.image = barImg
                        self.branchs.text = "适用分店:" + (self.couponBase?.branchs)!
                        
                        
                        
                        
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
           
            if result.ok {
                if  CouponMallDetailsRootClass(fromDictionary: json).code == 1 {
                    self.couponMall = CouponMallDetailsRootClass(fromDictionary: json).data
                    let attribstr = try! NSAttributedString.init(data:(self.couponMall?.exchangeMsg.data(using: String.Encoding.unicode))! , options: [NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType], documentAttributes: nil)
                    OperationQueue.main.addOperation {
                        self.titleLab.text = self.couponMall?.title
                        self.briefingLab.text = self.couponMall?.briefing
                        self.validperiod.text = NSLocalizedString("Valid period", comment: "有效期") + (self.couponMall?.starttime)! + NSLocalizedString("To", comment: "至") + (self.couponMall?.endtime)!
                        self.exchangeMsgLab.attributedText = attribstr
                        
                       
                    }
                }else {
                    //異常處理
                    if let error: DwCountBaseRootClass = DwCountBaseRootClass(fromDictionary: json){
                        //print("錯誤代碼:\(error.code as Int);信息:\(error.msg)原因:\(error.result)")
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
        exchangeBtn.isEnabled = false
        var avgs = ApiUtil.frontFunc()
        avgs.updateValue(couponId, forKey: "couponId")
        let sign = ApiUtil.sign(data: avgs, sender: self)
        avgs.updateValue(sign, forKey: "sign")
        dump(avgs)
        
        Just.post(ApiUtil.coupongetApi ,  data: avgs) { (result) in
            guard let json = result.json as? NSDictionary else{
                return
            }
            //print("商城详情：",json)
            if result.ok {
                if  DwCountBaseRootClass(fromDictionary: json).code == 1 {
                    OperationQueue.main.addOperation {
                        self.openAlert()
                        self.exchangeBtn.isEnabled = true
                    }
                }else{
                    if let error: DwCountBaseRootClass = DwCountBaseRootClass(fromDictionary: json){
                       // print("錯誤代碼:\(error.code as Int);信息:\(error.msg)原因:\(error.result)")
                        OperationQueue.main.addOperation {
                            ApiUtil.openAlert(msg: error.msg, sender: self)
                            self.exchangeBtn.isEnabled = true
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
        let menu = UIAlertController(title: "提示", message: "兌換成功!", preferredStyle: .alert)
        let optionOK = UIAlertAction(title: "OK", style: .default) { (_) in
            let appdelegate = UIApplication.shared.delegate as! AppDelegate
            appdelegate.couponView.getCouponCount(isupdata: true) //更新数目
            self.performSegue(withIdentifier: "unwindToCouponList", sender: self)
            // self.dismiss(animated: true, completion: nil)
        }
        
        
        
        
        menu.addAction(optionOK)
        self.present(menu, animated: true, completion: nil)
    }
    
    
    
}
