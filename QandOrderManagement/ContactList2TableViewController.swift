//
//  ContactList2TableViewController.swift
//  QandOrderManagement
//
//  Created by Pannray Samanphanchai on 11/16/2558 BE.
//  Copyright © 2558 Pannray Samanphanchai. All rights reserved.
//


import UIKit

protocol contact2Delegate{
    func backToConfirmPage(contactList:[String])
}

class ContactLis2tTableViewController: UITableViewController {
    
    var contactList : [String] = ["Albert C.", "Arnold C", "Barry P.", "Catherine E.", "Harry R.", "Jonathan Y.", "John A.", "Lucy D.", "Michael R.", "Monica A.", "Patty S.", "Patricia O.", "Paul T.", "Peter P.", "Smith M.", "Steve R."]
    
    let navigationFont = UIFont(name: "ravenna-serial-light-regular", size: 20.0)
    let customFont = UIFont(name: "ravenna-serial-light-regular", size: 15.0)
    var lastSelectedIndexPath = NSIndexPath(forRow: -1, inSection: 0)
    var selectedRow : [String] = []
    var delegate:contact2Delegate?
    var common:CommonController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.rowHeight = 32
        self.tableView.allowsMultipleSelection = true
        
        //Setup Navigation
        self.navigationItem.title = "Contacts"
        
        var doneItem = UIBarButtonItem(title: "Done", style: .Plain, target: self, action: "back")
        
        if let font = customFont {
            doneItem.setTitleTextAttributes([NSFontAttributeName: font], forState: UIControlState.Normal)}
        doneItem.tintColor = UIColor.whiteColor()
        self.navigationItem.rightBarButtonItem = doneItem
        self.navigationItem.hidesBackButton = true
        
    }
    override func viewWillAppear(animated: Bool) {
        // Initial Notification for back to the first page
        common = CommonController()
        common.initializeTab1(self)
        common.initializeTab2(self)
        common.initializeTab3(self)
    }
    override func viewDidDisappear(animated: Bool) {
        common.deinitNotification()
    }
    
    func back(){
        delegate?.backToConfirmPage(self.selectedRow)
        self.navigationController?.popViewControllerAnimated(true)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return contactList.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        
        cell.textLabel!.text = self.contactList[indexPath.row]
        cell.textLabel?.font = customFont
        
        if(self.selectedRow.contains(self.contactList[indexPath.row])){
            //Contain
            print("Contain : \(self.contactList[indexPath.row])\n")
            cell.accessoryType = UITableViewCellAccessoryType.Checkmark
            
        }
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        cell!.accessoryType = UITableViewCellAccessoryType.None
        
        self.selectedRow.removeAtIndex(self.selectedRow.indexOf((cell?.textLabel?.text)!)!)
        
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        cell!.accessoryType = UITableViewCellAccessoryType.Checkmark
        
        let uiView = UIView()
        uiView.backgroundColor = UIColor(red: 163/255, green: 208/255, blue: 234/255, alpha: 0.3)
        cell?.selectedBackgroundView = uiView
        
        if(self.selectedRow.count == 0){
            self.selectedRow = [cell!.textLabel!.text!]
        }else{
            if(self.selectedRow.contains((cell?.textLabel?.text!)!)){
                
            }else{
                self.selectedRow.append((cell?.textLabel?.text!)!)
            }
            
        }
        
    }
    
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
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
    }
    
    
}

