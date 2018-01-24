//
//  MessageTableViewController.swift
//  DwMember
//
//  Created by Wen Jing on 2017/8/3.
//  Copyright © 2017年 Wen Jing. All rights reserved.
//

import UIKit
import Just
class MessageTableViewController: UITableViewController {
    
    var msgList: [DwMsgListBaseData] = []
    
     let spinner = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "消息"
        spinner.center = view.center
        view.addSubview(spinner)
        spinner.startAnimating()
        getMsgList()
        
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(self.getMsgList), for: .valueChanged)
        
        
        tableView.backgroundColor = UIColor(white: 0.98, alpha: 1)//美化列表
        tableView.tableFooterView = UIView(frame: CGRect.zero)//去除页脚
        tableView.separatorColor = UIColor(white: 0.9, alpha: 1)//去除分割线
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120.0
    }
    
    
    
    func getMsgList() {
        var avgs = ApiUtil.frontFunc()
        
        let sign = ApiUtil.sign(data: avgs, sender: self)
        avgs.updateValue(sign, forKey: "sign")
        
        
        Just.post(ApiUtil.msglistApi ,  data: avgs) { (result) in
            guard let json = result.json as? NSDictionary else{
                return
            }
            print(json)
            if result.ok {
                if  DwMsgListBaseRootClass(fromDictionary: json).code == 1 {
                    self.msgList = DwMsgListBaseRootClass(fromDictionary: json).data
                    
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
                    print("錯誤代碼:\(error.status);信息:\(error.message)原因:\(error.exception)")
                }
            }
            OperationQueue.main.addOperation {
                self.refreshControl?.endRefreshing() //查询结果后关闭刷新效果
                self.spinner.stopAnimating()//关闭加载效果
                 self.tableView.reloadData()
                
                
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
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return msgList.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "msgCell", for: indexPath) as! MessageTableViewCell
        
        let msg = msgList[indexPath.row]
        cell.titleLab.text = msg.title
        cell.briefingLab.text = msg.briefing
        cell.dataTimeLab.text = msg.dateTime
        cell.isreadLab.text =  msg.isread  ? "已讀"  : "未讀"
        let imgUrl = URL(string: msg.image)
        cell.msgImg.kf.setImage(with: imgUrl)
        
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
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "showMsgDetailSegue"{
            
            let dest = segue.destination as! MessageDetailViewController
            dest.msg = msgList[tableView.indexPathForSelectedRow!.row]
        }
    }
    
    
}
