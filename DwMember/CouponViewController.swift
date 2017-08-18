//
//  CouponViewController.swift
//  DwMember
//
//  Created by Wen Jing on 2017/8/7.
//  Copyright © 2017年 Wen Jing. All rights reserved.
//

import UIKit
import Segmentio
class CouponViewController: UIViewController, UIScrollViewDelegate {
    //顯示的樣式
    let segmentioStyle = SegmentioStyle.onlyLabel
    //默認選中的索引 可設置
    var selectIndex = 3
    @IBOutlet weak var segmentioView: Segmentio!
    @IBOutlet weak var segmentViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    //子視圖數組
    fileprivate lazy var viewControllers: [UIViewController] = {
        return self.preparedViewControllers()
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        segmentViewHeightConstraint.constant = 40
        viewInit()
       
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    func viewInit()  {
        setupScrollView()
        
        SegmentioBuilder.buildSegmentioView(
            segmentioView: segmentioView,
            segmentioStyle: segmentioStyle
        )
        //需要顯示提醒的索引
        SegmentioBuilder.setupBadgeCountForIndex(segmentioView, index: 0)
        //默認選中的索引
        segmentioView.selectedSegmentioIndex = selectIndex
        
        segmentioView.valueDidChange = { [weak self] _, segmentIndex in
            if let scrollViewWidth = self?.scrollView.frame.width {
                let contentOffsetX = scrollViewWidth * CGFloat(segmentIndex)
                self?.scrollView.setContentOffset(
                    CGPoint(x: contentOffsetX, y: 0),
                    animated: true
                )
            }
            print("選擇:\(segmentIndex)")
        }
        
    }
    
    
    
    // 子視圖 viewControllers
    
    fileprivate func preparedViewControllers() -> [CouponTableViewController] {
        let unusedController = CouponTableViewController.create() //未使用
        unusedController.couponS = .unuse
        let usedController = CouponTableViewController.create()//已使用
        usedController.couponS = .use
        let expiredController = CouponTableViewController.create()//過期
        expiredController.couponS = .over
        let mallController = CouponTableViewController.create()//積分商城
        mallController.couponS = .mall
        return [
            unusedController,
            usedController,
            expiredController,
            mallController
        ]
    }
    
    
    
    // MARK: - Setup container view
    
    fileprivate func setupScrollView() {
        scrollView.contentSize = CGSize(
            width: UIScreen.main.bounds.width * CGFloat(viewControllers.count),
            height: containerView.frame.height
        )
        
        for (index, viewController) in viewControllers.enumerated() {
            viewController.view.frame = CGRect(
                x: UIScreen.main.bounds.width * CGFloat(index),
                y: 0,
                width: scrollView.frame.width,
                height: scrollView.frame.height
            )
            addChildViewController(viewController)
            scrollView.addSubview(viewController.view, options: .useAutoresize) // module's extension
            viewController.didMove(toParentViewController: self)
        }
    }
    
    // MARK: - Actions
    
    fileprivate func goToControllerAtIndex(_ index: Int) {
        segmentioView.selectedSegmentioIndex = index
    }
    
    //UIScrollViewDelegate
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let currentPage = floor(scrollView.contentOffset.x / scrollView.frame.width)
        segmentioView.selectedSegmentioIndex = Int(currentPage)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollView.contentSize = CGSize(width: scrollView.contentSize.width, height: 0)
    }
    
}


