//
//  AboutTableViewController.swift
//  DwMember
//
//  Created by Wen Jing on 2017/7/31.
//  Copyright © 2017年 Wen Jing. All rights reserved.
//

import UIKit
import Just
import CoreLocation
class FindTableViewController: UITableViewController, CLLocationManagerDelegate {
    
    var outletList: [DwBranchsData] = []
    var latitude: Double = 0.00
    var longitude: Double = 0.00
    
    let locationManager = CLLocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(self.getOutletList), for: .valueChanged)
        
        
        tableView.backgroundColor = UIColor(white: 0.98, alpha: 1)//美化列表
        tableView.tableFooterView = UIView(frame: CGRect.zero)//去除页脚
        tableView.separatorColor = UIColor(white: 0.9, alpha: 1)//去除分割线

        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150.0
    }
    
    override func viewDidAppear(_ animated: Bool) {
        getOutletList()
    }
    
    func getOutletList() {
        var avgs = ApiUtil.frontFunc()
        
        let sign = ApiUtil.sign(data: avgs, sender: self)
        avgs.updateValue(sign, forKey: "sign")
        avgs.updateValue(ApiUtil.companyCode, forKey: "company")
         avgs.updateValue(self.latitude, forKey: "latitude")
         avgs.updateValue(self.longitude, forKey: "longitude")
        
        //dump(avgs)
        Just.post(ApiUtil.outletApi ,  data: avgs) { (result) in
            guard let json = result.json as? NSDictionary else{
                return
            }
          //print(json)
            if result.ok {
                if  DwBranchsRootClass(fromDictionary: json).code == 1 {
                    self.outletList = DwBranchsRootClass(fromDictionary: json).data
                    
                    OperationQueue.main.addOperation {
                        self.refreshControl?.endRefreshing() //查询结果后关闭刷新效果
                        self.tableView.reloadData()
                        
                    }
                }else {
                    //異常處理
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
                    print("錯誤代碼:\(error.status);信息:\(error.message)原因:\(error.exception)")
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
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return outletList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FindCell", for: indexPath) as! FindTableViewCell
        let outlet = self.outletList[indexPath.row]
        if let imgUrlStr = outlet.image {
            let imgUrl = URL(string: imgUrlStr)
            cell.bgImg.kf.setImage(with: imgUrl)
        }
   
        cell.titleLab.text = outlet.name1!
        
        let distance = Double(String(format: "%.1f", outlet.distance!/100000))!
        cell.distance.text =  "\(distance)km"

        
        
        
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
    
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        let location:CLLocation = locations[locations.count-1]
//        //currLocation = locations.last
//        latitude = Double(String(format: "%.1f", location.coordinate.latitude))!
//        longitude = Double(String(format: "%.1f", location.coordinate.longitude))!
//
//
//        print("經度:\(latitude) 緯度\(longitude)")
//         locationManager.stopUpdatingLocation()
////        label1.text = "\(currentLocation!.coordinate.latitude)"
////        label2.text = "\(currentLocation!.coordinate.longitude)"
////        label3.text = "\(currentLocation!.altitude)"
//    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location:CLLocation = locations[locations.count-1]
                //currLocation = locations.last
                latitude = Double(String(format: "%.1f", location.coordinate.latitude))!
                longitude = Double(String(format: "%.1f", location.coordinate.longitude))!
        print("緯度:\(latitude) 經度\(longitude)")
                locationManager.stopUpdatingLocation()
    }
    
    

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showBranchDetailSegue"{
            
            let dest = segue.destination as! BranchDetailTableViewController
            dest.branch = self.outletList[tableView.indexPathForSelectedRow!.row]
        }
    }
    

}
