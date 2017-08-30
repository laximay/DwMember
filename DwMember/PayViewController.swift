//
//  PayViewController.swift
//  DwMember
//
//  Created by Wen Jing on 2017/7/31.
//  Copyright © 2017年 Wen Jing. All rights reserved.
//

import UIKit
import Just
import swiftScan
class PayViewController: UIViewController {
    
    @IBOutlet weak var barcodeImg: UIImageView!
    @IBOutlet weak var qrcodeImg: UIImageView!
    @IBOutlet weak var btnClose: UIButton!
    @IBOutlet weak var countTimeLab: UILabel!
    @IBOutlet weak var msgLab: UILabel!
    //定义计时器
    private var countdownTimer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //开启倒计时
        self.isCounting = true
        //getpaycode()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
          ApiUtil.checklogin(sender: self)
    }
    
    @IBAction func actionClose(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        self.isCounting = false
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
    
    //加载支付码
    func getpaycode() {
        
            var avgs = ApiUtil.frontFunc()
        
            let sign = ApiUtil.sign(data: avgs, sender: self)
            avgs.updateValue(sign, forKey: "sign")
            //dump(avgs)
            
            Just.post(ApiUtil.paycodeApi ,  data: avgs) { (result) in
                guard let json = result.json as? NSDictionary else{
                    return
                }
                print("详情：",json)
                if result.ok {
                    if  DwPayCodeRootClass(fromDictionary: json).code == 1 {
                        let payData: DwPayCodeData = DwPayCodeRootClass(fromDictionary: json).data
                      
                        let resignData :[String: Any] = ["cardNo": payData.cardNo, "code": payData.code, "timestamp": payData.timestamp ]
                        
                        let resign = ApiUtil.sign(data: resignData, sender: self)
                      
                        if DwPayCodeRootClass(fromDictionary: json).sign != resign {
                            OperationQueue.main.addOperation {
                            self.msgLab.text = "安全验证失败！"
                            self.msgLab.isHidden = false
                            }
                            return
                        }else{
                            
                            let qrImg: UIImage = LBXScanWrapper.createCode(codeType: "CIQRCodeGenerator",codeString:payData.code, size: self.qrcodeImg.bounds.size, qrColor: UIColor.black, bkColor: UIColor.white
                                )!
                            let barImg: UIImage = LBXScanWrapper.createCode128(codeString: payData.code, size: self.barcodeImg.bounds.size, qrColor: UIColor.black, bkColor: UIColor.white)!
                            
                            OperationQueue.main.addOperation {
                                //生成二维码
                                
                                self.qrcodeImg.image = qrImg
                                
                                
                                //生成条码
            
                                
                                self.barcodeImg.image = barImg
                            }
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
    
    
    private var remainingSeconds: Int = 0 {
        willSet {
            print("\(newValue)")
            countTimeLab.text = "\(newValue)"
            
        }
    }
    //开启倒计时，并设置回调
    var isCounting = false {
        willSet {
            if newValue {
                countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.updateTime), userInfo: nil, repeats: true)
                remainingSeconds = 60
                self.getpaycode()
                
            } else {
                countdownTimer?.invalidate()
                countdownTimer = nil
                //isCounting = true
                
            }
        }
    }
    @objc private func updateTime() {
        if remainingSeconds > 0{
            remainingSeconds -= 1
        }else {
            remainingSeconds = 60
            self.getpaycode()
            
        }
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
