//
//  BranchDetailTableViewCell.swift
//  DwMember
//
//  Created by Wen Jing on 2017/9/3.
//  Copyright © 2017年 Wen Jing. All rights reserved.
//

import UIKit

class BranchDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLab: UILabel!
    @IBOutlet weak var valueLab: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
