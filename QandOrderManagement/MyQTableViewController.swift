//
//  MyQTableViewController.swift
//  QandOrderManagement
//
//  Created by Pannray Samanphanchai on 11/17/2558 BE.
//  Copyright © 2558 Pannray Samanphanchai. All rights reserved.
//

import UIKit

class MyQTableViewController: UITableViewController {
    
    let headerFont = UIFont(name: "ravenna-serial-medium-regular", size: 15.0)
    let customFont = UIFont(name: "ravenna-serial-light-regular", size: 15.0)
    let navigationFont = UIFont(name: "ravenna-serial-light-regular", size: 20.0)
    
    var activeQueue : [QueueModel] = []
    var tempQueue : [QueueModel] = []
    var refreshControl1:UIRefreshControl!
    
    var common : CommonController!
    
    override func viewDidLoad() {
        print("MyQTableViewController viewDidLoad")
        super.viewDidLoad()
        self.tableView.backgroundColor = UIColor.whiteColor()
        //Setup Navigation
        self.navigationItem.title = "My Queue"
        
//        let branchForActiveQueue1 = RestaurantModel()
//        branchForActiveQueue1.res_branch_name = "Central World"
//        branchForActiveQueue1.res_address = "3rd Floor, Beacon Zone, Central World"
//        branchForActiveQueue1.res_contact = "02-732-4999"
        
        let branchForActiveQueue2 = RestaurantModel()
        branchForActiveQueue2.res_branch_name = "Siam Center"
        branchForActiveQueue2.res_address = "4th Floor, Siam Center"
        branchForActiveQueue2.res_contact = "02-391-4040"
        
        let branchForTempQueue1 = RestaurantModel()
        branchForTempQueue1.res_branch_name = "Siam Square One"
        branchForTempQueue1.res_address = "5th Floor, Siam Square One"
        branchForTempQueue1.res_contact = "02-391-4040"
        
//        let activeQueue1 = QueueModel(queueNo: "A009", restaurant : "The Pizza Company", branchModel: branchForActiveQueue1, noOfPerson: "3" ,babyFlag: true, wheelchairFlag: true, specialRequest: "", friendList: [], confirmCode: 492013, status: "Active", waitingQueue: 3, waitingTime: 12)
        //        let queueActive2 = QueueModel(queueNo: "A34", restaurant : "Sizzler", branchModel: branchForActiveQueue2, noOfPerson: "4", babyFlag: true, wheelchairFlag: true, specialRequest: "Sofa Seat", friendList: ["Patty R.", "Robert E."], confirmCode: 492013, status: "Active")
        
        let activeQueue3 = QueueModel(queueNo: "B032", restaurant : "Swensen", branchModel: branchForActiveQueue2, noOfPerson: "6", babyFlag: true, wheelchairFlag: true, specialRequest: "Sofa Seat", friendList: ["Patty R.", "Robert E."], confirmCode: 592103, status: "Active", waitingQueue: 12, waitingTime: 24)
        
        let tempQueue1 = QueueModel(queueNo: "-", restaurant : "The Pizza Company", branchModel: branchForTempQueue1, noOfPerson: "7", babyFlag: true, wheelchairFlag: true, specialRequest: "Sofa Seat", friendList: ["Patty R.", "Robert E."], confirmCode: 889710, status: "Draft", waitingQueue: 0, waitingTime: 0)
        
//        MyVariables.activeQueueList.append(activeQueue1)
        //        MyVariables.activeQueueList.append(queueActive2)
        MyVariables.activeQueueList.append(activeQueue3)
        
        MyVariables.tempQueueList.append(tempQueue1)
        
        self.activeQueue = MyVariables.activeQueueList
        self.tempQueue = MyVariables.tempQueueList
        
        self.tableView.rowHeight = 70
        self.refreshControl1 = UIRefreshControl()
        self.refreshControl1.attributedTitle = NSAttributedString(string: "Pull to refresh")
        self.refreshControl1.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)
        self.tableView.addSubview(refreshControl1)

    }
    override func viewWillAppear(animated: Bool) {
        // Initial Notification for back to the first page
        common = CommonController()
        common.initializeTab3(self)
    }
    override func viewDidDisappear(animated: Bool) {
        common.deinitNotification()
    }
    @IBAction func exitFromMainPage3(segue:UIStoryboardSegue){
        print("Exit to main page")
    }
    func refresh(refresh:UIRefreshControl)
    {
        self.activeQueue = MyVariables.activeQueueList
        self.tempQueue = MyVariables.tempQueueList
        
        self.tableView.reloadData()
        /*
        self.activeQueue = MyVariables.activeQueueList
        self.tempQueue = MyVariables.tempQueueList*/
        print("refresh")
        self.refreshControl1.endRefreshing()
    }
    
    override func viewDidAppear(animated: Bool) {
        print("Active :Q \(MyVariables.activeQueueList.count)")
        self.activeQueue = MyVariables.activeQueueList
        self.tempQueue = MyVariables.tempQueueList
        self.tableView.reloadData()
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if(section == 0){
            return self.activeQueue.count
        }else{
            return self.tempQueue.count
        }
        
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if(section == 0){
            return "Active Queue"
        }else{
            return "Draft Queue"
        }
    }
    
    override func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        var headerLabel = ""
        if(section == 0){
            headerLabel = "Active Queue"
        }else{
            headerLabel = "Draft Queue"
        }
        
        let header:UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
        header.textLabel!.text = headerLabel
        header.textLabel!.font = headerFont
        header.textLabel!.textColor = UIColor.whiteColor()
        header.textLabel!.textAlignment = NSTextAlignment.Left
        var sectionImgView = UIImageView(image: UIImage(named: "section_background3.png"))
        header.backgroundView = sectionImgView
        
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! MyQTableViewCell
        
        if(indexPath.section == 0){
            //Active Q
            print("\(self.activeQueue[indexPath.row].queueNo)")
            if(self.activeQueue[indexPath.row].restaurant == "Sizzler"){
                cell.restuarnatImg.image = UIImage(named: "Sizzler_Logo_3.png")
                
            }else if(self.activeQueue[indexPath.row].restaurant == "The Pizza Company"){
                cell.restuarnatImg.image = UIImage(named: "pizza_logo.png")
                
            }else if(self.activeQueue[indexPath.row].restaurant == "Swensen"){
                cell.restuarnatImg.image = UIImage(named: "SW_LOGO2.jpg")
                
            }
            
            cell.queueNo!.text = self.activeQueue[indexPath.row].queueNo
            cell.branchName!.text = self.activeQueue[indexPath.row].branchModel.res_branch_name
            cell.noOfPerson!.text = self.activeQueue[indexPath.row].noOfPerson
            if(self.activeQueue[indexPath.row].babyFlag){
                print("Baby Flag On")
                cell.img1.image = UIImage(named: "baby.png")
                if(self.activeQueue[indexPath.row].wheelchairFlag){
                    var wheelchair = UIImage(named: "wheelchair.png")
                    cell.img2.image = wheelchair
                }
                
            }else{
                if(self.activeQueue[indexPath.row].wheelchairFlag){
                    print("Wheel Chair On")
                    var wheelchair = UIImage(named: "wheelchair.png")
                    cell.img1.image = wheelchair
                    cell.img2.image = UIImage(named: "blank.png")
                    
                }else{
                    cell.img1.image = UIImage(named: "blank.png")
                    cell.img2.image = UIImage(named: "blank.png")
                }
   
            }
        }else{
            
            //Temp Q
            if(self.tempQueue[indexPath.row].restaurant == "Sizzler"){
                cell.restuarnatImg.image = UIImage(named: "Sizzler_Logo_3.png")
                
            }else if(self.tempQueue[indexPath.row].restaurant == "The Pizza Company"){
                cell.restuarnatImg.image = UIImage(named: "pizza_logo.png")
                
            }else if(self.tempQueue[indexPath.row].restaurant == "Swensen"){
                cell.restuarnatImg.image = UIImage(named: "SW_LOGO2.jpg")
                
            }
            
            cell.queueNo!.text = self.tempQueue[indexPath.row].queueNo
            cell.branchName!.text = self.tempQueue[indexPath.row].branchModel.res_branch_name
            cell.noOfPerson!.text = self.tempQueue[indexPath.row].noOfPerson
            if(self.tempQueue[indexPath.row].babyFlag){
                cell.img1.image = UIImage(named: "baby.png")
                
            }
            
            if(self.tempQueue[indexPath.row].wheelchairFlag){
                var wheelchair = UIImage(named: "wheelchair.png")
                if(self.tempQueue[indexPath.row].babyFlag){
                    //img 2
                    cell.img2.image = wheelchair
                }else{
                    cell.img1.image = wheelchair
                }
                
            }else{
                print("Blank")
            }
            
        }
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if(indexPath.section == 0){
            self.performSegueWithIdentifier("viewactivequeue", sender: self)
        }else{
            self.performSegueWithIdentifier("viewtempqueue", sender: self)
        }
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return false if you do not want the specified item to be editable.
    return true
    }
    */
    
    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            
            let alertController = UIAlertController(title: "", message: "Are you sure you want to delete this queue?", preferredStyle: .Alert)
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
            let deleteAction = UIAlertAction(title: "Delete", style: .Default){ action -> Void in
                //remove from list
                if(indexPath.section == 0){
                    //remove from active
                    MyVariables.activeQueueList.removeAtIndex(indexPath.row)
                    //                    tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
                    self.activeQueue.removeAtIndex(indexPath.row)
                    self.tableView.reloadData()
                    
                }else{
                    //remove from temp
                    MyVariables.tempQueueList.removeAtIndex(indexPath.row)
                    self.tempQueue.removeAtIndex(indexPath.row)
                    self.tableView.reloadData()
                }
            }
            
            alertController.addAction(cancelAction)
            alertController.addAction(deleteAction)
            
            presentViewController(alertController, animated: true, completion: nil)
            
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    
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
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        print("[MyQTableViewController] Perform Segue")
        
        var indexPath = self.tableView.indexPathForSelectedRow
        
        if(indexPath?.section == 0){
            //Active Queue
            let controller = segue.destinationViewController as! ConfirmQueueViewController
            controller.selectedBranch = self.activeQueue[indexPath!.row].branchModel
            controller.queueModel = self.activeQueue[indexPath!.row]
            controller.selectedRestaurant = self.activeQueue[indexPath!.row].restaurant
            controller.hidebackitem = false
        }else{
            //Temp Queue
            let controller = segue.destinationViewController as! ReserveQueueViewController
            controller.newqueue = false
            controller.selectedRestaurant = self.tempQueue[indexPath!.row].restaurant
            controller.tempQueueModel = self.tempQueue[indexPath!.row]
            
            
            
        }
        
        
    }
    
    
}
