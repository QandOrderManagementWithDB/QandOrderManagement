//
//  CommonController.swift
//  QandOrderManagement
//
//  Created by Kewalin Sakawattananon on 11/26/2558 BE.
//  Copyright © 2558 Pannray Samanphanchai. All rights reserved.
//

import UIKit

class CommonController: UIViewController {
    var viewController:UIViewController!
    // tab 1
    func initializeTab1(viewController:UIViewController) {
        self.viewController = viewController
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "tab1ChangeMethod:", name: "tab1Change", object: nil)
    }
    
    func tab1ChangeMethod(notif: NSNotification) {
        print("1 Notification : Section Changed")
        self.viewController.performSegueWithIdentifier("exitToMainPage1Segue", sender: nil)
    }
    // tab 2
    func initializeTab2(viewController:UIViewController) {
        self.viewController = viewController
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "tab2ChangeMethod:", name: "tab2Change", object: nil)
    }
    
    func tab2ChangeMethod(notif: NSNotification) {
        print("2 Notification : Section Changed")
        self.viewController.performSegueWithIdentifier("exitToMainPage2Segue", sender: nil)
    }
    // tab 3
    func initializeTab3(viewController:UIViewController) {
        self.viewController = viewController
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "tab3ChangeMethod:", name: "tab3Change", object: nil)
    }
    
    func tab3ChangeMethod(notif: NSNotification) {
        print("3 Notification : Section Changed")
        self.viewController.performSegueWithIdentifier("exitToMainPage3Segue", sender: nil)
    }
    
    // tab 4
    func initializeTab4(viewController:UIViewController) {
        self.viewController = viewController
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "tab4ChangeMethod:", name: "tab4Change", object: nil)
    }
    
    func tab4ChangeMethod(notif: NSNotification) {
        print("4 Notification : Section Changed")
        self.viewController.performSegueWithIdentifier("exitToMainPage4Segue", sender: nil)
    }
    // tab 5
    func initializeTab5(viewController:UIViewController) {
        self.viewController = viewController
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "tab5ChangeMethod:", name: "tab5Change", object: nil)
    }
    
    func tab5ChangeMethod(notif: NSNotification) {
        print("5 Notification : Section Changed")
        self.viewController.performSegueWithIdentifier("exitToMainPage5Segue", sender: nil)
    }
    
    func deinitNotification() {
        NSNotificationCenter.defaultCenter().removeObserver(self)
        
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
