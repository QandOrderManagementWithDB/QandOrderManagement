//
//  PopOverDetailMapTableViewController.swift
//  ExpertTech
//
//  Created by Kewalin Sakawattananon on 8/14/2558 BE.
//  Copyright © 2558 IBM. All rights reserved.
//

import UIKit

protocol mapViewDetailDelegate{
    func tappedViewButton(res:RestaurantModel?)
}

class PopOverDetailMapViewController: UIViewController {
    
    @IBOutlet weak var btnView:UIButton!
    @IBOutlet weak var lblBranchName:UILabel!
    @IBOutlet weak var txtAddress:UITextView!
    var resId : String = ""
    var restaurant:RestaurantModel?
    var delegate:mapViewDetailDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnView.layer.cornerRadius = 5.0
        if let res_id = Int32(resId){
            restaurant = RestaurantController().getRestaurantById(res_id)
            lblBranchName.text = restaurant!.res_branch_name
            txtAddress.text = restaurant!.res_address
        }
        
    }
    
    override func viewDidAppear(animated: Bool) {
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onSelectedDetail(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
        delegate?.tappedViewButton(restaurant)
    }
    /*
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "viewFromMapSegue"{
            let navVC = segue.destinationViewController as! UINavigationController
            let currentQueueViewController = navVC.topViewController as! CurrentQueueViewController
            
            currentQueueViewController.selectedRestaurant = "Sizzler"
            currentQueueViewController.selectedBranch = restaurant!
        }
    }
       */
}
