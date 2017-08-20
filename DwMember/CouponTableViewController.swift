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
    var couponunuseList: [ DwCouponBaseData] = []
    //基礎券列表:未用，已用，過期
    var couponuseList: [ DwCouponBaseData] = []
    //基礎券列表:未用，已用，過期
    var couponoverList: [ DwCouponBaseData] = []
    //商城券列表
    var couponMallList: [CouponMallData] = []
    
    var couponS: couponStatus = .unuse
    
    override func viewDidLoad() {
        super.viewDidLoad()
        switch couponS {
        case .unuse:
            //print("類型\(couponS.rawValue)")
            getcouponunuseList()
        case .use:
            //print("類型\(couponS.rawValue)")
            getcouponuseList()
        case .over:
            //print("類型\(couponS.rawValue)")
            getcouponoverList()
        case .mall:
            print("類型\(couponS.rawValue)")
            getcouponList()
        default:()
        }
        tableView.backgroundColor = UIColor(white: 0.98, alpha: 1)//美化列表
        tableView.tableFooterView = UIView(frame: CGRect.zero)//去除页脚
        tableView.separatorColor = UIColor(white: 0.9, alpha: 1)//去除分割线
        
    }
    
    class func create() -> CouponTableViewController {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        return mainStoryboard.instantiateViewController(withIdentifier: String(describing: self)) as! CouponTableViewController
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 230.0
    }
    
    //加載未用優惠券列表
    func getcouponunuseList() {
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
                // print("未用",json)
                if result.ok {
                    if  DwCouponBaseRootClass(fromDictionary: json).code == 1 {
                        self.couponunuseList = DwCouponBaseRootClass(fromDictionary: json).data
                        
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
    func getcouponuseList() {
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
                //print("已用",json)
                if result.ok {
                    if  DwCouponBaseRootClass(fromDictionary: json).code == 1 {
                        self.couponuseList = DwCouponBaseRootClass(fromDictionary: json).data
                        
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
    func getcouponoverList() {
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
                //print("過期",json)
                if result.ok {
                    if  DwCouponBaseRootClass(fromDictionary: json).code == 1 {
                        self.couponoverList = DwCouponBaseRootClass(fromDictionary: json).data
                        
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
    func getcouponList() {
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
                //print("商城",json)
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
        var listCount = 0
        switch couponS {
        case .unuse:
            listCount = couponunuseList.count
        case .use:
            listCount = couponuseList.count
        case .over:
            listCount = couponoverList.count
        case .mall:
            listCount = couponMallList.count
        default:()
        }
        
        return listCount
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "couponCell", for: indexPath) as! CouponTableViewCell
        
        switch couponS {
        case .unuse:
            let coupon  = couponunuseList[indexPath.row]
            let imgUrl = URL(string: coupon.image)
            cell.titleLab.text = coupon.title
            cell.expiredLab.text = coupon.endTime
            //print("未用imgUrl:\(imgUrl)")
            cell.couponImg.image = #imageLiteral(resourceName: "photoalbum") //加載佔位符
            cell.couponImg.kf.setImage(with: imgUrl)
        case .use:
            let coupon  = couponuseList[indexPath.row]
            let imgUrl = URL(string: coupon.image)
            cell.titleLab.text = coupon.title
            cell.expiredLab.text = coupon.endTime
            // print("已用imgUrl:\(imgUrl)")
            cell.couponImg.image = #imageLiteral(resourceName: "photoalbum") //加載佔位符
            cell.couponImg.kf.setImage(with: imgUrl)
            
        case .over:
            let coupon  = couponoverList[indexPath.row]
            let imgUrl = URL(string: coupon.image)
            cell.titleLab.text = coupon.title
            cell.expiredLab.text = coupon.endTime
            //print("过期imgUrl:\(imgUrl)")
            cell.couponImg.image = #imageLiteral(resourceName: "photoalbum") //加載佔位符
            cell.couponImg.kf.setImage(with: imgUrl)
            
        case .mall:
            let coupon  = couponMallList[indexPath.row]
            let imgUrl = URL(string: coupon.image)
            cell.titleLab.text = coupon.title
            cell.expiredLab.text = coupon.endTime
            cell.descLab.text = coupon.exchangeType
            cell.descLab.isHidden = false
            //print("商城imgUrl:\(imgUrl)")
            cell.couponImg.image = #imageLiteral(resourceName: "photoalbum") //加載佔位符
            cell.couponImg.kf.setImage(with: imgUrl)
            
        default:()
        }
        
        
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
    
    
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showCouponDeatilsSegue" {
            let dest = segue.destination as! CouponDeatilsViewController
            dest.couponS = self.couponS
            
            switch couponS {
            case .unuse:
                dest.couponId = couponunuseList[tableView.indexPathForSelectedRow!.row].id
            case .use:
                 dest.couponId = couponuseList[tableView.indexPathForSelectedRow!.row].id
            case .over:
                 dest.couponId = couponoverList[tableView.indexPathForSelectedRow!.row].id
            case .mall:
                 dest.couponId = couponMallList[tableView.indexPathForSelectedRow!.row].id
            default:()
            }
 
        }
     }
    
    @IBAction func close(segue: UIStoryboardSegue){
    }
 
    
}
