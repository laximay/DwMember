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
class MainTableViewController: UITableViewController {
    
    
    @IBOutlet weak var indexImageView: UIView! //放置轮播图的VIEW
    @IBOutlet weak var menuView: UIStackView! //放置功能按钮的VIEW
    var mainScrollView: SSCycleScrollView? //轮播图空间
    
    //活动的LIST，需要读取网络接口
    var  activitys : [DwCache] = []
    
    //远程首页轮播图LIST，需要读取网络接口
    var  ads : [DwCache] = []
    var scrollImageUrls: [[String]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        homeCache()
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        tableView.backgroundColor = UIColor(white: 0.98, alpha: 1)//美化列表
        tableView.tableFooterView = UIView(frame: CGRect.zero)//去除页脚
        tableView.separatorColor = UIColor(white: 0.9, alpha: 1)//去除分割线
        
        tableView.estimatedRowHeight = 200 //自适应行高
        tableView.rowHeight = UITableViewAutomaticDimension //自适应行高 ，还需设置宽度约束，动态行数设为0，0代表动态行数
        createMenuBtn()    //创建功能按钮
    }
    
    
    
    
    
    
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200.0
    }
    
    
    //隐藏NavigationBar
    //    override func viewWillAppear(_ animated: Bool) {
    //        navigationController?.setNavigationBarHidden(true, animated: true)
    //    }
    
    
    func addMainScrollView() {
        let currentRect =  self.indexImageView.bounds
        self.mainScrollView = SSCycleScrollView.init(frame: currentRect, animationDuration: 3, inputImageUrls: self.scrollImageUrls)
        self.mainScrollView?.tapBlock = {index in
            //在这里处理点击轮播图的的事件
            print("tapped page\(index)")
        }
        //        self.mainScrollView?.autoScroll = false
        self.indexImageView.addSubview(self.mainScrollView!)
    }
    
    func homeCache()  {
        //先加載CORE的數據
        fetchHomeData()
        //異步請求會覆蓋上一步的數據，重新填充
        Just.post(ApiUtil.homeApi ,  data: ["company": ApiUtil.companyCode]) { (result) in
            guard let json = result.json as? NSDictionary else{
                return
            }
            let datas = DwHomeRootClass(fromDictionary: json).data!
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            do{
                let allData : [DwCache] = try appDelegate.persistentContainer.viewContext.fetch(DwCache.fetchRequest())
                
                for ad in allData {
                    appDelegate.persistentContainer.viewContext.delete(ad)
                    appDelegate.saveContext()
                }
                
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
                    ads.thumb = ad.thumb as! String
                    ads.url = ad.url
                    ads.type = "ads"
                    appDelegate.saveContext()
                    return [ad.image]
                    
                    
                })
                
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
                    activitys.thumb = ad.thumb as! String
                    activitys.url = ad.url
                    activitys.type = "activitys"
                    return activitys
                    
                })
                
                appDelegate.saveContext()
                OperationQueue.main.addOperation {
                    self.tableView.reloadData()
                    self.refreshControl?.endRefreshing()
                    self.addMainScrollView()
                }
                
            }catch{
                print(error)
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
        do{
            activitys = try appDelegate.persistentContainer.viewContext.fetch(requestActivitys)
            ads = try appDelegate.persistentContainer.viewContext.fetch(requestAds)
            
            for ad in ads {
                scrollImageUrls.append([ad.image!])
            }
        }catch {
            print(error)
        }
        addMainScrollView()
    }
    
    
    
    
    
    
    //創建功能按鈕,原生的滿足不了需求，擴展了一個
    func createMenuBtn() {
        let btnBooking = menuView.arrangedSubviews[0] as! UIButton
        btnBooking.set(image: UIImage(named: "home"), title: "訂座", titlePosition: .bottom,
                       additionalSpacing: 10.0, state: .normal)
        
        
        
        let btnQueue = menuView.arrangedSubviews[1] as! UIButton
        btnQueue.set(image: UIImage(named: "find"), title: "取號", titlePosition: .bottom,
                     additionalSpacing: 10.0, state: .normal)
        
        let btnIntgel = menuView.arrangedSubviews[2] as! UIButton
        btnIntgel.set(image: UIImage(named: "favor"), title: "積分", titlePosition: .bottom,
                      additionalSpacing: 10.0, state: .normal)
        
        let btnCoupon = menuView.arrangedSubviews[3] as! UIButton
        btnCoupon.set(image: UIImage(named: "shop"), title: "優惠券", titlePosition: .bottom,
                      additionalSpacing: 10.0, state: .normal)
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
    
    @IBAction func close(segue: UIStoryboardSegue){
    }
    
    
}
