//
//  MessageDetailViewController.swift
//  DwMember
//
//  Created by wenjing on 2017/8/17.
//  Copyright © 2017年 Wen Jing. All rights reserved.
//

import UIKit
import Just
class MessageDetailViewController: UIViewController {
    
    var msg: DwMsgListBaseData? = nil
    
    @IBOutlet weak var descriptionLab: UILabel!
    @IBOutlet weak var msgImg: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        descriptionLab.text = msg?.descriptionField
        let imgUrl = URL(string: (msg?.image)!)
        self.msgImg.kf.setImage(with: imgUrl)
        msgView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func msgView() {
        let defaults = UserDefaults.standard
        if let cardNo = defaults.string(forKey: "cardNo"){
            var avgs = ApiUtil.frontFunc()
            avgs.updateValue(cardNo, forKey: "cardNo")
            let msgId  = msg?.id!
            avgs.updateValue(msgId!, forKey: "msgId")
            let sign = ApiUtil.sign(data: avgs, sender: self)
            avgs.updateValue(sign, forKey: "sign")
            
            
            Just.post(ApiUtil.msgupdateApi ,  data: avgs) { (result) in
                guard let json = result.json as? NSDictionary else{
                    return
                }
                print(json)
                if result.ok {
                    if  DwMsgListBaseRootClass(fromDictionary: json).code == 1 {
                        print("已讀消息成功")
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
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
