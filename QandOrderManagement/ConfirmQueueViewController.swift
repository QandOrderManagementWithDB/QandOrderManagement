//
//  ConfirmQueueViewController.swift
//  QandOrderManagement
//
//  Created by Pannray Samanphanchai on 11/15/2558 BE.
//  Copyright © 2558 Pannray Samanphanchai. All rights reserved.
//

import UIKit

class ConfirmQueueViewController: UIViewController, contact2Delegate {
    
    @IBOutlet weak var restaurantImage : UIImageView!
    @IBOutlet weak var branchName : UILabel!
    @IBOutlet weak var branchLocation : UILabel!
    @IBOutlet weak var branchServiceTimeContact : UILabel!
    
    @IBOutlet weak var queueNo : UILabel!
    @IBOutlet weak var confirmCode : UILabel!
    @IBOutlet weak var waitingQueue : UILabel!
    @IBOutlet weak var waitingTime : UILabel!
    
    @IBOutlet weak var bookingView : UIView!
    @IBOutlet weak var noOfPerson : UILabel!
    @IBOutlet weak var img1 : UIImageView!
    @IBOutlet weak var img2 : UIImageView!
    
    @IBOutlet weak var specialReq : UILabel!
    @IBOutlet weak var friendList : UITextView!
    @IBOutlet weak var scrollView : UIScrollView!
    
    @IBOutlet weak var viewBookingBtn : UIButton!
    
    @IBOutlet weak var constraintBookingBtn: NSLayoutConstraint!
    @IBOutlet weak var constraintHeightView: NSLayoutConstraint!
    
    var hidebackitem : Bool = true
    var friendArray : [String] = []
    var queueModel : QueueModel = QueueModel()
    var bookingViewVisible : Int = 0
    var selectedBranch : RestaurantModel = RestaurantModel()
    var selectedRestaurant : String = ""
    
    let navigationFont = UIFont(name: "ravenna-serial-light-regular", size: 20.0)
    let customFont = UIFont(name: "ravenna-serial-light-regular", size: 15.0)
    let subTitleFont = UIFont(name: "ravenna-serial-light-regular", size: 13.0)
    
    var common : CommonController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Setup Nav
        self.navigationItem.title = self.selectedRestaurant
        self.navigationItem.hidesBackButton = self.hidebackitem
        
        var resImage : UIImage!
        if(self.selectedRestaurant == "Sizzler"){
            resImage = UIImage(named: "Sizzler_Logo_3.png")
        }else if(self.selectedRestaurant == "The Pizza Company"){
            resImage = UIImage(named: "pizza_logo.png")
        }else if(self.selectedRestaurant == "Swensen"){
            resImage = UIImage(named: "SW_LOGO2.jpg")
        }
        
        self.restaurantImage.image = resImage
        
        self.branchName!.text = selectedBranch.res_branch_name
        self.branchLocation!.text = selectedBranch.res_address
        self.branchServiceTimeContact!.text = "Open 10:00 - 21:30 "+"Tel. "+self.selectedBranch.res_contact
        
        self.queueNo.text = self.queueModel.queueNo
        self.confirmCode.text = String(self.queueModel.confirmCode)
        self.waitingQueue.text = String(self.queueModel.waitingQueue)
        self.waitingTime.text = String(self.queueModel.waitingTime)
        
        self.noOfPerson.text = self.queueModel.noOfPerson
        if(self.queueModel.babyFlag.boolValue){
            //True --> Display Baby Img
            print("has baby")
            var baby = UIImage(named: "baby.png")
            self.img1.image = baby
            
        }
        
        
        if(self.queueModel.wheelchairFlag.boolValue){
            print("has wheelchair")
            //True --> Display Wheelchair Img
            var wheelchair = UIImage(named: "wheelchair.png")
            if(self.queueModel.babyFlag.boolValue){
                //img 2
                self.img2.image = wheelchair
            }else{
                self.img1.image = wheelchair
            }
            
        }else{
            print("Blank")
        }
        
        self.specialReq.text = self.queueModel.specialRequest
        var tmpFriend = ""
        if (self.queueModel.friendList.count > 0){
            for i in 0..<self.queueModel.friendList.count {
                tmpFriend = tmpFriend + self.queueModel.friendList[i] + ", "
            }
            self.friendList.text = tmpFriend
        }else{
            self.friendList.text = "-"
        }
        self.autoLayoutSubviews()

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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func autoLayoutSubviews() {
         constraintHeightView.constant = self.view.frame.height + 135
        constraintBookingBtn.constant = self.view.frame.height - 135
    }
    
    @IBAction func viewBookingInfo(){
        self.bookingViewVisible += 1
        if(self.bookingViewVisible % 2 == 1){
            //Show view
            self.viewBookingBtn.setTitle("Hide Booking Information", forState: UIControlState.Normal)
            
            var addFriendBtn = UIButton(type: UIButtonType.Custom)
            addFriendBtn.frame = CGRectMake(self.bookingView.frame.width - 40, 73, 17, 17)
            addFriendBtn.setImage(UIImage(named: "Plus-Fill"), forState: UIControlState.Normal)
            addFriendBtn.addTarget(self, action: "addFriendBtnTapped:", forControlEvents: UIControlEvents.TouchUpInside)
            self.bookingView.addSubview(addFriendBtn)
            self.scrollView.setContentOffset(CGPointMake(0, 50), animated: true)
            
        }else{
            //Hide view
            self.viewBookingBtn.setTitle("Show Booking Information", forState: UIControlState.Normal)
            self.scrollView.setContentOffset(CGPointMake(0, -64), animated: true)
            
        }
        
    }
    
    @IBAction func viewQr(){
        self.performSegueWithIdentifier("viewqrcode", sender: self)
    }
    
    func addFriendBtnTapped(sender: AnyObject){
        self.performSegueWithIdentifier("addfriend2", sender: self)
        
    }
    
    
    func backToConfirmPage(contactList:[String]){
        print("bact to main")
        self.friendArray = contactList
        var friend : String = ""
        for i in 0..<contactList.count {
            friend = friend + contactList[i] + ", "
        }
        self.friendList.font = subTitleFont
        self.friendList.text = friend
        
    }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if(segue.identifier == "addfriend2"){
            let controller = segue.destinationViewController as! ContactLis2tTableViewController
            controller.selectedRow = self.friendArray
            controller.delegate = self
        }else if(segue.identifier == "viewqrcode"){
            let controller = segue.destinationViewController as! ViewQrViewController
            controller.selectedRestaurant = self.selectedRestaurant
            controller.selectedBranch = self.selectedBranch
        }
        
        
    }
    
    
}
