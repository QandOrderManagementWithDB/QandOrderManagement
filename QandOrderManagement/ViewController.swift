//
//  ViewController.swift
//  ScrollPager
//
//  Created by Aryan Ghassemi on 2/22/15.
//  Copyright (c) 2015 Aryan Ghassemi. All rights reserved.
//

import UIKit

class ViewController: UIViewController, ScrollPagerDelegate {
    
    //	@IBOutlet var scrollPager: ScrollPager!
    @IBOutlet var secondScrollPager: ScrollPager!
    
    @IBOutlet weak var homeView:UIView!
    @IBOutlet weak var qrView:UIView!
    @IBOutlet weak var myQView:UIView!
    @IBOutlet weak var billView:UIView!
    @IBOutlet weak var settingView:UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let firstView = UILabel()
        firstView.backgroundColor = UIColor.whiteColor()
        firstView.text = "first View"
        firstView.textAlignment = .Center
        
        let secondView = UILabel()
        secondView.backgroundColor = UIColor.whiteColor()
        secondView.text = "second view"
        secondView.textAlignment = .Center
        
        let thirdView = UILabel()
        thirdView.backgroundColor = UIColor.whiteColor()
        thirdView.text = "third view"
        thirdView.textAlignment = .Center
        
        let fourthView = UILabel()
        fourthView.backgroundColor = UIColor.whiteColor()
        fourthView.text = "fourth view"
        fourthView.textAlignment = .Center
        
        let fifthView = UILabel()
        fifthView.backgroundColor = UIColor.whiteColor()
        fifthView.text = "fourth view"
        fifthView.textAlignment = .Center
        
        secondScrollPager.delegate = self
        secondScrollPager.addSegmentsWithImagesAndViews([
            (UIImage(named: "exterior_gray")!, homeView),
            (UIImage(named: "qr_code_gray")!, qrView),
            (UIImage(named: "myspace_gray")!, myQView),
            (UIImage(named: "purchase_order_gray")!, billView),
            (UIImage(named: "settings_gray")!, settingView)
            ])
        
    }
    
    // MARK: - ScrollPagerDelegate -
    
    func scrollPager(scrollPager: ScrollPager, changedIndex: Int) {
        print("scrollPager index changed: \(changedIndex)")
        if changedIndex == 0 {
            NSNotificationCenter.defaultCenter().postNotificationName("tab1Change", object: nil, userInfo: nil)
        }else if changedIndex == 1 {
            NSNotificationCenter.defaultCenter().postNotificationName("tab2Change", object: nil, userInfo: nil)
        }else if changedIndex == 2 {
            NSNotificationCenter.defaultCenter().postNotificationName("tab3Change", object: nil, userInfo: nil)
        }else if changedIndex == 3 {
            NSNotificationCenter.defaultCenter().postNotificationName("tab4Change", object: nil, userInfo: nil)
        }else if changedIndex == 4 {
            NSNotificationCenter.defaultCenter().postNotificationName("tab5Change", object: nil, userInfo: nil)
        }
    }
    
}

