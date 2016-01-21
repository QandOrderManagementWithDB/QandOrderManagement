//
//  CurrentQueueViewController.swift
//  QandOrderManagement
//
//  Created by Pannray Samanphanchai on 11/8/2558 BE.
//  Copyright © 2558 Pannray Samanphanchai. All rights reserved.
//

import UIKit

class CurrentQueueViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, backToCurrentQProtocol {
    
    @IBOutlet weak var restaurantImage : UIImage!
    @IBOutlet weak var branchName : UILabel!
    @IBOutlet weak var branchLocation : UILabel!
    @IBOutlet weak var branchServiceTimeContact : UILabel!
    @IBOutlet weak var tbvCurrentQueue : UITableView!
    
    var selectedRestaurant : String = ""
    var selectedBranch : RestaurantModel = RestaurantModel()
    var tableTypeArray : [String] = ["1-4", "5-8", "9-12", "13-20"]
    var defaultWaitingQ : [Int] = [7,4,0,0]
    var recommendWaitingQ : [Int] = [18,6,1,0]
    var totalWaitingQ : Int = 0
    
    var popViewController : RecommendPopUpViewControllerSwift!
    
    let navigationFont = UIFont(name: "ravenna-serial-light-regular", size: 20.0)
    let customFont = UIFont(name: "ravenna-serial-light-regular", size: 15.0)
    
    var common : CommonController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Setup Nav
        self.navigationItem.title = self.selectedRestaurant
        
        let continueItem = UIBarButtonItem(title: "Continue", style: .Plain, target: self, action: "continueBtnTapped")
        
        if let font = customFont {
            continueItem.setTitleTextAttributes([NSFontAttributeName: font], forState: UIControlState.Normal)}
        continueItem.tintColor = UIColor.whiteColor()
        self.navigationItem.rightBarButtonItem = continueItem
        
        self.branchName!.text = self.selectedBranch.res_branch_name
        self.branchLocation!.text = self.selectedBranch.res_address
        self.branchServiceTimeContact!.text = "Open 10:00 - 21:30 "+"Tel. "+self.selectedBranch.res_contact
        
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
    
    func continueBtnTapped(){
        print("Total Queue : \(self.totalWaitingQ)")
        if(self.totalWaitingQ > MyVariables.minimumWaitingQAlert){
            //display recommend alert
            print("Alert Popup")
            self.showPopUp()
            
        }else{
            self.performSegueWithIdentifier("reserveQueue", sender: self)
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cell1") as! CurrentQueueTableViewCell!
        
        cell.tableType.text = self.tableTypeArray[indexPath.row]
        if(self.selectedBranch.res_branch_name.containsString("Central World Plaza")){
            //Assign RecommendWaitingQ
            cell.waitingQueue.text = String(self.recommendWaitingQ[indexPath.row])
            self.totalWaitingQ = self.totalWaitingQ + self.recommendWaitingQ[indexPath.row]
            
        }else{
            //Assign WaitingQ
            cell.waitingQueue.text = String(self.defaultWaitingQ[indexPath.row])
            self.totalWaitingQ = self.totalWaitingQ + self.defaultWaitingQ[indexPath.row]
            
        }
        return cell
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    func showPopUp() {
        print("show popup")
        
        let bundle = NSBundle(forClass: RecommendPopUpViewControllerSwift.self)
        self.popViewController = RecommendPopUpViewControllerSwift(nibName: "RecommendPopUpViewController", bundle: bundle)
        self.popViewController.selectedRestaurant = self.selectedRestaurant
        self.popViewController.selectedBranch = self.selectedBranch
        self.popViewController.nav = self.navigationController
        self.popViewController.delegate = self
        self.popViewController.title = "This is a popup view"
        
        self.popViewController.view.frame = CGRectMake(0, 0, self.view.frame.width, self.view.frame.height)
        self.popViewController.showInView(self.view, withImage: UIImage(named: "typpzDemo"), withMessage: "There are more than 20 waiting queue for \(self.selectedRestaurant). Could you prefre the other branch below?", animated: true)
        
    }
    
    func closePopup(){
        self.performSegueWithIdentifier("reserveQueue", sender: nil)
    }
    
    
    func selectedBr1() {
        self.selectedBranch = RestaurantController().getRestaurantById(10021)
        self.totalWaitingQ = 0
        self.viewDidLoad()
        self.tbvCurrentQueue.reloadData()
    }
    
    func selectedBr2() {
        self.selectedBranch = RestaurantController().getRestaurantById(10020)
        self.totalWaitingQ = 0
        self.viewDidLoad()
        self.tbvCurrentQueue.reloadData()
    }
    
    func selectedBr3() {
        self.selectedBranch = RestaurantController().getRestaurantById(10016)
        self.totalWaitingQ = 0
        self.viewDidLoad()
        self.tbvCurrentQueue.reloadData()
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        print("perform segue")
        if(segue.identifier == "reserveQueue"){
            print("reserveQueue")
            let reserveQueueViewController = segue.destinationViewController as! ReserveQueueViewController
            reserveQueueViewController.selectedBranch = self.selectedBranch
            reserveQueueViewController.selectedRestaurant = self.selectedRestaurant
        }
        
    }
    
}
