//
//  MyQTableViewCell.swift
//  QandOrderManagement
//
//  Created by Pannray Samanphanchai on 11/20/2558 BE.
//  Copyright © 2558 Pannray Samanphanchai. All rights reserved.
//

import UIKit

class MyQTableViewCell: UITableViewCell {

    @IBOutlet weak var restuarnatImg : UIImageView!
    @IBOutlet weak var queueNo : UILabel!
    @IBOutlet weak var branchName : UILabel!
    @IBOutlet weak var noOfPerson: UILabel!
    @IBOutlet weak var img1: UIImageView!
    @IBOutlet weak var img2: UIImageView!
    
    let titleFont : UIFont = UIFont(name: "ravenna-serial-medium-regular", size: 20.0)!
    let subTitleFont : UIFont = UIFont(name: "ravenna-serial-light-regular", size: 13.0)!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.queueNo.font = titleFont
        self.branchName.font = subTitleFont
        self.noOfPerson.font = subTitleFont
        
        
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
