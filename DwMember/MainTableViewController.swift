//
//  MainTableViewController.swift
//  DwMember
//
//  Created by Wen Jing on 2017/7/31.
//  Copyright © 2017年 Wen Jing. All rights reserved.
//

import UIKit
import Just
import CoreData
import LLCycleScrollView
import swiftScan
enum opentypeM: String{
    case WV = "WV" , //WEBVIEW功能網頁方式打開
    NA = "NA",  //原生形式
    OV = "OV" //外部第三方網頁
    
}

class MainTableViewController: UITableViewController, UIViewControllerTransitioningDelegate {
    
    
    @IBOutlet weak var indexImageView: UIView! //放置轮播图的VIEW
    @IBOutlet weak var menuView: UIStackView! //放置功能按钮的VIEW
    
    
    //活动的LIST
    var  activitys : [DwHomeActivity] = []
    //远程首页轮播图LIST
    var  ads : [DwHomeActivity] = []
    //远程首页轮播图LIST
    var  features : [DwHomeFeature] = []
    var scrollImageUrls: [String] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //註冊推送
       // print("udid:\(ApiUtil.idfv)")
//        JPUSHService.setAlias(ApiUtil.idfv,
//                              callbackSelector: #selector(self.tagsAliasCallBack(resCode:tags:alias:)),
//                              object: self)
        JPUSHService.setAlias(ApiUtil.idfv, completion: nil, seq: 1)
        
        
        homeCache()
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(self.homeCache), for: .valueChanged)
        
        tableView.backgroundColor = UIColor(white: 0.98, alpha: 1)//美化列表
        tableView.tableFooterView = UIView(frame: CGRect.zero)//去除页脚
        tableView.separatorColor = UIColor(white: 0.9, alpha: 1)//去除分割线
        
        tableView.estimatedRowHeight = 200 //自适应行高
        tableView.rowHeight = UITableViewAutomaticDimension //自适应行高 ，还需设置宽度约束，动态行数设为0，0代表动态行数
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //隱藏導航條
        //navigationController?.setNavigationBarHidden(true, animated: true)
        ApiUtil.checkUpdata(sender: self)
    }
    
    //    override var prefersStatusBarHidden: Bool{
    //        return true
    //    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200.0
    }
    
    func homeCache()  {
        
        //異步請求會覆蓋上一步的數據，重新填充
        Just.post(ApiUtil.homeApi ,  data: ["company": ApiUtil.companyCode]) { (result) in
          
            guard let json = result.json as? NSDictionary else{
                //网络失败处理
            self.setupIndexData()
                return
            }
          
            
            let defaults = UserDefaults.standard
            let str = self.getJSONStringFromDictionary(dictionary: json);
           
            defaults.set( str, forKey: "index_data")
            let xx = defaults.string(forKey: "index_data")
        
            if(result.ok){
                let datas = DwHomeRootClass(fromDictionary: json).data!
                do{
                   
                    //如果点击了则把点过的动作标志保存到存储空间，以便启动时候检查
               
                    //首頁輪播圖
                    self.ads = datas.ads.sorted(by: { $0.sort < $1.sort })
                    self.scrollImageUrls =  self.ads.map({(ad) -> String in
                        return ad.image})
                    
                    //填充首頁活動圖
                    self.activitys = datas.activitys.sorted(by: { $0.sort < $1.sort })
                    
                    //首页功能按钮
                    self.features = datas.features.sorted(by: { $0.sort < $1.sort })
                    
                    
                    OperationQueue.main.addOperation {
                        self.tableView.reloadData()
                        self.refreshControl?.endRefreshing()
                        self.addMainScrollView()
                        self.createMenuBtn()
                    }
                    
                }catch{
                    if let error: DwCountBaseRootClass = DwCountBaseRootClass(fromDictionary: json){
                       // print("錯誤代碼:\(error.code as Int);信息:\(error)原因:\(error.result)")
                        ApiUtil.openAlert(msg: error.msg, sender: self)
                    }
                }
            }else{
                //處理接口系統錯誤
                if let error: DwErrorBaseRootClass = DwErrorBaseRootClass(fromDictionary: json){
                    print("錯誤代碼:\(error.status);信息:\(error.message)原因:\(error.exception)")
                }
            }
            
        }
        
        self.tableView.reloadData()
        self.refreshControl?.endRefreshing()
        
    }
    
    
    
    
    
    func addMainScrollView() {
        let w = UIScreen.main.bounds.width
        let mainScrollView = LLCycleScrollView.llCycleScrollViewWithFrame(CGRect.init(x: 0, y:0, width: w, height: 155), imageURLPaths: self.scrollImageUrls, didSelectItemAtIndex: { index in
           // print("当前点击图片的位置为:\(index)")
            let ad = self.ads[index]
            let openType = opentypeM.init(rawValue: ad.opentype!).unsafelyUnwrapped
            
            switch openType {
            case .NA:
                //原生跳转处理
               // print("NA")
                
                self.performSegue(withIdentifier: nativeViews[ad.url!]!, sender: self)
            case .OV:
                //第三方WEBVIEW跳转
               // print("OV")
                if let pageVC = self.storyboard?.instantiateViewController(withIdentifier: "WebViewController") as? WebViewController {
                    pageVC.url = ad.url!
                    pageVC.type = "OV"
                    self.navigationController?.pushViewController(pageVC, animated: true)
                }
            case .WV:
                //内部WEBVIEW跳转
               // print("WV")
                ApiUtil.webViewHandle(withIdentifier: ad.url!, sender: self)
        
            }
            
        })
        
        
        mainScrollView.customPageControlStyle = .none
        mainScrollView.customPageControlInActiveTintColor = UIColor.red
        mainScrollView.pageControlPosition = .left
        mainScrollView.pageControlLeadingOrTrialingContact = 28
        mainScrollView.placeHolderImage = #imageLiteral(resourceName: "photoalbum")
        mainScrollView.coverImage = #imageLiteral(resourceName: "photoalbum")
        
        // 下边约束
        mainScrollView.pageControlBottom = 15
        self.indexImageView.addSubview(mainScrollView)
        
    }
    
    
    
    
    
    
    
    
    
    
    @IBAction func featureTap(_ sender: UIButton) {
        // print("tab:\(sender.tag)")
        if  let feature : DwHomeFeature = features[sender.tag] {
            
            
            let openType = opentypeM.init(rawValue: feature.opentype!).unsafelyUnwrapped
            
            switch openType {
            case .NA:
                //原生跳转处理
                //print("NA")
                performSegue(withIdentifier: nativeViews[feature.url!]!, sender: self)
            case .OV:
                //第三方WEBVIEW跳转
                //print("OV")
                if let pageVC = storyboard?.instantiateViewController(withIdentifier: "WebViewController") as? WebViewController {
                    pageVC.url = feature.url!
                    pageVC.type = "OV"
                    self.navigationController?.pushViewController(pageVC, animated: true)
                }
            case .WV:
                //内部WEBVIEW跳转
               // print("WV")
                ApiUtil.webViewHandle(withIdentifier: feature.url!, sender: self)
            }
        }
        
        
        
        //        if feature.opentype! == "WV" {
        //            if let pageVC = storyboard?.instantiateViewController(withIdentifier: "WebViewController") as? WebViewController {
        //                pageVC.url = feature.url!
        //                self.navigationController?.pushViewController(pageVC, animated: true)
        //            }
        //        }else{
        //            performSegue(withIdentifier: "couponMallSegue", sender: self)
        //        }
        //代码转场 方式一 Segue方式 一定要在目标页拖EXIT出口
        //performSegue(withIdentifier: "couponMallSegue", sender: self)
        //代码转场 方式二  present方式
        //present(pageVC, animated: true, completion: nil)
        //代码转场 方式三 导航方式-一定要在目标页拖EXIT出口
        //self.navigationController?.pushViewController(pageVC, animated: true)
        
        
        //        if let pageVC = storyboard?.instantiateViewController(withIdentifier: "CouponViewController") as? CouponViewController {
        //            pageVC.selectIndex = 0
        //            self.navigationController?.pushViewController(pageVC, animated: true)
        //        }
        
    }
    
    //創建功能按鈕,原生的滿足不了需求，擴展了一個
    func createMenuBtn() {
        
        
        let btn1 : UIButton = menuView.arrangedSubviews[0] as! UIButton
        let btn2 : UIButton = menuView.arrangedSubviews[1] as! UIButton
        let btn3 : UIButton = menuView.arrangedSubviews[2] as! UIButton
        let btn4 : UIButton = menuView.arrangedSubviews[3] as! UIButton
        
        //        btn1.setLocal(image: UIImage(named: "thumb")!, title: "网", titlePosition: .bottom,additionalSpacing: 10.0, state: .normal)
        //        btn2.setLocal(image: UIImage(named: "thumb")!, title: "络", titlePosition: .bottom,additionalSpacing: 10.0, state: .normal)
        //        btn3.setLocal(image: UIImage(named: "thumb")!, title: "不", titlePosition: .bottom,additionalSpacing: 10.0, state: .normal)
        //        btn4.setLocal(image: UIImage(named: "thumb")!, title: "通", titlePosition: .bottom,additionalSpacing: 10.0, state: .normal)
        if features.count == 4 {
            
            btn1.set(image: features[0].image!, title: features[0].name!, titlePosition: .bottom,
                     additionalSpacing: 10.0, state: .normal)
            btn1.tag = 0
            
            
            btn2.set(image: features[1].image!, title: features[1].name!, titlePosition: .bottom,
                     additionalSpacing: 10.0, state: .normal)
            
            btn2.tag = 1
            
            btn3.set(image: features[2].image!, title: features[2].name!, titlePosition: .bottom,
                     additionalSpacing: 10.0, state: .normal)
            btn3.tag = 2
            
            btn4.set(image: features[3].image!, title: features[3].name!, titlePosition: .bottom,
                     additionalSpacing: 10.0, state: .normal)
            btn4.tag = 3
            
        }
        
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
        return activitys.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "activityCell", for: indexPath) as! MainActivitysTableViewCell
        let activity = activitys[indexPath.row]
        
        let imgUrl = URL(string: activity.image!)
        cell.thumbImage.kf.setImage(with: imgUrl)
        
        // Configure the cell...
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let activity : DwHomeActivity = activitys[indexPath.row] {
            let openType = opentypeM.init(rawValue: activity.opentype!).unsafelyUnwrapped
            
            switch openType {
            case .NA:
                //原生跳转处理
                //print("NA")
                performSegue(withIdentifier: nativeViews[activity.url!]!, sender: self)
            case .OV:
                //第三方WEBVIEW跳转
               // print("OV")
                if let pageVC = storyboard?.instantiateViewController(withIdentifier: "WebViewController") as? WebViewController {
                    pageVC.url = activity.url!
                    pageVC.type = "OV"
                    self.navigationController?.pushViewController(pageVC, animated: true)
                }
            case .WV:
                //内部WEBVIEW跳转
               // print("WV")
                ApiUtil.webViewHandle(withIdentifier: activity.url!, sender: self)
            }
        }
        
        
        
        
    }
    
    
    func setupIndexData() {
        let defaults = UserDefaults.standard

        if let result =  defaults.string(forKey: "index_data"){
            guard let json = getDictionaryFromJSONString(jsonString: result) as? NSDictionary else{
            return
        }
       //print("indsetupIndexDataex: ",json)
        
        let datas = DwHomeRootClass(fromDictionary: json).data!
            //如果点击了则把点过的动作标志保存到存储空间，以便启动时候检查
            
            //首頁輪播圖
            self.ads = datas.ads.sorted(by: { $0.sort < $1.sort })
            self.scrollImageUrls =  self.ads.map({(ad) -> String in
                return ad.image})
            
            //填充首頁活動圖
            self.activitys = datas.activitys.sorted(by: { $0.sort < $1.sort })
            
            //首页功能按钮
            self.features = datas.features.sorted(by: { $0.sort < $1.sort })
            
            
            OperationQueue.main.addOperation {
                self.tableView.reloadData()
                self.refreshControl?.endRefreshing()
                self.addMainScrollView()
                self.createMenuBtn()
            }
        }
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
    
    
    // MARK: - Navigation homeToWebSegue
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "couponMallSegue"{
            let dest = segue.destination as! CouponViewController
            dest.selectIndex = 0
            dest.indexFlag = true
        }
        //扫描二维码的的Segue
        if segue.identifier == "scanSegue"{
            let scanVc = segue.destination as! ScanViewController
                var style = LBXScanViewStyle()
                style.animationImage = UIImage(named: "qrcode_scan_light_green")
                style.colorAngle = UIColor(red: 158/255.0, green: 16.0/255.0, blue: 38.0/255.0, alpha: 1.0)
                scanVc.scanStyle = style
        }
        //隐藏底部导航条
        segue.destination.hidesBottomBarWhenPushed = true
        
    }
    
    //字典转JSON
    func getJSONStringFromDictionary(dictionary:NSDictionary) -> NSString {
        if (!JSONSerialization.isValidJSONObject(dictionary)) {
            //print("无法解析出JSONString")
            return ""
        }
        let data : NSData! = try? JSONSerialization.data(withJSONObject: dictionary, options: []) as NSData!
        let JSONString = NSString(data:data as Data,encoding: String.Encoding.utf8.rawValue)
        return JSONString!
    }
    
    //JSON转字典
    func getDictionaryFromJSONString(jsonString:String) ->NSDictionary{
        
        let jsonData:Data = jsonString.data(using: .utf8)!
        
        let dict = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers)
        if dict != nil {
            return dict as! NSDictionary
        }
        return NSDictionary()
        
        
    }
 
    
    
    
    
    @IBAction func close(segue: UIStoryboardSegue){
    }
    
    
}
