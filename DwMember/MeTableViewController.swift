//
//  IndexTableViewController.swift
//  DwMember
//
//  Created by Wen Jing on 2017/7/31.
//  Copyright © 2017年 Wen Jing. All rights reserved.
//

import UIKit
import Just

class MeTableViewController: UITableViewController{
    
    
    @IBOutlet weak var integralLab: UILabel!
    @IBOutlet weak var memberNameLab: UILabel!
    @IBOutlet weak var cardNoLab: UILabel!
    @IBOutlet weak var couponCountLab: UILabel!
    @IBOutlet weak var msgCountLab: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(self.reloadAllData), for: .valueChanged)
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        tableView.backgroundColor = UIColor(white: 0.98, alpha: 1)//美化列表
        tableView.tableFooterView = UIView(frame: CGRect.zero)//去除页脚
        tableView.separatorColor = UIColor(white: 0.9, alpha: 1)//去除分割线
    }
    
    override func viewDidAppear(_ animated: Bool) {
        getCardInfo()
        getMsgCount()
        getCouponCount()
    }
    
    
    func reloadAllData()  {
        getCardInfo()
        getMsgCount()
        getCouponCount()
    }
    
    
    func getCardInfo() {
        let defaults = UserDefaults.standard
        if let cardNo = defaults.string(forKey: "cardNo"){
            var avgs = ApiUtil.frontFunc()
            avgs.updateValue(cardNo, forKey: "cardNo")
            
            let sign = ApiUtil.sign(data: avgs)
            avgs.updateValue(sign, forKey: "sign")
            
            dump(avgs)
            
            Just.post(ApiUtil.cardinfoApi ,  data: avgs) { (result) in
                
                guard let json = result.json as? NSDictionary else{
                    return
                }
                //print(json)
                if result.ok {
                    if  DwLoginRootClass(fromDictionary: json).code == 1 {
                        
                        let datas = DwLoginRootClass(fromDictionary: json).data
                        
                        OperationQueue.main.addOperation {
                             self.refreshControl?.endRefreshing() //查询结果后关闭刷新
                            if let integral = datas?.card.integral {
                                self.integralLab.text = "\(integral)"
                            }
                            if let memberName = datas?.card.memberName {
                                self.memberNameLab.text = memberName
                                self.memberNameLab.isHidden = false
                            }
                            if let cardNo = datas?.card.cardno {
                                self.cardNoLab.text = "NO:\(cardNo)"
                                self.cardNoLab.isHidden = false
                            }
                           
                        }
                        
                    }else {
                        
                        //異常處理
                    }
                }else{
                    //處理接口系統錯誤
                    if let error: DwErrorBaseRootClass = DwErrorBaseRootClass(fromDictionary: json){
                        print("錯誤代碼\(error.status);信息:\(error.message)原因:\(error.exception)")
                    }
                }
                
            }}
    }
    //獲得未讀消息數量
    func getMsgCount() {
        let defaults = UserDefaults.standard
        if let cardNo = defaults.string(forKey: "cardNo"){
            var avgs = ApiUtil.frontFunc()
            avgs.updateValue(cardNo, forKey: "cardNo")
            
            let sign = ApiUtil.sign(data: avgs)
            avgs.updateValue(sign, forKey: "sign")
            
            
            Just.post(ApiUtil.msgcountApi ,  data: avgs) { (result) in
                guard let json = result.json as? NSDictionary else{
                    return
                }
                print(json)
                if result.ok {
                    if  DwCountBaseRootClass(fromDictionary: json).code == 1 {
                        let datas = DwCountBaseRootClass(fromDictionary: json).data
                        OperationQueue.main.addOperation {
                            if let msgCount = datas  {
                                self.msgCountLab.text = "\(msgCount as! Int)"
                            }
                        }
                        
                    }else {
                        
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
    
    //獲得優惠券未用數量
    func getCouponCount() {
        let defaults = UserDefaults.standard
        if let cardNo = defaults.string(forKey: "cardNo"){
            var avgs = ApiUtil.frontFunc()
            avgs.updateValue(cardNo, forKey: "cardNo")
            
            let sign = ApiUtil.sign(data: avgs)
            avgs.updateValue(sign, forKey: "sign")
            
            
            Just.post(ApiUtil.couponcountApi ,  data: avgs) { (result) in
                guard let json = result.json as? NSDictionary else{
                    return
                }
                if result.ok {
                    if  DwCountBaseRootClass(fromDictionary: json).code == 1 {
                        let datas = DwCountBaseRootClass(fromDictionary: json).data
                        OperationQueue.main.addOperation {
                            if let couponCount = datas  {
                                self.couponCountLab.text = "\(couponCount as! Int)"
                            }
                        }
                        
                    }else {
                        
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

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 6
    }
    
    //    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    //        // #warning Incomplete implementation, return the number of rows
    //        return section == 1 ? 2 : 3
    //    }
    
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //        if segue.identifier == "logoutSegue"{
        //
        //        }
        //隐藏底部导航条
        //segue.destination.hidesBottomBarWhenPushed = true
    }
    
    
    
    
    @IBAction func close(segue: UIStoryboardSegue){
    }
    
    
    
    
}
