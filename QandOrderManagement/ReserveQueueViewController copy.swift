//
//  ReserveQueueViewController.swift
//  QandOrderManagement
//
//  Created by Pannray Samanphanchai on 11/11/2558 BE.
//  Copyright © 2558 Pannray Samanphanchai. All rights reserved.
//

import UIKit

class ReserveQueueViewController: UIViewController, KWStepperDelegate, contactDelegate {
    
    @IBOutlet weak var restaurantImage : UIImageView!
    @IBOutlet weak var branchName : UILabel!
    @IBOutlet weak var branchLocation : UILabel!
    @IBOutlet weak var branchServiceTimeContact : UILabel!
    
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var decrementButton: UIButton!
    @IBOutlet weak var incrementButton: UIButton!
    
    @IBOutlet weak var babyCarriage : UISwitch!
    @IBOutlet weak var wheelchair : UISwitch!
    @IBOutlet weak var specialRequest : UITextView!
    @IBOutlet weak var friendList : UITextView!
    
    var newqueue : Bool = true
    var queueModel : QueueModel = QueueModel()
    
    var stepper: KWStepper?
    var selectedRestaurant : String = ""
    var selectedBranch : RestaurantModel = RestaurantModel()
    var friendArray : [String] = []
    
    let navigationFont = UIFont(name: "ravenna-serial-light-regular", size: 20.0)
    let customFont = UIFont(name: "ravenna-serial-light-regular", size: 15.0)
    let subTitleFont = UIFont(name: "ravenna-serial-light-regular", size: 13.0)
    
    var firstAllowContact : Bool = true
    var tempQueueModel : QueueModel = QueueModel()
    var originY : CGFloat = 0.0
    
    var continueItem = UIBarButtonItem()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if(newqueue){
            
            continueItem = UIBarButtonItem(title: "Continue", style: .Plain, target: self, action: "continueBtnTapped")
            
            //Create New Queue
            self.branchName.text = selectedBranch.res_branch_name
            self.branchLocation.text = selectedBranch.res_address
            self.branchServiceTimeContact!.text = "Open 10:00 - 21:30 "+"Tel. "+self.selectedBranch.res_contact
            
            self.babyCarriage.transform =  CGAffineTransformMakeScale(0.70, 0.70)
            self.wheelchair.transform = CGAffineTransformMakeScale(0.70, 0.70)
            self.babyCarriage.on = false
            self.wheelchair.on = false
            
            self.specialRequest.font = subTitleFont
            configureStepper(1)
            
        }else{
            
            continueItem = UIBarButtonItem(title: "Confirm", style: .Plain, target: self, action: "confirmBtnTapped")
            
            //Tapped Temp Q from MyQ Page
            //Get Information from QueueModel
            var resImage : UIImage!
            if(self.tempQueueModel.restaurant == "Sizzler"){
                resImage = UIImage(named: "Sizzler_Logo_3.png")
            }else if(self.tempQueueModel.restaurant == "The Pizza Company"){
                resImage = UIImage(named: "pizza_logo.png")
            }else if(self.tempQueueModel.restaurant == "Swensen"){
                resImage = UIImage(named: "SW_LOGO2.jpg")
            }
            
            self.restaurantImage.image = resImage
            
            self.branchName.text = self.tempQueueModel.branchModel.res_branch_name
            self.branchLocation.text = self.tempQueueModel.branchModel.res_address
            self.branchServiceTimeContact!.text = "Open 10:00 - 21:30 "+"Tel. "+self.tempQueueModel.branchModel.res_contact
            
            self.countLabel.text = self.tempQueueModel.noOfPerson
            self.babyCarriage.transform =  CGAffineTransformMakeScale(0.70, 0.70)
            self.wheelchair.transform = CGAffineTransformMakeScale(0.70, 0.70)
            self.babyCarriage.on = self.tempQueueModel.babyFlag
            self.wheelchair.on = self.tempQueueModel.wheelchairFlag
            self.specialRequest.text = self.tempQueueModel.specialRequest
            self.friendArray = self.tempQueueModel.friendList
            self.specialRequest.font = customFont
            
            var friendString = ""
            for i in 0..<self.tempQueueModel.friendList.count {
                friendString = friendString + self.tempQueueModel.friendList[i] + "\r\n"
            }
        
            self.friendList.text = friendString
            self.specialRequest.font = subTitleFont
            self.friendList.font = subTitleFont
            configureStepper(Int(self.tempQueueModel.noOfPerson)!)
        }
        
