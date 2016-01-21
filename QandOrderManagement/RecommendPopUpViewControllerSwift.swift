//
//  PopUpViewControllerSwift.swift
//  NMPopUpView
//
//  Created by Nikos Maounis on 13/9/14.
//  Copyright (c) 2014 Nikos Maounis. All rights reserved.
//

import UIKit
import QuartzCore

protocol backToCurrentQProtocol{
    func closePopup()
    func selectedBr1()
    func selectedBr2()
    func selectedBr3()
    
}

public class RecommendPopUpViewControllerSwift : UIViewController {
    
    @IBOutlet weak var vContainer: UIView!
    @IBOutlet weak var vMain: UIView!
    
    var recommendArray : [String] = ["Siam Center", "MBK Center"]
    let customFont = UIFont(name: "ravenna-serial-light-regular", size: 15.0)
    
    var selectedRestaurant : String = ""
    var selectedBranch : RestaurantModel = RestaurantModel()
    var nav : UINavigationController!
    var delegate:backToCurrentQProtocol!
    
    let navigationFont = UIFont(name: "ravenna-serial-light-regular", size: 20.0)
    
    
    required public init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override public init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        //self.view.frame = CGRectMake(0, 0,  self.view.frame.width , self.view.frame.height)
       // self.vContainer.frame = CGRectMake(0, 0,  self.view.frame.width , self.view.frame.height)

        self.view.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.6)
        self.vMain.layer.cornerRadius = 5
        self.vMain.layer.shadowOpacity = 0.8
        self.vMain.layer.shadowOffset = CGSizeMake(0.0, 0.0)
       
    }
    
    public func showInView(aView: UIView!, withImage image : UIImage!, withMessage message: String!, animated: Bool)
    {
        aView.addSubview(self.view)
        if animated
        {
            self.showAnimate()
        }
    }
    
    func showAnimate()
    {
        
        self.vMain.alpha = 0.0;
        self.vContainer.alpha = 0.0;
        //self.vMain.frame = CGRectMake(0, -200, 1024, 200)
        UIView.animateWithDuration(0.5, animations: {
            self.vMain.alpha = 1.0
            self.vMain.center.y = 500
            self.vContainer.alpha = 0.5
            self.vContainer.center.y = 1000
        });

        
        
        
        self.view.transform = CGAffineTransformMakeScale(1.3, 1.3)
        self.view.alpha = 0.0;
        UIView.animateWithDuration(0.25, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransformMakeScale(1.0, 1.0)
        });
    }
    
    func removeAnimate()
    {
        UIView.animateWithDuration(0.25, animations: {
            self.view.transform = CGAffineTransformMakeScale(1.3, 1.3)
            self.view.alpha = 0.0;
            }, completion:{(finished : Bool)  in
                if (finished)
                {
                    self.view.removeFromSuperview()
                }
        });
    }
    
    @IBAction public func closePopup(sender: AnyObject) {
        self.removeAnimate()
        delegate?.closePopup()

    }
    
    @IBAction public func selectedBr1(sender: AnyObject){
        self.removeAnimate()
        delegate?.selectedBr1()
    }
    
    @IBAction public func selectedBr2(sender: AnyObject){
        self.removeAnimate()
        delegate?.selectedBr2()
    }
    
    @IBAction public func selectedBr3(sender: AnyObject){
        self.removeAnimate()
        delegate?.selectedBr3()
    }
    
}
