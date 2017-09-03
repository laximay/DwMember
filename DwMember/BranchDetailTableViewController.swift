//
//  BranchDetailTableViewController.swift
//  DwMember
//
//  Created by Wen Jing on 2017/9/3.
//  Copyright © 2017年 Wen Jing. All rights reserved.
//

import UIKit
import MapKit
class BranchDetailTableViewController: UITableViewController,MKMapViewDelegate {
     var branch: DwBranchsData!

    @IBOutlet weak var mapView: MKMapView!
 
    override func viewDidLoad() {
        super.viewDidLoad()
      
        
        initMap()
        tableView.backgroundColor = UIColor(white: 0.98, alpha: 1)//美化列表
        tableView.tableFooterView = UIView(frame: CGRect.zero)//去除页脚
        tableView.separatorColor = UIColor(white: 0.9, alpha: 1)//去除分割线
        self.title = branch?.name1 //设置标题
        tableView.estimatedRowHeight = 100 //自适应行高
        tableView.rowHeight = UITableViewAutomaticDimension
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

   
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 4
        
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "branchCell", for: indexPath) as! BranchDetailTableViewCell
        

        cell.backgroundColor = UIColor.clear //透明色
        switch indexPath.row {
        case 0:
            cell.nameLab.text = "品牌"
            cell.valueLab.text = self.branch.regionName
        case 1:
            cell.nameLab.text = "全稱"
            cell.valueLab.text = self.branch.name1

        case 2:
            cell.nameLab.text = "電話"
            cell.valueLab.text = self.branch.telphone

        case 3:
            cell.nameLab.text = "地址"
            cell.valueLab.text = self.branch.address

        default:
            break
        }


        return cell
    }
 
    
    func initMap()  {
        
       // mapView.showsScale = true //标尺
       // mapView.showsCompass = true //显示指南针
       // mapView.showsTraffic = true //交通信息
        mapView.showsUserLocation = true //显示用户位置
        mapView.showsBuildings = true //显示建筑物
        mapView.mapType = MKMapType.standard
    

        //创建一个大头针对象
        let objectAnnotation = MKPointAnnotation()
        //设置大头针的显示位置
        objectAnnotation.coordinate = CLLocation(latitude:Double(branch.latitude)!,
                                                 longitude: Double(branch.longitude)!).coordinate
        //设置点击大头针之后显示的标题
        objectAnnotation.title = branch.name1
        //设置点击大头针之后显示的描述
        objectAnnotation.subtitle = branch.address
        //添加大头针
        self.mapView.showAnnotations([objectAnnotation], animated: true)
        self.mapView.selectAnnotation(objectAnnotation, animated: true)
        
        
        

    }
    
    //自定义标注的方法
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation{
                        return nil
                    }
                    let id = "myid"
                    var av = mapView.dequeueReusableAnnotationView(withIdentifier: id) as? MKPinAnnotationView
                    if av == nil{
                        av = MKPinAnnotationView(annotation: annotation, reuseIdentifier: id)
                        av?.canShowCallout = true
                    }
            
                    let leftIconView = UIImageView(frame: CGRect(x: 0, y: 0, width: 53, height: 53))
                    let url = URL(string: branch.image)
                    leftIconView.kf.setImage(with: url)
                    av?.leftCalloutAccessoryView = leftIconView
                    //av?.pinTintColor = UIColor.green
                    return av
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
