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
    @IBOutlet weak var localVersion: UILabel!
    @IBOutlet weak var validperiodLab: UILabel!
    @IBOutlet weak var birthImg: UIImageView!
    var userInfo: DwLoginData?
    
    let currentVersion = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        
        let defaults = UserDefaults.standard
        if let version = defaults.string(forKey: "localVersion"){
            localVersion.text = "當前版本:\(version)"
        }else{
            
            localVersion.text = "當前版本:\(currentVersion)"
        }
        
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(self.reloadAllData), for: .valueChanged)
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        tableView.backgroundColor = UIColor(white: 0.98, alpha: 1)//美化列表
        tableView.tableFooterView = UIView(frame: CGRect.zero)//去除页脚
        tableView.separatorColor = UIColor(white: 0.9, alpha: 1)//去除分割线
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        
        self.integralLab.text = "0"
        self.couponCountLab.text = "0"
        self.memberNameLab.text = ""
        self.cardNoLab.text = ""
        self.validperiodLab.text = ""
        
        getCardInfo()
        getMsgCount()
        getCouponCount()
        
        
        //        let defaults = UserDefaults.standard
        //        if (defaults.string(forKey: "dwsercet") != nil){
        //            getCardInfo()
        //            getMsgCount()
        //            getCouponCount()
        //        } else{
        //            self.integralLab.text = "0"
        //            self.couponCountLab.text = "0"
        //            self.memberNameLab.text = ""
        //            self.cardNoLab.text = ""
        //            self.validperiodLab.text = ""
        
        //            if let pageVC = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController {
        //
        //                self.navigationController?.pushViewController(pageVC, animated: true)
        //                //sender.present(pageVC, animated: true, completion: nil)
        //            }
        
        //            let menu = UIAlertController(title: nil, message: "請登入", preferredStyle: .alert)
        //
        //            let optionOK = UIAlertAction(title: "登入", style: .default, handler: { (_) in
        //
        //                self.performSegue(withIdentifier: "logoutSegue", sender: self)
        //            })
        //            menu.addAction(optionOK)
        //
        //            let optionCancel = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        //            menu.addAction(optionCancel)
        //
        //            self.present(menu, animated: true, completion: nil)
        
        //            return
        //        }
        
        
        
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print("索引是:\(indexPath.section) \(indexPath.row  )")
        
        
        if indexPath == [0, 0] {
            ApiUtil.webViewHandle(withIdentifier: webViewType.JFCX.rawValue, id: "",  sender: self)
        }
        
        //        if indexPath == [1, 0] {
        //             tableView.deselectRow(at: indexPath, animated: true)
        //            //ApiUtil.webViewHandle(withIdentifier: webViewType.DZXQ.rawValue, id: "",  sender: self)
        //        }
        if indexPath == [1, 2] {
              let barnchsSB = UIStoryboard(name: "Find", bundle: Bundle.main)
            if let pageVC = barnchsSB.instantiateViewController(withIdentifier: "BranchsMapViewController") as? BranchsMapViewController {
                self.navigationController?.pushViewController(pageVC, animated: true)
            }
        }
        
        if indexPath == [2, 0] {
            if let pageVC = storyboard?.instantiateViewController(withIdentifier: "ArticleViewController") as? ArticleViewController {
                pageVC.type = .MEMTERMS
                self.navigationController?.pushViewController(pageVC, animated: true)
            }
        }
        
        if indexPath == [2, 1] {
           
            if let pageVC = storyboard?.instantiateViewController(withIdentifier: "ArticleViewController") as? ArticleViewController {
                pageVC.type = .MEMINFO
                self.navigationController?.pushViewController(pageVC, animated: true)
            }
        }
        
        if indexPath == [2, 2] {
            
            self.getPageList()
            
        }
        if indexPath == [2, 3] {
            if let pageVC = storyboard?.instantiateViewController(withIdentifier: "ArticleViewController") as? ArticleViewController {
                pageVC.type = .ABOUTUS
                self.navigationController?.pushViewController(pageVC, animated: true)
            }
        }
        
        
        
        
        
        if indexPath == [3, 0] {
            ApiUtil.webViewHandle(withIdentifier: webViewType.FPWD.rawValue, id: "", sender: self)
        }
        
        if indexPath == [3, 3] {
            clearCacheBtnClick()
        }
        
        
        
        
        
        
        
    }
    
    
    func reloadAllData()  {
        getCardInfo()
        getMsgCount()
        getCouponCount()
    }
    
    
    func getCardInfo() {
        
        var avgs = ApiUtil.frontFunc()
        
        avgs.updateValue(ApiUtil.serial, forKey: "serial")
        let sign = ApiUtil.sign(data: avgs, sender: self)
        avgs.updateValue(sign, forKey: "sign")
        
        
        
        //dump(avgs)
        
        Just.post(ApiUtil.cardinfoApi ,  data: avgs) { (result) in
            
            guard let json = result.json as? NSDictionary else{
                return
            }
            print(json)
            if result.ok {
                if  DwLoginRootClass(fromDictionary: json).code == 1 {
                    
                    self.userInfo = DwLoginRootClass(fromDictionary: json).data
                    
                    OperationQueue.main.addOperation {
                        self.refreshControl?.endRefreshing() //查询结果后关闭刷新
                        if let integral = self.userInfo?.card.integral {
                            self.integralLab.text = "\(integral)"
                        }
                        if let memberName = self.userInfo?.card.memberName {
                            
                            self.memberNameLab.text = "\(memberName)  \( self.userInfo?.card.sex == "F" ? "女士": "先生")"
                            self.memberNameLab.isHidden = false
                        }
                        if let mobile = self.userInfo?.card.mobile {
                            self.cardNoLab.text = mobile
                            self.cardNoLab.isHidden = false
                        }
                        
                        if let validperiod = self.userInfo?.card.integralDesc {
                            self.validperiodLab.text = "積分有效期:\(validperiod)"
                            self.validperiodLab.isHidden = false
                        }else{
                            self.validperiodLab.text = "積分有效期:2018-12-31"
                            self.validperiodLab.isHidden = false
                        }
                        
                        //                        if let isOpenSeat = self.userInfo?.isOpenSeat {
                        //                            if isOpenSeat == 0 {
                        //
                        //                               // self.tableView.deleteSections([1], with: .none)
                        //
                        //                            }
                        //                        }
                        
                        
                        if let isBir = self.userInfo?.card.isCustBirthMonth {
                            if isBir {
                                let startScale = CGAffineTransform(scaleX: 0, y: 0)
                                let startPos = CGAffineTransform(translationX: 0, y: 0)
                                self.birthImg.image = #imageLiteral(resourceName: "birthdaycake")
                                self.birthImg.isHidden = false
                                self.birthImg.transform = startScale.concatenating(startPos)
                                
                                UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.5, options: [], animations: {
                                    let endScale = CGAffineTransform.identity
                                    let endPos = CGAffineTransform(translationX: 0, y: 0)
                                    self.birthImg.transform = endPos.concatenating(endScale)
                                }, completion: nil)
                                
                            }
                        }
                        
                        
                        
                        
                    }
                    
                }else {
                    //異常處理
                    if let error: DwCountBaseRootClass = DwCountBaseRootClass(fromDictionary: json){
                        // print("錯誤代碼:\(error.code as Int);信息:\(error.msg)原因:\(error.result)")
                        
                        OperationQueue.main.addOperation {
                            //ApiUtil.openAlert(msg: error.msg, sender: self)
                            let menu = UIAlertController(title: nil, message: error.msg, preferredStyle: .alert)
                            
                            let optionOK = UIAlertAction(title: "重新登入", style: .default, handler: { (_) in
                                
                                self.performSegue(withIdentifier: "logoutSegue", sender: self)
                            })
                            menu.addAction(optionOK)
                            
                            self.present(menu, animated: true, completion: nil)
                            
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
    //獲得未讀消息數量
    func getMsgCount() {
        
        var avgs = ApiUtil.frontFunc()
        
        let sign = ApiUtil.sign(data: avgs, sender: self)
        avgs.updateValue(sign, forKey: "sign")
        //dump(avgs)
        
        Just.post(ApiUtil.msgcountApi ,  data: avgs) { (result) in
            guard let json = result.json as? NSDictionary else{
                return
            }
            // print("MSG:" , json)
            if result.ok {
                if  DwCountBaseRootClass(fromDictionary: json).code == 1 {
                    let datas = DwCountBaseRootClass(fromDictionary: json).data
                    OperationQueue.main.addOperation {
                        if let msgCount = datas  {
                            self.msgCountLab.text = "\(msgCount as! Int)"
                        }
                    }
                    
                }else {
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
                    OperationQueue.main.addOperation {
                        ApiUtil.openAlert(msg: error.message, sender: self)
                    }
                }
            }
            
        }
    }
    
    //獲得優惠券未用數量
    func getCouponCount() {
        var avgs = ApiUtil.frontFunc()
        let sign = ApiUtil.sign(data: avgs, sender: self)
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
    
    //開始清除緩存
    func clearCacheBtnClick(){
        
        //提示框
        let message = self.cacheSize
        let alert = UIAlertController(title: "清除缓存", message: message, preferredStyle:UIAlertControllerStyle.alert)
        let alertConfirm = UIAlertAction(title: "确定", style:UIAlertActionStyle.default) { (alertConfirm) ->Void in
            self.clearCache()
        }
        alert.addAction(alertConfirm)
        let cancle = UIAlertAction(title: "取消", style:UIAlertActionStyle.cancel) { (cancle) ->Void in
        }
        alert.addAction(cancle)
        //提示框弹出
        self.present(alert, animated: true, completion: nil)
    }
    
    var cacheSize: String{
        get{
            // 路径
            let basePath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first
            let fileManager = FileManager.default
            // 遍历出所有缓存文件加起来的大小
            func caculateCache() -> Float{
                var total: Float = 0
                if fileManager.fileExists(atPath: basePath!){
                    let childrenPath = fileManager.subpaths(atPath: basePath!)
                    if childrenPath != nil{
                        for path in childrenPath!{
                            let childPath = basePath!.appending("/").appending(path)
                            do{
                                let attr:NSDictionary = try fileManager.attributesOfItem(atPath: childPath) as NSDictionary
                                let fileSize = attr["NSFileSize"] as! Float
                                total += fileSize
                                
                            }catch _{
                                
                            }
                        }
                    }
                }
                // 缓存文件大小
                return total
            }
            // 调用函数
            let totalCache = caculateCache()
            return NSString(format: "%.2f MB", totalCache / 1024.0 / 1024.0 ) as String
        }
    }
    
    /// 清除缓存
    ///
    /// - returns: 是否清理成功
    func clearCache()  {
        var result = true
        // 取出cache文件夹目录 缓存文件都在这个目录下
        let cachePath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first
        // 取出文件夹下所有文件数组
        let fileArr = FileManager.default.subpaths(atPath: cachePath!)
        // 遍历删除
        for file in fileArr! {
            // 拼接文件路径
            let path = cachePath?.appending("/\(file)")
            if FileManager.default.fileExists(atPath: path!) {
                // 循环删除
                do {
                    try FileManager.default.removeItem(atPath: path!)
                } catch {
                    // 删除失败
                    result = false
                }
            }
        }
        // return result
    }
    //調查問卷接口
    func getPageList()  {
        var avgs: [String: Any] = [:]
        
        
        avgs.updateValue(ApiUtil.companyCode, forKey: "company")
        avgs.updateValue("AC", forKey: "type")
        avgs.updateValue("MINE", forKey: "page")
        
        
        Just.post(ApiUtil.pageListApi ,  data: avgs) { (result) in
            guard let json = result.json as? NSDictionary else{
                return
            }
            // print(json)
            if result.ok {
                if  DwPageListRootClass(fromDictionary: json).code == 1 {
                    let datas = DwPageListRootClass(fromDictionary: json).data
                    OperationQueue.main.addOperation {
                        if let datas = datas {
                            if let pageVC = ApiUtil.mainSB.instantiateViewController(withIdentifier: "WebViewController") as? WebViewController {
                                pageVC.url = datas.pageList[0].url
                                pageVC.type = datas.pageList[0].opentype
                                self.navigationController?.pushViewController(pageVC, animated: true)
                            }
                        }
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
                    // print("錯誤代碼:\(error.status);信息:\(error.message)原因:\(error.exception)")
                    OperationQueue.main.addOperation {
                        ApiUtil.openAlert(msg: error.message, sender: self)
                    }
                }
            }
            
        }
    }
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 5
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
        if segue.identifier == "meToMemberMallSegue"{
            let dest = segue.destination as! CouponViewController
            dest.selectIndex = 0
            segue.destination.hidesBottomBarWhenPushed = true
            
        }else if segue.identifier == "memberinfoSegue"{
            let dest = segue.destination as! MemberInfoTableViewController
            dest.userInfo = self.userInfo
            segue.destination.hidesBottomBarWhenPushed = true
        }else if segue.identifier == "logoutSegue"{
            
            segue.destination.hidesBottomBarWhenPushed = true
        }
        //隐藏底部导航条
        
    }
    
    
    
    
    @IBAction func close(segue: UIStoryboardSegue){
    }
    
    
    
    
}
