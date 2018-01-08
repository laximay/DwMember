//
//  MyTabBarViewController.swift
//  DwMember
//
//  Created by Wen Jing on 2017/8/2.
//  Copyright © 2017年 Wen Jing. All rights reserved.
//

import UIKit
import ESTabBarController_swift
import BubbleTransition
class MyTabBarViewController: ESTabBarController, UITabBarControllerDelegate, UIViewControllerTransitioningDelegate {
    let transition = BubbleTransition() //第三方轉場動畫
    let mainSB = UIStoryboard(name: "Main", bundle: Bundle.main)
    let queueSB = UIStoryboard(name: "Queue", bundle: Bundle.main)
    let couponSB = UIStoryboard(name: "Coupon", bundle: Bundle.main)
    let meSB = UIStoryboard(name: "Me", bundle: Bundle.main)
    override func viewDidLoad() {
        super.viewDidLoad()
        
        CustomTabBar()
        // Do any additional setup after loading the view.
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
//        let defaults = UserDefaults.standard
//        //系统分配的存储空间，可以存储一般小的数据
//        if !defaults.bool(forKey: "GuiderShow"){
//            if let pageVC = mainSB.instantiateViewController(withIdentifier: "GuideConntroller") as? GuiderViewController {
//                present(pageVC, animated: true, completion: nil)
//            }
//        }
        //如果分割了Storyboard 则需要这样引入
        // let aboutSB = UIStoryboard(name: "about", bundle: Bundle.main)
        
       

    }
    
    
    
    
    
    func CustomTabBar() {
        
        //開啟劫持點擊事件webViewHandle
        self.shouldHijackHandler = {
            tabbarController, viewController, index in
            if index == 1 {
                return true
            }
            
            return false
        }
        //劫持事件
        self.didHijackHandler = {
            [weak tabBarController] tabbarController, viewController, index in
             if index == 1 {
            let payVC1 = self.mainSB.instantiateViewController(withIdentifier: "PayViewController")
            payVC1.transitioningDelegate = self //獲得動畫代理
            self.present(payVC1, animated: true, completion: nil)
             }
            
        }
        
        self.title = "dwMember"
        self.tabBar.shadowImage = UIImage(named: "transparent")
        self.tabBar.backgroundImage = UIImage(named: "background")
        /*  使用storyboard進行跳轉
         let sb = UIStoryboard(name:"Search",bundle: Bundle.main)
         
         let vc = sb.instantiateViewController(withIdentifier: "search")
         
         self.present(vc, animated: true, completion: nil)
         */
        
        
        let homeNav = mainSB.instantiateViewController(withIdentifier: "homeNav") //一定要用這種方式讀取，要不然會關聯不到storyboard
        homeNav.tabBarItem =  ESTabBarItem.init(IrregularityBasicContentView(), title: NSLocalizedString("Home", comment: "主頁"), image: UIImage(named: "ic_home29"), selectedImage: UIImage(named: "ic_home_on29"))
        
//        let couponNav = couponSB.instantiateViewController(withIdentifier: "couponNav")
//        couponNav.tabBarItem = ESTabBarItem.init(IrregularityBasicContentView(), title: NSLocalizedString("Mall", comment: "商城") , image: UIImage(named: "ic_store29"), selectedImage: UIImage(named: "ic_store_on29"))
        
        let payVC = mainSB.instantiateViewController(withIdentifier: "PayViewController")
        payVC.tabBarItem = ESTabBarItem.init(IrregularityContentView(), title: nil, image: UIImage(named: "qrcode"), selectedImage: UIImage(named: "qrcode_1"))
        
//        let queueNav = queueSB.instantiateViewController(withIdentifier: "tempNav")
//        queueNav.tabBarItem = ESTabBarItem.init(IrregularityBasicContentView(), title: NSLocalizedString("Queue", comment: "叫號") , image: UIImage(named: "ic_queue"), selectedImage: UIImage(named: "ic_queue_red"))
        
        
        let meNav = meSB.instantiateViewController(withIdentifier: "meNav")
        meNav.tabBarItem = ESTabBarItem.init(IrregularityBasicContentView(), title: NSLocalizedString("Me", comment: "我的") , image: UIImage(named: "ic_user29"), selectedImage: UIImage(named: "ic_user_on29"))
        
        self.viewControllers = [homeNav, payVC, meNav]
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //UIViewControllerTransitioningDelegate
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .present
        transition.startingPoint = CGPoint(x:  UIScreen.main.bounds.width/2, y:  UIScreen.main.bounds.height-50)
        transition.bubbleColor = ApiUtil.fontColor
        return transition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .dismiss
        transition.startingPoint = CGPoint(x:  UIScreen.main.bounds.width/2, y:  UIScreen.main.bounds.height-50)
        transition.bubbleColor = ApiUtil.fontColor
        return transition
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
