//
//  BranchsMapViewController.swift
//  DwMember
//
//  Created by Wen Jing on 2018/1/27.
//  Copyright © 2018年 Wen Jing. All rights reserved.
//

import UIKit
import MapKit
import Just
import CoreLocation
class BranchsMapViewController: UIViewController,MKMapViewDelegate {

     var mapView: MKMapView!
    let id = "myid"
    override func viewDidLoad() {
        navigationController?.setNavigationBarHidden(false, animated: true)
        super.viewDidLoad()
        self.mapView = MKMapView(frame:self.view.frame)
        self.view.addSubview(self.mapView)
        self.mapView.delegate = self
        
        //mapView.showsScale = true //标尺
        //mapView.showsCompass = true //显示指南针
        mapView.showsTraffic = true //交通信息
        mapView.showsUserLocation = true //显示用户位置
        mapView.showsBuildings = true //显示建筑物
        mapView.mapType = MKMapType.standard
        
        getOutletList()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
//    //自定义标注的方法
//     func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
//        if annotation is MKUserLocation{
//            return nil
//        }
//
//        var av = mapView.dequeueReusableAnnotationView(withIdentifier: id) as? MKPinAnnotationView
//        if av == nil{
//            av = MKPinAnnotationView(annotation: annotation, reuseIdentifier: id)
//            av?.canShowCallout = true
//        }
//        let leftIconView = UIImageView(frame: CGRect(x: 0, y: 0, width: 53, height: 53))
//        leftIconView.image = #imageLiteral(resourceName: "zdlogo-r")
//        av?.leftCalloutAccessoryView = leftIconView
//        //av?.pinTintColor = UIColor.green
//        return av
//    }
    
    func initMap(title: String, address: String, latitude: Double, longitude: Double)  {
        
        //创建一个大头针对象
        let objectAnnotation = MKPointAnnotation()
        //设置大头针的显示位置
        objectAnnotation.coordinate = CLLocation(latitude:longitude,
                                                 longitude: latitude).coordinate
        //设置点击大头针之后显示的标题
        objectAnnotation.title = title
        //设置点击大头针之后显示的描述
        objectAnnotation.subtitle = address
        let latDelta = 0.1
        let longDelta = 0.1
        let currentLocationSpan:MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: longDelta)
       let currentRegion:MKCoordinateRegion = MKCoordinateRegion(center: objectAnnotation.coordinate, span: currentLocationSpan)
        
        self.mapView.setRegion(currentRegion, animated: true)
        //添加大头针
      //  self.mapView.addAnnotation(objectAnnotation)
        self.mapView.showAnnotations([objectAnnotation], animated: true)
        self.mapView.selectAnnotation(objectAnnotation, animated: true)

      
            
      
    
    }
    
    
    func getOutletList() {
        var avgs = ApiUtil.frontFunc()
        
        let sign = ApiUtil.sign(data: avgs, sender: self)
        avgs.updateValue(sign, forKey: "sign")
        avgs.updateValue(ApiUtil.companyCode, forKey: "company")
        avgs.updateValue(ApiUtil.serial, forKey: "serial")
        avgs.updateValue(0.00, forKey: "latitude")
        avgs.updateValue(0.00, forKey: "longitude")
        
        //dump(avgs)
        Just.post(ApiUtil.outletApi ,  data: avgs, asyncCompletionHandler:  { (result) in
            guard let json = result.json as? NSDictionary else{
                return
            }
            //            print(json)
            if result.ok {
                if  DwBranchsRootClass(fromDictionary: json).code == 1 {
                    DwBranchsRootClass(fromDictionary: json).data.forEach({ (outlet) in
                        OperationQueue.main.addOperation {
                            self.initMap(title: "\(outlet.name1!),電話:\(outlet.telphone!)", address: outlet.address, latitude: Double(outlet.latitude)!, longitude: Double(outlet.longitude)!)
                        }
                    })
                    
                    
                }else {
                    //異常處理
                    let error: DwCountBaseRootClass = DwCountBaseRootClass(fromDictionary: json) 
                    OperationQueue.main.addOperation {
                        ApiUtil.openAlert(msg: error.msg, sender: self)
                    }
                    
                }
            }
            else{
                //處理接口系統錯誤
                let error: DwErrorBaseRootClass = DwErrorBaseRootClass(fromDictionary: json)
                OperationQueue.main.addOperation {
                    ApiUtil.openAlert(msg: error.message, sender: self)
                }
                
            }
            
        })
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