        //Setup Nav
        self.navigationItem.title = self.selectedRestaurant
        self.navigationController?.navigationBar.barTintColor = UIColor(red: (41/255.0), green: (108/255.0), blue: (163/255.0), alpha: 1.0)
        
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: navigationFont!, NSForegroundColorAttributeName: UIColor.whiteColor()]
        
        
        if let font = customFont {
            continueItem.setTitleTextAttributes([NSFontAttributeName: font], forState: UIControlState.Normal)}
        continueItem.tintColor = UIColor.whiteColor()
        self.navigationItem.rightBarButtonItem = continueItem
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name:UIKeyboardWillShowNotification, object: nil);
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name:UIKeyboardWillHideNotification, object: nil);
        
        
        
        // Do any additional setup after loading the view.
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func keyboardWillShow(sender: NSNotification) {
        
        if(self.view.frame.origin.y == 0){
            self.view.frame.origin.y -= 180
        }
        
    }
    
    func keyboardWillHide(sender: NSNotification) {
        if(self.view.frame.origin.y != 0.0){
            self.view.frame.origin.y = 0.0
        }
        
    }
    
    func confirmBtnTapped(){
        print("ConfirmBtnTapped")
        
        //Remove TempQueue from List and Append to Active Queue
        for i in 0..<MyVariables.tempQueueList.count {
            var temp = MyVariables.tempQueueList[i]
            if(tempQueueModel.queueNo == temp.queueNo){
                //get index
                MyVariables.tempQueueList.removeAtIndex(i)
                
                tempQueueModel.babyFlag = self.babyCarriage.on
                tempQueueModel.wheelchairFlag = self.wheelchair.on
                tempQueueModel.noOfPerson = self.countLabel.text!
                tempQueueModel.specialRequest = self.specialRequest.text
                tempQueueModel.status = "Active"
                tempQueueModel.friendList = self.friendArray
                tempQueueModel.queueNo = "A017"
                tempQueueModel.confirmCode = self.randomInt(100000, max: 999999)
                MyVariables.activeQueueList.append(tempQueueModel)
                
            }
            
        }
        self.performSegueWithIdentifier("confirmBtnTapped", sender: self)
        
    }
    
    func continueBtnTapped(){
        self.performSegueWithIdentifier("continueBtnTapped", sender: self)
    }
    
    func configureStepper(starter: Int) {
        self.stepper = KWStepper(
            decrementButton: self.decrementButton,
            incrementButton: self.incrementButton)
        
        if let stepper = self.stepper {
            stepper.addTarget(self,
                action: Selector("stepperDidChange"),
                forControlEvents: .ValueChanged)
            
            stepper.autoRepeat = true
            stepper.autoRepeatInterval = 0.10
            stepper.wraps = true
            stepper.minimumValue = 1
            stepper.maximumValue = 30
            stepper.value = Double(starter)
            stepper.incrementStepValue = 1
            stepper.decrementStepValue = 1
            
            stepper.delegate = self
        }
    }
    
    func stepperDidChange() {
        self.countLabel.text = NSString(format: "%.f", self.stepper!.value) as String
    }
    
    func stepperDidClampValue() {
        let stepper = self.stepper!
        let minValue = NSString(format: "%.f", stepper.minimumValue)
        let maxValue = NSString(format: "%.f", stepper.maximumValue)
        
        UIAlertView(
            title: "Stepper Limit Reached",
            message: "The step value was clamped, as it must be between \(minValue) and \(maxValue).",
            delegate: self,
            cancelButtonTitle: "OK"
            ).show()
    }
    
    // MARK: KWStepperDelegate Methods
    
    func KWStepperDidDecrement() {
        print("The stepper did decrement")
    }
    
    func KWStepperDidIncrement() {
        print("The stepper did increment")
    }
    
    func KWStepperMaxValueClamped() {
        print("Max value clamped")
        stepperDidClampValue()
    }
    
    func KWStepperMinValueClamped() {
        print("Min value clamped")
        stepperDidClampValue()
    }
    
    
    @IBAction func displayAlert(){
        print("before alert : \(self.view.frame.origin.y)")
        if(self.view.frame.origin.y != 0.0){
            print("set to 0.0")
            self.view.frame.origin.y = 0.0
        }
        
        if(self.firstAllowContact){
            let alertController = UIAlertController(title: "", message: "Application would like to access your contacts?", preferredStyle: .Alert)
            
            
            let dontAllowAction = UIAlertAction(title: "Don't Allow", style: .Default, handler: nil)
            let allowAction = UIAlertAction(title: "OK", style: .Default) { action -> Void in
                self.performSegueWithIdentifier("addfriend", sender: self)
            }
            
            
            alertController.addAction(dontAllowAction)
            alertController.addAction(allowAction)
            
            presentViewController(alertController, animated: true, completion: nil)
            self.firstAllowContact = false
            
        }else{
            self.performSegueWithIdentifier("addfriend", sender: self)
        }
        
        
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if(segue.identifier == "addfriend"){
            let controller = segue.destinationViewController as! ContactListTableViewController
            controller.selectedRow = self.friendArray
            controller.delegate = self
        }else if(segue.identifier == "continueBtnTapped"){
            
            self.queueModel.queueNo = "A012"
            self.queueModel.noOfPerson = self.countLabel!.text!
            if(self.babyCarriage.on){
                //True
                self.queueModel.babyFlag = true
            }else{
                //False
                self.queueModel.babyFlag = false
            }
            
            if(self.wheelchair.on){
                //True
                self.queueModel.wheelchairFlag = true
            }else{
                //False
                self.queueModel.wheelchairFlag = false
            }
            
            if(self.specialRequest.text.isEmpty){
                print("1")
                self.queueModel.specialRequest = "-"
                
            }else{
                print("2")
                self.queueModel.specialRequest = self.specialRequest.text
                
            }
            
            if(self.friendList.text.isEmpty){
                self.queueModel.friendList = []
            }else{
                self.queueModel.friendList = self.friendArray
                
            }
            self.queueModel.status = "Active"
            self.queueModel.restaurant = "Sizzler"
            self.queueModel.branchModel = self.selectedBranch
            MyVariables.activeQueueList.append(self.queueModel)
            
            self.queueModel.confirmCode = self.randomInt(100000, max: 999999)
            let confirmQueueController = segue.destinationViewController as! ConfirmQueueViewController
            confirmQueueController.selectedBranch = self.selectedBranch
            confirmQueueController.queueModel = self.queueModel
            confirmQueueController.selectedRestaurant = self.selectedRestaurant
            
            
        }else if(segue.identifier == "confirmBtnTapped"){
            let confirmQueueController = segue.destinationViewController as! ConfirmQueueViewController
            confirmQueueController.selectedBranch = self.tempQueueModel.branchModel
            confirmQueueController.queueModel = self.tempQueueModel
            confirmQueueController.selectedRestaurant = self.tempQueueModel.restaurant
            
        }
        
    }
    
    func randomInt(min: Int, max:Int) -> Int {
        return min + Int(arc4random_uniform(UInt32(max - min + 1)))
    }
    
    
    func backToReservePage(contactList:[String]){
        print("2")
        self.friendArray = contactList
        var friend : String = ""
        for i in 0..<contactList.count {
            friend = friend + contactList[i] + "\r\n"
        }
        self.friendList.font = subTitleFont
        self.friendList.text = friend
        
    }
    
    
}
