//
//  CurrentQueueTableViewCell.swift
//  QandOrderManagement
//
//  Created by Pannray Samanphanchai on 11/23/2558 BE.
//  Copyright © 2558 Pannray Samanphanchai. All rights reserved.
//

import UIKit

class CurrentQueueTableViewCell: UITableViewCell {

    @IBOutlet weak var tableType : UILabel!
    @IBOutlet weak var waitingQueue : UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
