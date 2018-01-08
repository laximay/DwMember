//
//  MemberInfoTableViewController.swift
//  DwMember
//
//  Created by wenjing on 2017/8/21.
//  Copyright © 2017年 Wen Jing. All rights reserved.
//

import UIKit
import Just
class MemberInfoTableViewController: UITableViewController {
    var userInfo: DwLoginData?
    
    
    @IBOutlet weak var nicknameInp: UITextField!
    @IBOutlet weak var sexLab: UILabel!
    @IBOutlet weak var bmLab: UILabel!
    @IBOutlet weak var addLab: UILabel!
    @IBOutlet weak var mobileLab: UILabel!
    @IBOutlet weak var emailInp: UITextField!
    @IBOutlet weak var cardnoLab: UILabel!
    @IBOutlet weak var vaildLab: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dump(userInfo)
        
        if let user = self.userInfo?.card {
            self.nicknameInp.text = user.memberName
            self.sexLab.text = user.sex == "F" ? "女性": "男性"
            self.bmLab.text = user.birthMonth!
            self.addLab.text = user.address
            self.mobileLab.text = user.mobile
            self.emailInp.text = user.email
            self.cardnoLab.text = user.cardno
            self.vaildLab.text = user.closedt == nil ? "長期有效" : user.closedt
        }
        
        tableView.backgroundColor = UIColor(white: 0.98, alpha: 1)//美化列表
        tableView.tableFooterView = UIView(frame: CGRect.zero)//去除页脚
        tableView.separatorColor = UIColor(white: 0.9, alpha: 1)//去除分割线
    }
    
    
    @IBAction func submitTap(_ sender: UIButton) {
        updatauserInfo(memberName: self.nicknameInp.text!, email: self.emailInp.text!)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    /*
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
     
     // Configure the cell...
     
     return cell
     }
     */
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    func updatauserInfo(memberName: String, email: String) {
            var avgs = ApiUtil.frontFunc()
            
            avgs.updateValue(memberName, forKey: "memberName")
            avgs.updateValue(email, forKey: "email")
            
            let sign = ApiUtil.sign(data: avgs, sender: self)
            avgs.updateValue(sign, forKey: "sign")
            
            
            Just.post(ApiUtil.userinfoApi ,  data: avgs) { (result) in
                guard let json = result.json as? NSDictionary else{
                    return
                }
                
                if result.ok {
                    if  DwCountBaseRootClass(fromDictionary: json).code == 1 {
                        OperationQueue.main.addOperation {
                            self.openAlert()
                        }
                    }else{
                        if let error: DwCountBaseRootClass = DwCountBaseRootClass(fromDictionary: json){
                           // print("錯誤代碼:\(error.code as Int);信息:\(error.msg)原因:\(error.result)")
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
        let menu = UIAlertController(title: nil, message: "update completed", preferredStyle: .alert)
        let optionOK = UIAlertAction(title: "OK", style: .default) { (_) in
            self.navigationController!.popViewController(animated: true)
        }
        
        
        
        
        menu.addAction(optionOK)
        self.present(menu, animated: true, completion: nil)
    }
    
    
}
