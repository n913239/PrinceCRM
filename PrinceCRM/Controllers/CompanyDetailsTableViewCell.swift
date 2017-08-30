//
//  CompanyDetailsTableViewCell.swift
//  PrinceCRM
//
//  Created by mikewang on 2017/8/30.
//  Copyright © 2017年 mike. All rights reserved.
//

import UIKit

class CompanyDetailsTableViewCell: UITableViewCell {

    @IBOutlet weak var shortLabel: UILabel!
    @IBOutlet weak var shortTextField: UITextField!
    @IBOutlet weak var longLabel: UILabel!
    @IBOutlet weak var longTextView: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
