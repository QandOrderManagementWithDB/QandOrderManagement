//
//  MenuLevel2DrinkTableViewController.swift
//  Queue
//
//  Created by Kewalin Sakawattananon on 11/14/2558 BE.
//  Copyright © 2558 IBM. All rights reserved.
//

import UIKit

class MenuLevel2DrinkViewController:UIViewController, UITableViewDataSource, UITableViewDelegate, menuLevel2DrinkDelegate {
    @IBOutlet weak var tableView:UIExpandableTableView!
    @IBOutlet weak var btnCart:UIButton!
    var lblCartCount:UILabel!
    var menuList : [MenuModel] = []
    var menuListBySection : [[MenuModel]?] = []
    var sectionList : [String] = []
    var isFavorite = false
    var common:CommonController!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureCart()
        if isFavorite {
            self.title = "Favorite"
            self.tableView.sectionOpen.append(0)
            menuListBySection.append(menuList)
        }else{
            
            var i = 0
            for sectionName in sectionList {
                self.tableView.sectionOpen.append(i)
                let menuListBySectionTemp = menuList.filter({$0.menu_sec_name == sectionName })
                menuListBySection.append(menuListBySectionTemp)
                i++
            }
        }
        tableView.menuListBySection = menuListBySection
        

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
    override func viewDidAppear(animated: Bool) {
        lblCartCount.text = "\(MyVariables.countCart)"
    }
    func configureCart(){
        var amount = 0
        for order in MyVariables.orderList {
            amount += order.orderQuantity
        }
        let cartCountView:UIView = UIView(frame: CGRectMake(0, 0, 18, 18))
        let circleView:UIView = UIView(frame: CGRectMake(25,  4, 18, 18))
        circleView.layer.cornerRadius = circleView.frame.size.width/2
        circleView.clipsToBounds = true
        circleView.backgroundColor = UIColor(red: 121/255.0, green: 183/255.0, blue: 224/255.0, alpha: 1.0)
        cartCountView.addSubview(circleView)
        lblCartCount = UILabel(frame: CGRectMake(0, 0, 18, 18))
        lblCartCount.text = "\(amount)"
        lblCartCount.font = UIFont.boldSystemFontOfSize(12)
        lblCartCount.textColor = UIColor.whiteColor()
        lblCartCount.textAlignment = .Center
        circleView.addSubview(lblCartCount)
        btnCart.addSubview(circleView)
    }
    
