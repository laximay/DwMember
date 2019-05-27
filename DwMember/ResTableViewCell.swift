//
//  ResTableViewCell.swift
//  DwMember
//
//  Created by wenjing on 2017/8/21.
//  Copyright © 2017年 Wen Jing. All rights reserved.
//

import UIKit

class ResTableViewCell: UITableViewCell {

    
    @IBOutlet weak var branchLab: UILabel! //分店名称
    @IBOutlet weak var addLab: UILabel! //地址
    @IBOutlet weak var personLab: UILabel! //人数时间
    @IBOutlet weak var timeLab: UILabel! //订座时间
    @IBOutlet weak var statusLab: UILabel! //状态
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
