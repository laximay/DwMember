//
//  UIImage.swift
//  DwMember
//
//  Created by wenjing on 2017/8/15.
//  Copyright © 2017年 Wen Jing. All rights reserved.
//

import UIKit

extension UIImage {
    /**
     *  重设图片大小
     */
    func reSizeImage(reSize:CGSize)->UIImage {
        //UIGraphicsBeginImageContext(reSize);
        UIGraphicsBeginImageContextWithOptions(reSize,false,UIScreen.main.scale);
        let reRect = CGRect(x: 0, y: 0, width: reSize.width, height: reSize.height)
        self.draw(in: reRect);
        let reSizeImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!;
        UIGraphicsEndImageContext();
        return reSizeImage;
    }
    
    /**
     *  等比率缩放
     */
    func scaleImage(scaleSize:CGFloat)->UIImage {
        let reSize = CGSize(width: self.size.width * scaleSize, height: self.size.height * scaleSize)
       
        return reSizeImage(reSize: reSize)
    }
}
