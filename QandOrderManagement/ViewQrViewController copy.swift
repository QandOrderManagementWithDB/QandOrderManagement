//
//  ViewQrViewController.swift
//  QandOrderManagement
//
//  Created by Pannray Samanphanchai on 11/17/2558 BE.
//  Copyright © 2558 Pannray Samanphanchai. All rights reserved.
//

import UIKit

class ViewQrViewController: UIViewController {
    
    @IBOutlet weak var restaurantImage : UIImage!
    @IBOutlet weak var branchName : UILabel!
    @IBOutlet weak var branchLocation : UILabel!
    @IBOutlet weak var branchServiceTimeContact : UILabel!
    
    var selectedBranch : RestaurantModel = RestaurantModel()
    var selectedRestaurant : String = ""
    
    let navigationFont = UIFont(name: "ravenna-serial-light-regular", size: 20.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Setup Navigation
        self.navigationItem.title = "Sizzler"
        self.navigationController?.navigationBar.barTintColor = UIColor(red: (41/255.0), green: (108/255.0), blue: (163/255.0), alpha: 1.0)
        self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: navigationFont!, NSForegroundColorAttributeName: UIColor.whiteColor()]
        // Do any additional setup after loading the view.
        
        self.branchName!.text = selectedBranch.res_branch_name
        self.branchLocation!.text = selectedBranch.res_address
        self.branchServiceTimeContact!.text = "Open 10:00 - 21:30 "+"Tel. "+self.selectedBranch.res_contact
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
