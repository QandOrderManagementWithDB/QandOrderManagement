//
//  RewardDetailTableViewController.swift
//  QandOrder
//
//  Created by Warunee Phattharakijwanich on 11/12/2558 BE.
//  Copyright © 2558 IBM. All rights reserved.
//

import UIKit

class RewardDetailTableViewController: UITableViewController {
    var common:CommonController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Initial Notification for back to the first page
    }
    
    @IBAction func redeemVoucherMethod(sender: AnyObject) {
        let titlemsg = "Confirm Redeemation"
        let msg = "Please confirm your redeemation."
        let a = UIAlertController(title: titlemsg, message: msg, preferredStyle: .Alert)
        a.addAction(UIAlertAction(title: "OK", style: .Default, handler: { action in
            print("Click of default button")
            let vc = self.storyboard?.instantiateViewControllerWithIdentifier("voucherTableViewController") as! VoucherTableViewController
            self.navigationController?.pushViewController(vc, animated: true)
            //self.presentViewController(vc, animated: true, completion: nil)
            
        }))
        
        a.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: { action in
            print("Click of cancel button")
        }))
        
        self.presentViewController(a, animated: true, completion: nil)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int)
    {
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.font = UIFont(name: "ravenna-serial-medium-regular", size: 15)!
        var sectionImgView = UIImageView(image: UIImage(named: "section_background3.png"))
        header.backgroundView = sectionImgView
        header.textLabel?.textColor = UIColor.whiteColor()
    }
    
    // MARK: - Table view data source
    /*
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    // #warning Incomplete implementation, return the number of sections
    return 0
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // #warning Incomplete implementation, return the number of rows
    return 0
    }
    */
    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)
    
    // Configure the cell...
    
    return cell
    }
    */
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return false if you do not want the specified item to be editable.
    return true
    }
    */
    
    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    if editingStyle == .Delete {
    // Delete the row from the data source
    tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
    } else if editingStyle == .Insert {
    // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
    }
    */
    
    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
    
    }
    */
    
    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return false if you do not want the item to be re-orderable.
    return true
    }
    */
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