    // MARK: UITableViewDataSource
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.min
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 75
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return sectionList.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if (!menuListBySection.isEmpty) {
            let count = self.tableView.sectionOpen.filter({$0 == section}).count
            if count > 0 {
                return menuListBySection[section]!.count
            }
            
        }
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("menuListCell", forIndexPath: indexPath) as! MenuLevel2DrinkTableViewCell
        let menuList = menuListBySection[indexPath.section]!
        let menu = menuList[indexPath.row]
        cell.delegate = self
        cell.menu = menu
        cell.txtMenuName.text = menu.menu_name
        cell.txtMenuName.font =  UIFont(name: "ravenna-serial-light-regular", size: 15)
        cell.lblMenuPrice.text = NSDecimalNumber(double: menu.menu_price).currency
        if menu.menu_favorite_flag == "Y" {
            cell.btnFavorite.setImage(UIImage(named: "star_check"), forState: UIControlState.Normal)
            cell.btnFavorite.tag = 1
        }else{
            cell.btnFavorite.setImage(UIImage(named: "star_uncheck"), forState: UIControlState.Normal)
            cell.btnFavorite.tag = 0
        }
        return cell
    }
    
    // MARK: UITableViewDelegate
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        print("View Header in section")
        let headerView = HeaderView(tableView: self.tableView, section: section)
        headerView.backgroundColor = UIColor(red: 121/255.0, green: 183/255.0, blue: 224/255.0, alpha: 1.0)
        let label = UILabel(frame: headerView.frame)
        label.text = sectionList[section]
        label.textAlignment = NSTextAlignment.Center
        label.font = UIFont(name: "ravenna-serial-medium-regular", size: 15)
        label.textColor = UIColor.whiteColor()//(red: 41.0/255.0, green: 108/255.0, blue: 163/255.0, alpha: 1.0)
        headerView.addSubview(label)
        return headerView
    }
    @IBAction func triggerFavorite(sender: AnyObject) {
        let btn = sender as! UIButton
        if btn.tag == 1 {
            btn.setImage(UIImage(named: "star_uncheck"), forState: UIControlState.Normal)
            btn.tag = 0
        }else{
            btn.setImage(UIImage(named: "star_check"), forState: UIControlState.Normal)
            btn.tag = 1
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    func addToCart(sender: AnyObject?, menu:MenuModel?) {
        let quantity = 1
        let btnAdd = sender as! UIButton
        let addFrame:CGRect = btnAdd.convertRect(btnAdd.bounds, toView: nil)
        
        let endPoint = btnCart.center
        
        let cartCountView:UIView = UIView(frame: CGRectMake(0, 0, 25, 25))
        let circleView:UIView = UIView(frame: CGRectMake(0,  0, 25, 25))
        circleView.layer.cornerRadius = circleView.frame.size.width/2
        circleView.clipsToBounds = true
        circleView.backgroundColor = UIColor(red: 121/255.0, green: 183/255.0, blue: 224/255.0, alpha: 1.0)
        cartCountView.addSubview(circleView)
        let lblCartCount:UILabel = UILabel(frame: CGRectMake(0, 0, 25, 25))
        lblCartCount.text = String(quantity)
        lblCartCount.font = UIFont.boldSystemFontOfSize(12)
        lblCartCount.textColor = UIColor.whiteColor()
        lblCartCount.textAlignment = .Center
        circleView.addSubview(lblCartCount)
        let cur:UIWindow? = UIApplication.sharedApplication().keyWindow
        cur?.addSubview(cartCountView)
        
        let pathAnimation:CAKeyframeAnimation = CAKeyframeAnimation(keyPath: "position");
        pathAnimation.calculationMode = kCAAnimationPaced;
        pathAnimation.fillMode = kCAFillModeForwards;
        pathAnimation.removedOnCompletion = false;
        pathAnimation.duration=1;
        pathAnimation.delegate=self;
        
        let path = UIBezierPath()
        path.moveToPoint(CGPointMake(addFrame.origin.x, addFrame.origin.y))
        path.addQuadCurveToPoint(CGPoint(x: endPoint.x+14, y: endPoint.y + btnAdd.frame.height/2 + 2), controlPoint: CGPoint(x:20, y:5))
        pathAnimation.path = path.CGPath
        
        // apply transform animation
        let animation:CABasicAnimation = CABasicAnimation(keyPath: "transform")
        let transform : CATransform3D = CATransform3DMakeScale(0.25, 0.25, 0.25 ) //0.25, 0.25, 0.25);
        
        animation.setValue(NSValue(CATransform3D: transform), forKey: "transform")
        animation.duration = 1.5
        
        cartCountView.layer.addAnimation(pathAnimation, forKey: "curveAnimation")
        cartCountView.layer.addAnimation(animation, forKey: "transform")
        
        MyVariables.countCart = MyVariables.countCart + quantity
        
        
        UIView.animateWithDuration(2, animations: {
            cartCountView.alpha = 0
            cartCountView.transform = CGAffineTransformMakeScale(0.7, 0.7)
            //self.setupNav.addAmountInCart(Int(self.amount.text!)!)
            }, completion: {
                finished in
                cartCountView.removeFromSuperview()
                self.lblCartCount.text = "\(MyVariables.countCart)"
                
        })
        
        let order = Order(orderMenuName: (menu?.menu_name)!, orderMenuSideDisk:"", orderQuantity:quantity, orderPrice: NSDecimalNumber(double: (menu?.menu_price)!))
        MyVariables.orderList.append(order)
        
        
    }
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "orderSegue" {
            
        }/*else if {
            let controller = segue.destinationViewController as! MenuDetailViewController
            let selectedPath = self.tableView.indexPathForSelectedRow!
            let menuList = menuListBySection[selectedPath.section]!
            controller.menu = menuList[selectedPath.row]
        }*/
        
    }
    
}
