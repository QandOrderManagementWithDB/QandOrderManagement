//
//  LogInViewController.swift
//  QandOrder
//
//  Created by Warunee Phattharakijwanich on 11/10/2558 BE.
//  Copyright © 2558 IBM. All rights reserved.
//

import UIKit

class LogInViewController: UIViewController {
    
    var common:CommonController!
    @IBAction func logInFB(sender: AnyObject) {
        
    }
    
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
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
