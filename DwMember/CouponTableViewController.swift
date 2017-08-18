//
//  IntegralRecordTableViewController.swift
//  DwMember
//
//  Created by Wen Jing on 2017/8/3.
//  Copyright © 2017年 Wen Jing. All rights reserved.
//

import UIKit
import Just
class CouponTableViewController: UITableViewController {
    //基礎券列表:未用，已用，過期
    var couponBaseList: [ DwCouponBaseData] = []
    //商城券列表
    var couponMallList: [CouponMallData] = []
    
    var couponS: couponStatus = .unuse
    
    override func viewDidLoad() {
        super.viewDidLoad()
        switch couponS {
        case .unuse:
            print("類型\(couponS.rawValue)")
            couponunuseList()
        case .use:
            print("類型\(couponS.rawValue)")
            couponuseList()
        case .over:
            print("類型\(couponS.rawValue)")
            couponoverList()
        case .mall:
            print("類型\(couponS.rawValue)")
            couponList()
        default:()
        }
        couponunuseList()
        tableView.backgroundColor = UIColor(white: 0.98, alpha: 1)//美化列表
        tableView.tableFooterView = UIView(frame: CGRect.zero)//去除页脚
        tableView.separatorColor = UIColor(white: 0.9, alpha: 1)//去除分割线
        
    }
    
    class func create() -> CouponTableViewController {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        return mainStoryboard.instantiateViewController(withIdentifier: String(describing: self)) as! CouponTableViewController
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120.0
    }
    
    //加載未用優惠券列表
    func couponunuseList() {
        let defaults = UserDefaults.standard
        if let cardNo = defaults.string(forKey: "cardNo"){
            var avgs = ApiUtil.frontFunc()
            avgs.updateValue(cardNo, forKey: "cardNo")
            
            let sign = ApiUtil.sign(data: avgs)
            avgs.updateValue(sign, forKey: "sign")
            
            
            Just.post(ApiUtil.couponunuseApi ,  data: avgs) { (result) in
                guard let json = result.json as? NSDictionary else{
                    return
                }
                print("未用",json)
                if result.ok {
                    if  DwCouponBaseRootClass(fromDictionary: json).code == 1 {
                        self.couponBaseList = DwCouponBaseRootClass(fromDictionary: json).data
                        
                        OperationQueue.main.addOperation {
                            
                            self.tableView.reloadData()
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
    //加載已用優惠券方法
    func couponuseList() {
        let defaults = UserDefaults.standard
        if let cardNo = defaults.string(forKey: "cardNo"){
            var avgs = ApiUtil.frontFunc()
            avgs.updateValue(cardNo, forKey: "cardNo")
            
            let sign = ApiUtil.sign(data: avgs)
            avgs.updateValue(sign, forKey: "sign")
            
            
            Just.post(ApiUtil.couponuseApi ,  data: avgs) { (result) in
                guard let json = result.json as? NSDictionary else{
                    return
                }
                print("已用",json)
                if result.ok {
                    if  DwCouponBaseRootClass(fromDictionary: json).code == 1 {
                        self.couponBaseList = DwCouponBaseRootClass(fromDictionary: json).data
                        
                        OperationQueue.main.addOperation {
                            
                            self.tableView.reloadData()
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
    //加載過期優惠券列表
    func couponoverList() {
        let defaults = UserDefaults.standard
        if let cardNo = defaults.string(forKey: "cardNo"){
            var avgs = ApiUtil.frontFunc()
            avgs.updateValue(cardNo, forKey: "cardNo")
            
            let sign = ApiUtil.sign(data: avgs)
            avgs.updateValue(sign, forKey: "sign")
            
            
            Just.post(ApiUtil.couponoverApi ,  data: avgs) { (result) in
                guard let json = result.json as? NSDictionary else{
                    return
                }
                print("過期",json)
                if result.ok {
                    if  DwCouponBaseRootClass(fromDictionary: json).code == 1 {
                        self.couponBaseList = DwCouponBaseRootClass(fromDictionary: json).data
                        
                        OperationQueue.main.addOperation {
                            
                            self.tableView.reloadData()
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
    
    //加載商城優惠券列表
    func couponList() {
        let defaults = UserDefaults.standard
        if let cardNo = defaults.string(forKey: "cardNo"){
            var avgs = ApiUtil.frontFunc()
            avgs.updateValue(cardNo, forKey: "cardNo")
            
            let sign = ApiUtil.sign(data: avgs)
            avgs.updateValue(sign, forKey: "sign")
            
            
            Just.post(ApiUtil.couponlistApi ,  data: avgs) { (result) in
                guard let json = result.json as? NSDictionary else{
                    return
                }
                print("商城",json)
                if result.ok {
                    if  CouponMallRootClass(fromDictionary: json).code == 1 {
                        self.couponMallList = CouponMallRootClass(fromDictionary: json).data
                        
                        OperationQueue.main.addOperation {
                            
                            self.tableView.reloadData()
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
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return couponBaseList.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "couponCell", for: indexPath) as! CouponTableViewCell
        var coupon : AnyObject? = nil
        if couponS == .mall {
            coupon = couponMallList[indexPath.row] as AnyObject
        }else{
             coupon = couponBaseList[indexPath.row] as AnyObject
        }
        
        let imgUrl = URL(string: coupon!.image as! String)
        print("imgUrl:\(imgUrl)")
        cell.couponImg.image = #imageLiteral(resourceName: "photoalbum") //加載佔位符
        // cell.couponImg.kf.setImage(with: imgUrl)
        // Configure the cell...
        
        return cell
    }
    
    
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
    
}
