//
//  ScanViewController.swift
//  DwMember
//
//  Created by Wen Jing on 2017/10/28.
//  Copyright © 2017年 Wen Jing. All rights reserved.
//

import UIKit
import swiftScan
class ScanViewController: LBXScanViewController {
    
    /**
     @brief  扫码区域上方提示文字
     */
    var topTitle:UILabel?
    
    /**
     @brief  闪关灯开启状态
     */
    var isOpenedFlash:Bool = false
    
    // MARK: - 底部几个功能：开启闪光灯、相册、我的二维码
    

    
    //相册
    var btnPhoto:UIButton = UIButton()
    
    //闪光灯
    var btnFlash:UIButton = UIButton()
    
    //我的二维码
    var btnMyQR:UIButton = UIButton()
    
    let mainSB = UIStoryboard(name: "Main", bundle: Bundle.main)
    
  
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(false, animated: true)
        //需要识别后的图像
        setNeedCodeImage(needCodeImg: true)
        
        //框向上移动10个像素
        scanStyle?.centerUpOffset += 10
        
        
        // Do any additional setup after loading the view.
    }

    //SDK里面是在VIEWDIDAPPEAR加载，这里加载会有问题，改在viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        drawScanView()
        drawBottomItems()
        
        perform(#selector(LBXScanViewController.startScan), with: nil, afterDelay: 0.3)
    }
    
    
    
    override func handleCodeResult(arrayResult: [LBXScanResult]) {
        
        let result:LBXScanResult = arrayResult[0]
        if let pageVC = mainSB.instantiateViewController(withIdentifier: "WebViewController") as? WebViewController {
            pageVC.url = result.strScanned!
            pageVC.type = "OV"
            self.navigationController?.pushViewController(pageVC, animated: true)
        }
        
    }
    
    func drawBottomItems()
    {
      
        let yMax = self.view.frame.maxY - self.view.frame.minY
  
        
        let size = CGSize(width: 65, height: 87);
        
        self.btnFlash = UIButton()
        btnFlash.bounds = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        btnFlash.center = CGPoint(x: self.view.frame.width/2, y: yMax-100)
        btnFlash.setImage(UIImage(named: "qrcode_scan_btn_flash_nor"), for:UIControl.State.normal)
        btnFlash.addTarget(self, action: #selector(ScanViewController.openOrCloseFlash), for: UIControl.Event.touchUpInside)
    
        self.view.addSubview(btnFlash)
        
    }
    
    //开关闪光灯
    @objc func openOrCloseFlash()
    {
        scanObj?.changeTorch();
        
        isOpenedFlash = !isOpenedFlash
        
        if isOpenedFlash
        {
            btnFlash.setImage(UIImage(named: "qrcode_scan_btn_scan_off"), for:UIControl.State.normal)
        }
        else
        {
            btnFlash.setImage(UIImage(named: "qrcode_scan_btn_flash_nor"), for:UIControl.State.normal)
        }
    }
    
 
    
    
}

