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
    @IBOutlet weak var loginBtn: UIButton!
    
    @IBOutlet weak var regLab: UIButton!
    @IBOutlet weak var forgotPwLab: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
         navigationController?.setNavigationBarHidden(true, animated: true)
        //每次打開這個頁面都要清空
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: "dwsercet")
        defaults.removeObject(forKey: "cardNo")
        
        cardNoLab.inputAccessoryView = AddToolBar()
        passwordLab.inputAccessoryView = AddToolBar()
        loginBtn.backgroundColor = ApiUtil.getBtnColor()
        
        regLab.setTitleColor(ApiUtil.getBtnColor(), for: .normal)
          forgotPwLab.setTitleColor(ApiUtil.getBtnColor(), for: .normal)
        
        
        cardNoLab.backgroundColor  =  ApiUtil.getViewBgColor()
        passwordLab.backgroundColor  =  ApiUtil.getViewBgColor()
//        self.view.backgroundColor = ApiUtil.getViewBgColor()
    }
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(false)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginTap(_ sender: UIButton) {
        login(cardNo: cardNoLab.text!, password: passwordLab.text!)
    }
    
    @IBAction func registerTap(_ sender: Any) {
        ApiUtil.webViewHandle(withIdentifier: webViewType.BIND.rawValue, id: "", sender: self)
    }
    @IBAction func forgetTap(_ sender: Any) {
        ApiUtil.webViewHandle(withIdentifier: webViewType.MPWD.rawValue, id: "", sender: self)
    }
    //登錄
    func login(cardNo: String, password: String )   {
        //參數
        var avgs = ApiUtil.frontFunc()
        
        avgs.updateValue(cardNo, forKey: "cardNo")
        avgs.updateValue(password.md5().md5(), forKey: "password")

        
        let key = "\(cardNo)#\(password.md5())"
        let defaults = UserDefaults.standard
        defaults.set(key, forKey: "dwsercet")
    
        let sign = ApiUtil.sign(data: avgs, sender: self)
        avgs.updateValue(sign, forKey: "sign")
        avgs.updateValue(ApiUtil.companyCode, forKey: "company")
//        dump(avgs)
        Just.post(ApiUtil.loginApi ,  data: avgs, asyncCompletionHandler:  { (result) in
            
            //            print(result)
            guard let json = result.json as? NSDictionary else{
                return
            }
            
            if result.ok {
                if   DwLoginRootClass(fromDictionary: json).code == 1 {
                    //print("登錄成功")
                    let defaults = UserDefaults.standard
                    let realcardNo: String  = DwLoginRootClass(fromDictionary: json).data.card.cardno
                    //保存KEY，保存操作只在登錄的時候做一次，如果成功則會沿用，重新調用登錄方法會覆蓋
                    let key = "\(realcardNo)#\(password.md5())"
                    
                    defaults.set(realcardNo, forKey: "cardNo")
                    defaults.set(key, forKey: "dwsercet")
                    
                    OperationQueue.main.addOperation {
                        let mainSB = UIStoryboard(name: "Main", bundle: Bundle.main)
                        if let homeVC = mainSB.instantiateViewController(withIdentifier: "WebViewController")  as? WebViewController{
                            homeVC.url = ApiUtil.indexUrl
                            homeVC.type = "index"
                            self.navigationController?.pushViewController(homeVC, animated: true)
                        }
                    }
                    
                }else {
                    
                    OperationQueue.main.addOperation {
                        ApiUtil.openAlert(msg: "賬號或密碼錯誤!", sender: self)
                        
                    }
                    
                    
                    
                    
                    
                }
                
            }else{
                //處理接口系統錯誤
                let error: DwErrorBaseRootClass = DwErrorBaseRootClass(fromDictionary: json)
                //print("錯誤代碼\(error.status);信息:\(error.message)原因:\(error.exception)")
                OperationQueue.main.addOperation {
                    ApiUtil.openAlert(msg: error.message, sender: self)
                }
                
            }
            
            
        })
    }
    
    

    
    func AddToolBar() -> UIToolbar {
        let toolBar:UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 35))
        toolBar.backgroundColor = UIColor.gray
        let spaceBtn = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let barBtn = UIBarButtonItem(title: "完成", style: .plain, target: self, action: #selector(doneNum))
        toolBar.items = [spaceBtn, barBtn]
        toolBar.sizeToFit()
        return toolBar
    }
    
    @objc func doneNum() {
        self.view.endEditing(false)
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
