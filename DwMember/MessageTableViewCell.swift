//
//  MessageTableViewCell.swift
//  DwMember
//
//  Created by wenjing on 2017/8/17.
//  Copyright © 2017年 Wen Jing. All rights reserved.
//

import UIKit

class MessageTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLab: UILabel!
    @IBOutlet weak var briefingLab: UILabel!
    @IBOutlet weak var dataTimeLab: UILabel!
    @IBOutlet weak var msgImg: UIImageView!
    @IBOutlet weak var isreadLab: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
