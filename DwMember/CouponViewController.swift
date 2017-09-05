//
//  CouponViewController.swift
//  DwMember
//
//  Created by Wen Jing on 2017/8/7.
//  Copyright © 2017年 Wen Jing. All rights reserved.
//

import UIKit
import Segmentio
import Just
class CouponViewController: UIViewController, UIScrollViewDelegate {
    //顯示的樣式
    let segmentioStyle = SegmentioStyle.onlyLabel
    //默認選中的索引 可設置
    var selectIndex = 3
    var indexFlag = false
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
        
        let appdelegate = UIApplication.shared.delegate as! AppDelegate
        appdelegate.couponView = self
        segmentViewHeightConstraint.constant = 40
        print("我是你爸爸初号机")
        if indexFlag {
            viewInit()
            getCouponCount(isupdata: false)
        }
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    override func viewDidAppear(_ animated: Bool) {
        print("我是你爸爸一号机")
        ApiUtil.checklogin(sender: self)
        viewInit()
        getCouponCount(isupdata: true)
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
        setSrollViewOffset(segmentIndex: selectIndex)
        //goToControllerAtIndex(selectIndex)
        
        print("初始化：\(selectIndex)")
        
        segmentioView.valueDidChange = { [weak self] _, segmentIndex in
            
            if let scrollViewWidth = self?.scrollView.frame.width {
                let contentOffsetX = scrollViewWidth * CGFloat(segmentIndex)
                self?.scrollView.setContentOffset(
                    CGPoint(x: contentOffsetX, y: 0),
                    animated: true
                )
            }
            print("選擇:\(segmentIndex)")
            self?.getCouponCount(isupdata: false)
            switch segmentIndex {
            case 0:
                self?.viewControllers[0].viewDidLoad()
            case 1:
                self?.viewControllers[1].viewDidLoad()
            case 2:
                self?.viewControllers[2].viewDidLoad()
            case 3:
                self?.viewControllers[3].viewDidLoad()
            default:()
            }
            
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
    
    func setSrollViewOffset(segmentIndex : Int)  {
        if let scrollViewWidth: CGFloat = self.scrollView.frame.width {
            let contentOffsetX = scrollViewWidth * CGFloat(segmentIndex)
            self.scrollView.setContentOffset(
                CGPoint(x: contentOffsetX, y: 0),
                animated: true
            )
        }
    }
    
    //獲得優惠券未用數量
    func getCouponCount(isupdata: Bool) {
        var avgs = ApiUtil.frontFunc()
        let sign = ApiUtil.sign(data: avgs, sender: self)
        avgs.updateValue(sign, forKey: "sign")
        
        
        Just.post(ApiUtil.couponcountApi ,  data: avgs) { (result) in
            guard let json = result.json as? NSDictionary else{
                return
            }
            if result.ok {
                if  DwCountBaseRootClass(fromDictionary: json).code == 1 {
                    let datas = DwCountBaseRootClass(fromDictionary: json).data
                    OperationQueue.main.addOperation {
                        //添加角标
                        
                        
                        
                        if let couponCount = datas  {
                            if   self.segmentioView.segmentioItems[0].badgeCount != couponCount as! Int {
                                self.segmentioView.addBadge(
                                    at:  0,
                                    count: couponCount as! Int,
                                    color: #colorLiteral(red: 0.6581850052, green: 0.05978029221, blue: 0.1673380733, alpha: 1)
                                )
                            }
                        }
                        
                        if isupdata {
                            self.viewControllers[0].viewDidLoad()
                        }
                    }
                    
                }else {
                    //異常處理
                    if let error: DwCountBaseRootClass = DwCountBaseRootClass(fromDictionary: json){
                        print("錯誤代碼:\(error.code as Int);信息:\(error.msg)原因:\(error.result)")
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
    
}


