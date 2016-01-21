//
//  VoucherDetailViewController.swift
//  QandOrder
//
//  Created by Warunee Phattharakijwanich on 11/13/2558 BE.
//  Copyright © 2558 IBM. All rights reserved.
//

import UIKit

class VoucherDetailViewController: UIViewController {
    @IBOutlet weak var applyBtn: UIButton!
    @IBOutlet weak var imgQRcode: UIImageView!
    var common:CommonController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewWillAppear(animated: Bool) {
        // Initial Notification for back to the first page
        common = CommonController()
        common.initializeTab5(self)
    }
    override func viewDidDisappear(animated: Bool) {
        common.deinitNotification()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func applyVoucherMethod(sender: AnyObject) {
        let titlemsg = "Apply Coupon"
        let msg = "Confirm Apply this coupon"
        let a = UIAlertController(title: titlemsg, message: msg, preferredStyle: .Alert)
        a.addAction(UIAlertAction(title: "OK", style: .Default, handler: { action in
            print("Click of default button")
            self.imgQRcode.image = UIImage(named: "QR_Code_Apply.png")
            self.applyBtn.hidden = true
        }))
        
        a.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: { action in
            print("Click of cancel button")
        }))
        
        self.presentViewController(a, animated: true, completion: nil)
        
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
