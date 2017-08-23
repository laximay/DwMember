//
//  LoginViewController.swift
//  DwMember
//
//  Created by Wen Jing on 2017/8/3.
//  Copyright © 2017年 Wen Jing. All rights reserved.
//

import UIKit
import Just
class LoginViewController: UIViewController {
    
    @IBOutlet weak var imageLoginLogo: UIImageView!
    @IBOutlet weak var cardNoLab: UITextField!
    @IBOutlet weak var passwordLab: UITextField!
    @IBOutlet weak var msgLab: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        //每次打開這個頁面都要清空
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: "dwsercet")
        defaults.removeObject(forKey: "cardNo")
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginTap(_ sender: UIButton) {
        login(cardNo: cardNoLab.text!, password: passwordLab.text!)
    }
    
    @IBAction func registerTap(_ sender: Any) {
        ApiUtil.webViewHandle(withIdentifier: webViewType.BIND.rawValue, sender: self)
    }
    @IBAction func forgetTap(_ sender: Any) {
        ApiUtil.webViewHandle(withIdentifier: webViewType.MPWD.rawValue, sender: self)
    }
    //登錄
    func login(cardNo: String, password: String )   {
        //參數
        var avgs = ApiUtil.frontFunc()
        
        avgs.updateValue(cardNo, forKey: "cardNo")
        avgs.updateValue(password.md5().md5(), forKey: "password")
        let defaults = UserDefaults.standard
        //保存KEY，保存操作只在登錄的時候做一次，如果成功則會沿用，重新調用登錄方法會覆蓋
        let key = "\(cardNo)#\(password.md5())"
        defaults.set(key, forKey: "dwsercet")
        defaults.set(cardNo, forKey: "cardNo")
        let sign = ApiUtil.sign(data: avgs, sender: self)
        avgs.updateValue(sign, forKey: "sign")
        Just.post(ApiUtil.loginApi ,  data: avgs) { (result) in
            
            
            guard let json = result.json as? NSDictionary else{
                return
            }
            print(json)
            if result.ok {
                if   DwLoginRootClass(fromDictionary: json).code == 1 {
                    //print("登錄成功")
                    
                    OperationQueue.main.addOperation {
                        
                        self.navigationController!.popViewController(animated: true)
                    }
                    
                }else {
                    
                    OperationQueue.main.addOperation {
                        self.msgLab.text = "賬號或密碼錯誤，請重試"
                        self.msgLab.isHidden = false
                    }
                    
                }
                
            }else{
                //處理接口系統錯誤
                if let error: DwErrorBaseRootClass = DwErrorBaseRootClass(fromDictionary: json){
                    print("錯誤代碼\(error.status);信息:\(error.message)原因:\(error.exception)")
                }
            }
            
            
        }
    }
    
    
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        let startScale = CGAffineTransform(scaleX: 0, y: 0)
        let startPos = CGAffineTransform(translationX: 0, y: 0)
        imageLoginLogo.transform = startScale.concatenating(startPos)
        
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.5, options: [], animations: {
            let endScale = CGAffineTransform.identity
            let endPos = CGAffineTransform(translationX: 0, y: 0)
            self.imageLoginLogo.transform = endPos.concatenating(endScale)
        }, completion: nil)
        
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
