//
//  HistoryDetailViewController.swift
//  QandOrder
//
//  Created by Warunee Phattharakijwanich on 11/12/2558 BE.
//  Copyright © 2558 IBM. All rights reserved.
//

import UIKit

class HistoryDetailViewController: UIViewController {
    let navigationFont = UIFont(name: "ravenna-serial-light-regular", size: 20.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //Setup Navigation
        self.navigationController?.navigationBar.barTintColor = UIColor(red: (41/255.0), green: (108/255.0), blue: (163/255.0), alpha: 1.0)
        self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: navigationFont!, NSForegroundColorAttributeName: UIColor.whiteColor()]
        //Setup Barbutton Item
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        let customFont = UIFont(name: "ravenna-serial-medium-regular", size: 13.0)
        UIBarButtonItem.appearance().setTitleTextAttributes([NSFontAttributeName: customFont!], forState: UIControlState.Normal)
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
