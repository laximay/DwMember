//
//  ViewController.swift
//  DwMember
//
//  Created by Wen Jing on 2017/8/2.
//  Copyright © 2017年 Wen Jing. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
      if #available(iOS 13.0, *) {
                 let app = UIApplication.shared
                 let statusBarHeight: CGFloat = app.statusBarFrame.size.height
                 
                 let statusbarView = UIView()
        statusbarView.backgroundColor = UIColor.red
                 view.addSubview(statusbarView)
               
                 statusbarView.translatesAutoresizingMaskIntoConstraints = false
                 statusbarView.heightAnchor
                     .constraint(equalToConstant: statusBarHeight).isActive = true
                 statusbarView.widthAnchor
                     .constraint(equalTo: view.widthAnchor, multiplier: 1.0).isActive = true
                 statusbarView.topAnchor
                     .constraint(equalTo: view.topAnchor).isActive = true
                 statusbarView.centerXAnchor
                     .constraint(equalTo: view.centerXAnchor).isActive = true
               
             } else {
                 let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView
        statusBar?.backgroundColor = UIColor.green
             }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
