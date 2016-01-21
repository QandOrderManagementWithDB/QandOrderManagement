//
//  FeedbackViewController.swift
//  QandOrder
//
//  Created by Warunee Phattharakijwanich on 11/8/2558 BE.
//  Copyright © 2558 IBM. All rights reserved.
//

import UIKit

class FeedbackViewController: UIViewController {
    
    @IBOutlet weak var txtSuggestion: UITextView!
    @IBOutlet weak var ratingControl: RatingControl!
    @IBOutlet weak var ratingFood: RatingControl!
    @IBOutlet weak var ratingService: RatingControl!
    @IBOutlet weak var ratingAtmosphere: RatingControl!
    var common:CommonController!
    var originY : CGFloat = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        //Setup default rating
        self.ratingControl.rating = 4
        self.ratingFood.rating = 4
        self.ratingService.rating = 4
        self.ratingAtmosphere.rating = 4
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name:UIKeyboardWillShowNotification, object: nil);
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name:UIKeyboardWillHideNotification, object: nil);
    }
    override func viewWillAppear(animated: Bool) {
        // Initial Notification for back to the first page
        common = CommonController()
        common.initializeTab4(self)
    }
    override func viewDidDisappear(animated: Bool) {
        common.deinitNotification()
    }
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    func keyboardWillShow(sender: NSNotification) {
        originY = (167.0)*(-1)
        if(self.view.frame.origin.y >= originY){
            self.view.frame.origin.y -= 167.0
        }
        
    }
    
    func keyboardWillHide(sender: NSNotification) {
        originY = (167.0)*(-1)
        if(self.view.frame.origin.y < originY){
            self.view.frame.origin.y = 0.0
        }else{
            self.view.frame.origin.y += 167.0
            
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func submitFeedbackMethod(sender: AnyObject) {
        performSegueWithIdentifier("exitToMainPage4Segue", sender: nil)
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
