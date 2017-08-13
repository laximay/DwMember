//
//  MainTableViewController.swift
//  DwMember
//
//  Created by Wen Jing on 2017/7/31.
//  Copyright © 2017年 Wen Jing. All rights reserved.
//

import UIKit
import SSCycleScrollView


class MainTableViewController: UITableViewController {

    
    @IBOutlet weak var indexImageView: UIView! //放置轮播图的VIEW
    @IBOutlet weak var menuView: UIStackView! //放置功能按钮的VIEW
    var mainScrollView: SSCycleScrollView? //轮播图空间
   
    //活动的LIST，需要读取网络接口
    var  activitys : [Activitys] = [Activitys(title : "九大簋",aType : "local", thumbImage : "201707yhy", bigImage : "favor", description : "請你品嘗九大簋" ),
                                Activitys(title : "佛跳墻",aType : "local", thumbImage : "201707yhy", bigImage : "cardboard", description : "請你品嘗九大簋" ),
                                Activitys(title : "冬陰功",aType : "local", thumbImage : "201707yhy", bigImage : "photoalbum", description : "請你品嘗九大簋" ),
                                
                                    ]
    //远程首页轮播图LIST，需要读取网络接口
    var scrollImageUrls: [[String]] {
        get {
            return [["http://noodle1895.com.hk/static/imgs/dishes3.jpg", "http://noodle1895.com.hk/static/imgs/dishes5.jpg"],
                    ["http://noodle1895.com.hk/static/imgs/dishes4.jpg"],
                    ["http://noodle1895.com.hk/static/imgs/dishes8.jpg"]]
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        tableView.backgroundColor = UIColor(white: 0.98, alpha: 1)//美化列表
        tableView.tableFooterView = UIView(frame: CGRect.zero)//去除页脚
        tableView.separatorColor = UIColor(white: 0.9, alpha: 1)//去除分割线
        
        tableView.estimatedRowHeight = 200 //自适应行高
        tableView.rowHeight = UITableViewAutomaticDimension //自适应行高 ，还需设置宽度约束，动态行数设为0，0代表动态行数
       
    
        createMenuBtn()    //创建功能按钮
        addMainScrollView() //创建轮播图
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
        
        cell.thumbImage.image = UIImage(named: activity.thumbImage)
      
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
