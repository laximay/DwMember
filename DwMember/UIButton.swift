//
//  UIButton.swift
//  DwMember
//
//  Created by Wen Jing on 2017/8/1.
//  Copyright © 2017年 Wen Jing. All rights reserved.
//

import UIKit
import Kingfisher
extension UIButton {
    
    @objc func set(image anImage: String?, title: String,
                   titlePosition: UIViewContentMode, additionalSpacing: CGFloat, state: UIControlState){
        //self.imageView?.contentMode = .scaleAspectFill
        let imgUrl = URL(string: anImage!)
        self.kf.setImage(with: imgUrl, for: state)

        positionLabelRespectToImage(title: title, position: titlePosition, spacing: additionalSpacing)
        
        self.titleLabel?.contentMode = .center
        self.setTitle(title, for: state)
        
        
    }
    
    @objc func setLocal(image anImage: UIImage, title: String,
                   titlePosition: UIViewContentMode, additionalSpacing: CGFloat, state: UIControlState){
       
        self.setImage(anImage.withRenderingMode(.alwaysOriginal), for: state)
        
        
        positionLabelRespectToImage(title: title, position: titlePosition, spacing: additionalSpacing)
        
        self.titleLabel?.contentMode = .center
        self.setTitle(title, for: state)
        
        
    }

    
    private func positionLabelRespectToImage(title: String, position: UIViewContentMode,
                                             spacing: CGFloat) {
        
        let imageSize = self.imageRect(forContentRect: self.frame)
//        dump("大小\(self.imageView?.frame)")
//        dump("整體偏移\(self.image(for: .normal)?.size)")
        let titleFont = self.titleLabel?.font!
        let titleSize = title.size(attributes: [NSFontAttributeName: titleFont!])
        
        var titleInsets: UIEdgeInsets
        var imageInsets: UIEdgeInsets
        
        switch (position){
        case .top:
            titleInsets = UIEdgeInsets(top: -(imageSize.height + titleSize.height + spacing),
                                       left: -(imageSize.width), bottom: 0, right: 0)
            imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -titleSize.width)
        case .bottom:
            titleInsets = UIEdgeInsets(top: (imageSize.height-10 + titleSize.height + spacing),
                                       left: -(imageSize.width), bottom: 0, right: 0)
            imageInsets = UIEdgeInsets(top: -10, left: 0, bottom: 0, right: -titleSize.width)
        case .left:
            titleInsets = UIEdgeInsets(top: 0, left: -(imageSize.width * 2), bottom: 0, right: 0)
            imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0,
                                       right: -(titleSize.width * 2 + spacing))
        case .right:
            titleInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -spacing)
            imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        default:
            titleInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
        
  
        self.titleEdgeInsets = titleInsets
        self.imageEdgeInsets = imageInsets
    }
}



