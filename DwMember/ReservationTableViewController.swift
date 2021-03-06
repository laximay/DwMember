//
//  ReservationTableViewController.swift
//  DwMember
//
//  Created by wenjing on 2017/8/21.
//  Copyright © 2017年 Wen Jing. All rights reserved.
//

import UIKit
import Just
class ReservationTableViewController: UITableViewController {
    
    
    
     let spinner = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
    var resList: [DwReservationReList] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getResList()
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(self.getResList), for: .valueChanged)
        
        spinner.center = view.center
        view.addSubview(spinner)
        tableView.backgroundColor = UIColor(white: 0.98, alpha: 1)//美化列表
        tableView.tableFooterView = UIView(frame: CGRect.zero)//去除页脚
        tableView.separatorColor = UIColor(white: 0.9, alpha: 1)//去除分割线
        
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150.0
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
        return resList.count
    }
    
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "resCell", for: indexPath) as! ResTableViewCell
        let res = self.resList[indexPath.row]
        let persons  = res.persons.map{ "\($0.viewName!):\($0.personNum!)" }.joined(separator: ",")

        cell.branchLab.text = res.branch.name1
        cell.addLab.text = res.branch.addr
        cell.personLab.text = res.person+"(\(persons))"
        cell.timeLab.text = res.indate! + " " + res.intime!
        cell.statusLab.text = res.iscomfrim == "0" ? NSLocalizedString("Waiting for confirmation", comment: "待確認") : NSLocalizedString("Confirmed", comment: "已確認")
        
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
    
    func getResList() {
            var avgs = ApiUtil.frontFunc()
            avgs.updateValue("N", forKey: "isApp")
            
            let sign = ApiUtil.sign(data: avgs, sender: self)
            avgs.updateValue(sign, forKey: "sign")
            
            
            Just.post(ApiUtil.reservationApi ,  data: avgs) { (result) in
                guard let json = result.json as? NSDictionary else{
                    return
                }
                print(json)
                if result.ok {
                    if  DwReservationRootClass(fromDictionary: json).code == 1 {
                        if let resData   = DwReservationRootClass(fromDictionary: json).data {
                            self.resList = resData.reList
                            OperationQueue.main.addOperation {
                                self.refreshControl?.endRefreshing() //查询结果后关闭刷新效果
                                self.spinner.stopAnimating()//关闭加载效果
                                self.tableView.reloadData()
                                
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
                    }
                }else{
                    //處理接口系統錯誤
                    if let error: DwErrorBaseRootClass = DwErrorBaseRootClass(fromDictionary: json){
                        print("錯誤代碼:\(error.status);信息:\(error.message)原因:\(error.exception)")
                    }
                }
                
            }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "reservationDetailSegue"{
            let dest = segue.destination as! ResDetailTableViewController
            dest.resDetail = resList[tableView.indexPathForSelectedRow!.row]
            
        }
        //隐藏底部导航条
        segue.destination.hidesBottomBarWhenPushed = true
        
    }

    
    
}
