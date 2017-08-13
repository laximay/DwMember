//
//  ContentViewController.swift
//  DwMember
//
//  Created by Wen Jing on 2017/8/10.
//  Copyright © 2017年 Wen Jing. All rights reserved.
//

import UIKit
import Kingfisher
class ContentViewController: UIViewController {
    
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var lableHeading: UILabel!
    @IBOutlet weak var btnDone: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var lableFooter: UILabel!

    var index = 0

    var heading = ""
    var footer = ""
    var imageName = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        lableHeading.text = heading
        lableFooter.text = footer
        imageView.kf.setImage(with: URL(string: imageName))
        pageControl.currentPage = index
        btnDone.isHidden = (index != 2)
        // Do any additional setup after loading the view.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func doneBtnTap(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
        let defaults = UserDefaults.standard
        //如果点击了则把点过的动作标志保存到存储空间，以便启动时候检查
        defaults.set(true, forKey: "GuiderShow")
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
