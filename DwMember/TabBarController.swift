//
//  TabBarController.swift
//  DwMember
//
//  Created by Wen Jing on 2017/7/31.
//  Copyright © 2017年 Wen Jing. All rights reserved.
//

import UIKit
import ESTabBarController_swift
class TabBarController {

 
    
    class func CustomTabBar()->ESTabBarController {
        let tabBarController = ESTabBarController()
        tabBarController.delegate = nil
        tabBarController.title = "Irregularity"
        tabBarController.tabBar.shadowImage = UIImage(named: "transparent")
        tabBarController.tabBar.backgroundImage = UIImage(named: "background_dark")
        
        let tab1 = MainTableViewController()
        let tab2 = MallTableViewController();
        let tab3 = PayViewController();
        let tab4 = MeTableViewController();
        let tab5 = FindTableViewController();
        
        let MainNav = UINavigationController(rootViewController:tab1)
        
        MainNav.tabBarItem =  ESTabBarItem.init(IrregularityBasicContentView(), title: "Home", image: UIImage(named: "home"), selectedImage: UIImage(named: "home_1"))
        tab2.tabBarItem = ESTabBarItem.init(IrregularityBasicContentView(), title: "Mall", image: UIImage(named: "shop"), selectedImage: UIImage(named: "shpo_1"))
        tab3.tabBarItem = ESTabBarItem.init(IrregularityContentView(), title: "Pay", image: UIImage(named: "qrcode"), selectedImage: UIImage(named: "qrcode_1"))
       
        tab4.tabBarItem = ESTabBarItem.init(IrregularityBasicContentView(), title: "Find", image: UIImage(named: "find"), selectedImage: UIImage(named: "find_1"))
        tab5.tabBarItem = ESTabBarItem.init(IrregularityBasicContentView(), title: "Me", image: UIImage(named: "me"), selectedImage: UIImage(named: "me_1"))
        
        tabBarController.viewControllers = [MainNav, tab2, tab3, tab4, tab5]
        
     
        tabBarController.title = "Example"
        return tabBarController

       
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
