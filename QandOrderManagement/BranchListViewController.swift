//
//  BranchListViewController.swift
//  QandOrderManagement
//
//  Created by Pannray Samanphanchai on 11/7/2558 BE.
//  Copyright © 2558 Pannray Samanphanchai. All rights reserved.
//

import UIKit

class BranchListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tbvBranch : UITableView!
    var selectedRestaurant : String = ""
    
    var selectedBranchIndex : NSIndexPath = NSIndexPath()
    var branchArray : [RestaurantModel] = []
    var branchFavouriteArray : [RestaurantModel] = []
    
    let headerFont = UIFont(name: "ravenna-serial-medium-regular", size: 15.0)
    let customFont = UIFont(name: "ravenna-serial-light-regular", size: 15.0)
    let navigationFont = UIFont(name: "ravenna-serial-light-regular", size: 20.0)
    
    var common : CommonController!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tbvBranch.rowHeight = 35.0
        self.title = "Sizzler"
        //Get BranchList
        self.branchArray = RestaurantController().getAllRestaurant()
        self.branchFavouriteArray.append(branchArray[4])
        self.branchFavouriteArray.append(branchArray[20])
        
    }
    override func viewWillAppear(animated: Bool) {
        // Initial Notification for back to the first page
        common = CommonController()
        common.initializeTab1(self)
    }
    override func viewDidDisappear(animated: Bool) {
        common.deinitNotification()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(section == 0){
            return branchFavouriteArray.count
        }else{
            return branchArray.count
        }
        
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if(section == 0){
            return "Favorite"
        }else{
            return "Nearby"
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCellWithIdentifier("cell1") as! BranchTableViewCell!
        
        if(indexPath.section == 0){
            cell.displayFavButton.setImage(UIImage(named: "star_check.png"), forState: UIControlState.Normal)
            cell.favButton.addTarget(self, action: "setFavourite:", forControlEvents: UIControlEvents.TouchUpInside)
            cell.branchLabel.text = branchFavouriteArray[indexPath.row].res_branch_name
            cell.branchLabel.font = customFont
            
        }else{
            
            cell.displayFavButton.setImage(UIImage(named: "star_uncheck.png"), forState: UIControlState.Normal)
            cell.favButton.addTarget(self, action: "setFavourite:", forControlEvents: UIControlEvents.TouchUpInside)
            cell.branchLabel.text = branchArray[indexPath.row].res_branch_name
            cell.branchLabel.font = customFont
            
        }
        
        return cell
    }
    
    func setFavourite(sender: AnyObject){
        var button = sender as! UIButton
        
        let clickedCell  = button.superview?.superview as! UITableViewCell
        let indexPath = self.tbvBranch.indexPathForCell(clickedCell) as NSIndexPath?
        
        if(indexPath!.section == 0){ //Set to unFavourite
            self.branchFavouriteArray.removeAtIndex(indexPath!.row)
            
        }else{  //Set to Favourite
            //Check Available
            let obj = self.branchArray[indexPath!.row]
            var dup : Bool = false
            for i in 0..<(self.branchFavouriteArray.count) {
                if(obj.res_branch_name == self.branchFavouriteArray[i].res_branch_name){
                    dup = true
                }
            }
            
            if(!dup){
                self.branchFavouriteArray.append(obj)
            }
            
        }
        
        self.tbvBranch.reloadData()
        
    }
    
    func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        var headerLabel = ""
        if(section == 0){
            headerLabel = "Favorite"
        }else{
            headerLabel = "Nearby"
        }
        
        let header:UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
        header.textLabel!.text = headerLabel
        header.textLabel!.font = headerFont
        header.textLabel!.textColor = UIColor.whiteColor()
        header.textLabel!.textAlignment = NSTextAlignment.Left
        var sectionImgView = UIImageView(image: UIImage(named: "section_background3.png"))
        header.backgroundView = sectionImgView
        
        //        header.backgroundView?.backgroundColor = UIColor(red: 121/255, green: 183/255, blue: 224/255, alpha: 1.0)
        
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if (segue.identifier == "selectedbranch") {
            print("Branch List PerformSegue")
            
            let indexPath = self.tbvBranch.indexPathForSelectedRow!
            let currentQueueViewController = segue.destinationViewController as! CurrentQueueViewController
            currentQueueViewController.selectedRestaurant = self.selectedRestaurant
            if(indexPath.section == 0){
                //Fav
                currentQueueViewController.selectedBranch = self.branchFavouriteArray[indexPath.row]
                
            }else{
                //Not Fav
                currentQueueViewController.selectedBranch = self.branchArray[indexPath.row]
            }
            
        }
    }
    
    
}
