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
            var avgs = ApiUtil.frontFunc()
            let msgId  = msg?.id!
            avgs.updateValue(msgId!, forKey: "msgId")
            let sign = ApiUtil.sign(data: avgs, sender: self)
            avgs.updateValue(sign, forKey: "sign")
            
            
            Just.post(ApiUtil.msgupdateApi ,  data: avgs) { (result) in
                guard let json = result.json as? NSDictionary else{
                    return
                }
                //print(json)
                if result.ok {
                    if  DwMsgListBaseRootClass(fromDictionary: json).code != 1 {
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
                        OperationQueue.main.addOperation {
                            ApiUtil.openAlert(msg: error.message, sender: self)
                        }
                    }
                }
                
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
