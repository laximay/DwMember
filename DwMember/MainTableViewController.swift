//
//  MainTableViewController.swift
//  DwMember
//
//  Created by Wen Jing on 2017/7/31.
//  Copyright © 2017年 Wen Jing. All rights reserved.
//

import UIKit
import SSCycleScrollView
import Just
import CoreData

enum opentypeM: String{
    case WV = "WV" , //WEBVIEW功能網頁方式打開
    NA = "NA",  //原生形式
    OV = "OV" //外部第三方網頁
    
}

class MainTableViewController: UITableViewController, UIViewControllerTransitioningDelegate {
    
    
    @IBOutlet weak var indexImageView: UIView! //放置轮播图的VIEW
    @IBOutlet weak var menuView: UIStackView! //放置功能按钮的VIEW
    var mainScrollView: SSCycleScrollView? //轮播图空间
    
    //活动的LIST
    var  activitys : [DwCache] = []
    //远程首页轮播图LIST
    var  ads : [DwCache] = []
    //远程首页轮播图LIST
    var  features : [DwCache] = []
    var scrollImageUrls: [[String]] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    
    
    
    
    
    
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200.0
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        ApiUtil.checkUpdata(sender: self)
    }
    
    
    func addMainScrollView() {
        
        let currentRect =  self.indexImageView.bounds
        self.mainScrollView = SSCycleScrollView.init(frame: currentRect, animationDuration: 3, inputImageUrls: self.scrollImageUrls)
        self.mainScrollView?.tapBlock = {index in
            //在这里处理点击轮播图的的事件
            print("tapped page\(index)")
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let requestAds : NSFetchRequest<DwCache> = DwCache.fetchRequest()
            let cateAds = NSPredicate.init(format: "type='ads'")
            requestAds.predicate = cateAds
            do{
                let ads = try appDelegate.persistentContainer.viewContext.fetch(requestAds)
                if let ad: DwCache = ads[index]{
                    let openType = opentypeM.init(rawValue: ad.opentype!).unsafelyUnwrapped
                    
                    switch openType {
                    case .NA:
                        //原生跳转处理
                        print("NA")
                        self.performSegue(withIdentifier: nativeViews[ad.url!]!, sender: self)
                    case .OV:
                        //内部WEBVIEW跳转
                        print("OV")
                        if let pageVC = self.storyboard?.instantiateViewController(withIdentifier: "WebViewController") as? WebViewController {
                            pageVC.url = ad.url!
                            self.navigationController?.pushViewController(pageVC, animated: true)
                        }
                    case .WV:
                        //第三方WEBVIEW跳转
                        print("WV")
                        ApiUtil.webViewHandle(withIdentifier: ad.url!, sender: self)
                        
                    default:
                        print("未知类型")
                    }
                }
                
            }catch{
                print(error)
            }
            
        }
        //        self.mainScrollView?.autoScroll = false
        self.indexImageView.addSubview(self.mainScrollView!)    }
    
    func homeCache()  {
        //先加載CORE的數據
        fetchHomeData()
        //異步請求會覆蓋上一步的數據，重新填充
        Just.post(ApiUtil.homeApi ,  data: ["company": ApiUtil.companyCode]) { (result) in
            guard let json = result.json as? NSDictionary else{
                return
            }
            print("index:",json)
            if(result.ok){
                let datas = DwHomeRootClass(fromDictionary: json).data!
                
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                do{
                    let allData : [DwCache] = try appDelegate.persistentContainer.viewContext.fetch(DwCache.fetchRequest())
                    
                    for ad in allData {
                        appDelegate.persistentContainer.viewContext.delete(ad)
                        appDelegate.saveContext()
                    }
                    //填充首頁輪播圖
                    self.scrollImageUrls = []
                    self.scrollImageUrls =  datas.ads.map({(ad) -> [String] in
                        let ads  =  DwCache(context: appDelegate.persistentContainer.viewContext)
                        ads.image = ad.image
                        ads.briefing = ad.briefing
                        ads.english = ad.english
                        ads.name = ad.name
                        ads.opentype = ad.opentype
                        ads.simpChinese = ad.simpChinese
                        ads.sort = Int64(ad.sort)
                        ads.thumb = ad.thumb
                        ads.url = ad.url
                        ads.type = "ads"
                        appDelegate.saveContext()
                        return [ad.image]
                        
                        
                    })
                    
                    //填充首頁活動圖
                    self.activitys = []
                    self.activitys =  datas.activitys.map({(ad) -> DwCache in
                        let activitys  =  DwCache(context: appDelegate.persistentContainer.viewContext)
                        activitys.image = ad.image
                        activitys.briefing = ad.briefing
                        activitys.english = ad.english
                        activitys.name = ad.name
                        activitys.opentype = ad.opentype
                        activitys.simpChinese = ad.simpChinese
                        activitys.sort = Int64(ad.sort)
                        activitys.thumb = ad.thumb
                        activitys.url = ad.url
                        activitys.type = "activitys"
                        return activitys
                        
                    }).sorted(by: { $0.sort < $1.sort })
                    
                    self.features = []
                    self.features =  datas.features.map({(ad) -> DwCache in
                        let features  =  DwCache(context: appDelegate.persistentContainer.viewContext)
                        features.image = ad.image
                        features.briefing = ad.briefing
                        features.english = ad.english
                        features.name = ad.name
                        features.opentype = ad.opentype
                        features.simpChinese = ad.simpChinese
                        features.sort = Int64(ad.sort)
                        features.thumb = ad.thumb
                        features.url = ad.url
                        features.type = "features"
                        return features
                        
                    }).sorted(by: { $0.sort < $1.sort })
                    
                    appDelegate.saveContext()
                    OperationQueue.main.addOperation {
                        self.tableView.reloadData()
                        self.refreshControl?.endRefreshing()
                        self.addMainScrollView()
                        self.createMenuBtn()
                    }
                    
                }catch{
                    if let error: DwCountBaseRootClass = DwCountBaseRootClass(fromDictionary: json){
                        print("錯誤代碼:\(error.code as Int);信息:\(error)原因:\(error.result)")
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
        
    }
    
    
    
    /*從COREDATA加載數據*/
    func fetchHomeData()  {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        //活動REUEST
        let requestActivitys : NSFetchRequest<DwCache> = DwCache.fetchRequest()
        let cateActivitys = NSPredicate.init(format: "type='activitys'")
        requestActivitys.predicate = cateActivitys
        //首頁廣告ADS
        let requestAds : NSFetchRequest<DwCache> = DwCache.fetchRequest()
        let cateAds = NSPredicate.init(format: "type='ads'")
        requestAds.predicate = cateAds
        //功能按鈕
        let requestFeatures : NSFetchRequest<DwCache> = DwCache.fetchRequest()
        let cateFeatures = NSPredicate.init(format: "type='features'")
        requestFeatures.predicate = cateFeatures
        do{
            activitys = try appDelegate.persistentContainer.viewContext.fetch(requestActivitys)
            ads = try appDelegate.persistentContainer.viewContext.fetch(requestAds)
            features = try appDelegate.persistentContainer.viewContext.fetch(requestFeatures)
            
            for ad in ads {
                scrollImageUrls.append([ad.image!])
            }
        }catch {
            print(error)
        }
        addMainScrollView()
        createMenuBtn()
    }
    
    
    
    
    
    @IBAction func featureTap(_ sender: UIButton) {
        // print("tab:\(sender.tag)")
        if  let feature : DwCache = features[sender.tag] {
            
            
            let openType = opentypeM.init(rawValue: feature.opentype!).unsafelyUnwrapped
            
            switch openType {
            case .NA:
                //原生跳转处理
                print("NA")
                
                performSegue(withIdentifier: nativeViews[feature.url!]!, sender: self)
            case .OV:
                //内部WEBVIEW跳转
                print("OV")
                if let pageVC = storyboard?.instantiateViewController(withIdentifier: "WebViewController") as? WebViewController {
                    pageVC.url = feature.url!
                    self.navigationController?.pushViewController(pageVC, animated: true)
                }
            case .WV:
                //第三方WEBVIEW跳转
                print("WV")
                ApiUtil.webViewHandle(withIdentifier: feature.url!, sender: self)
                
            default:
                print("未知类型")
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
        
        if let activity : DwCache = activitys[indexPath.row] {
            let openType = opentypeM.init(rawValue: activity.opentype!).unsafelyUnwrapped
            
            switch openType {
            case .NA:
                //原生跳转处理
                print("NA")
                performSegue(withIdentifier: nativeViews[activity.url!]!, sender: self)
            case .OV:
                //内部WEBVIEW跳转
                print("OV")
                if let pageVC = storyboard?.instantiateViewController(withIdentifier: "WebViewController") as? WebViewController {
                    pageVC.url = activity.url!
                    self.navigationController?.pushViewController(pageVC, animated: true)
                }
            case .WV:
                //第三方WEBVIEW跳转
                print("WV")
                ApiUtil.webViewHandle(withIdentifier: activity.url!, sender: self)
            default:
                print("未知类型")
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
        }
        //隐藏底部导航条
        segue.destination.hidesBottomBarWhenPushed = true
        
    }
    
    
    
    
    @IBAction func close(segue: UIStoryboardSegue){
    }
    
    
}
