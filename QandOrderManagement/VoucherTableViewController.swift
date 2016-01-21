//
//  VoucherTableViewController.swift
//  QandOrder
//
//  Created by Warunee Phattharakijwanich on 11/13/2558 BE.
//  Copyright © 2558 IBM. All rights reserved.
//

import UIKit

class VoucherTableViewController: UITableViewController {
    var common:CommonController!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewWillAppear(animated: Bool) {
        // Initial Notification for back to the first page
        common = CommonController()
        common.initializeTab5(self)
    }
    override func viewDidDisappear(animated: Bool) {
        common.deinitNotification()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
