//
//  GuiderViewController.swift
//  DwMember
//
//  Created by Wen Jing on 2017/8/10.
//  Copyright © 2017年 Wen Jing. All rights reserved.
//

import UIKit
import Just
class GuiderViewController: UIPageViewController, UIPageViewControllerDataSource {
    
    var headings = ["填寫簡單信息"
        , "接收優惠", "積分禮遇"]
    var images = ["card", "card", "card"]
    var footers = ["會籍註冊" , "更多優惠" ,"會員商城"]
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = self
        
        if let startVC = self.vc(atIndex: 0){
            self.setViewControllers([startVC], direction: .forward, animated: true, completion: nil)
        }
        
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! ContentViewController).index
        index += 1
        return vc(atIndex: index)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! ContentViewController).index
        index -= 1
        return vc(atIndex: index)
        
    }
    //系统自带的页码
    //    func presentationCount(for pageViewController: UIPageViewController) -> Int {
    //        return headings.count
    //    }
    //
    //    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
    //        return 0
    //    }
    
    func vc(atIndex : Int) -> ContentViewController? {
        if case 0..<headings.count = atIndex {
            if let contentVC = storyboard?.instantiateViewController(withIdentifier: "ContentControll") as? ContentViewController{
                contentVC.heading = headings[atIndex]
                contentVC.footer = footers[atIndex]
                contentVC.imageName = images[atIndex]
                contentVC.index = atIndex
                
                return contentVC
            }
        }
        return nil
    }
    
}
