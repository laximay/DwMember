//
//  CouponTableViewCell.swift
//  DwMember
//
//  Created by wenjing on 2017/8/17.
//  Copyright © 2017年 Wen Jing. All rights reserved.
//

import UIKit

class CouponTableViewCell: UITableViewCell {

   
    @IBOutlet weak var titleLab: UILabel!
    @IBOutlet weak var expiredLab: UILabel!
    @IBOutlet weak var descLab: UILabel!
    @IBOutlet weak var couponImg: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
