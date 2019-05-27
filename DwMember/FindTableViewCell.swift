//
//  FindTableViewCell.swift
//  DwMember
//
//  Created by wenjing on 2017/8/28.
//  Copyright © 2017年 Wen Jing. All rights reserved.
//

import UIKit

class FindTableViewCell: UITableViewCell {

    @IBOutlet weak var bgImg: UIImageView!
    @IBOutlet weak var titleLab: UILabel!
    @IBOutlet weak var distance: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
