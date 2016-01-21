//
//  OrderListViewController.swift
//  Queue
//
//  Created by Kewalin Sakawattananon on 11/14/2558 BE.
//  Copyright © 2558 IBM. All rights reserved.
//

import UIKit

class OrderListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, changeQuantityValueDelegate {
    let orderList = MyVariables.orderList
    @IBOutlet weak var orderListTableView:UITableView!
    @IBOutlet weak var lblTotalPrice: UILabel!
    @IBOutlet weak var btnCart:UIButton!
    var lblCartCount:UILabel!
    var common:CommonController!
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.orderListTableView.contentOffset = CGPointMake(0, 10)
        self.orderListTableView.backgroundColor = UIColor.whiteColor()
        self.configureCart()
        self.reCalculate()
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
    
    override func viewWillDisappear(animated: Bool) {
        var quantity = 0
        for order in MyVariables.orderList {
            quantity += order.orderQuantity
        }
        print("Quantity : \(quantity)")
        MyVariables.countCart = quantity
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MyVariables.orderList.count
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        print("cell for row")
        let cell = tableView.dequeueReusableCellWithIdentifier("orderCell", forIndexPath: indexPath) as! OrderTableViewCell
        cell.delegate = self
        cell.setCountValue(MyVariables.orderList[indexPath.row], index: indexPath.row)
        cell.txtMenuName.text  = MyVariables.orderList[indexPath.row].orderMenuName
        cell.txtMenuName.font =  UIFont(name: "ravenna-serial-light-regular", size: 15)
        //cell.lblMenuName.text = MyVariables.orderList[indexPath.row].orderMenuName
        cell.lblPrice.text = MyVariables.orderList[indexPath.row].orderPrice.decimalNumberByMultiplyingBy(NSDecimalNumber(integer: MyVariables.orderList[indexPath.row].orderQuantity)).currency
        cell.lblCount.text = "\(MyVariables.orderList[indexPath.row].orderQuantity)"
        return cell
    }
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            MyVariables.orderList.removeAtIndex(indexPath.row)
            
            tableView.beginUpdates()
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Top)
            tableView.endUpdates()
            self.reCalculate()
            
        }
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat.min
    }
    
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.min
    }
    
    
    func reCalculate(){
        print("recalculate")
        var grandTotal:NSDecimalNumber = 0
        var totalQuantity = 0
        
        for order in MyVariables.orderList {
            let quantity = NSDecimalNumber(integer: order.orderQuantity)
            totalQuantity += order.orderQuantity
            let totalPrice = quantity.decimalNumberByMultiplyingBy(order.orderPrice)
            grandTotal = grandTotal.decimalNumberByAdding(totalPrice)
        }
        MyVariables.countCart = totalQuantity
        self.lblTotalPrice.text = grandTotal.currency
        self.lblCartCount.text = "\(MyVariables.countCart)"
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
