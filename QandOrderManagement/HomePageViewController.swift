//
//  HomePageViewController.swift
//  QandOrderManagement
//
//  Created by Pannray Samanphanchai on 11/6/2558 BE.
//  Copyright © 2558 Pannray Samanphanchai. All rights reserved.
//

import UIKit

class HomePageViewController: UIViewController, UIScrollViewDelegate, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var scvPromotion : UIScrollView!
    @IBOutlet weak var pcPromotion : UIPageControl!
    @IBOutlet weak var tbvRestaurant: UITableView!
    @IBOutlet weak var headerSectionView: UIView!
    @IBOutlet weak var constraintTopOfPageControl: NSLayoutConstraint!
    
    var pointNow: CGPoint!
    var pageImages: [UIImage] = []
    var pageViews: [UIImageView?] = []
    var myTimer : NSTimer = NSTimer()
    var countTimer:Int = 0
    var selectedRestaurant : Int = 0
    
    var headerLabel = UILabel()
    var statusBarHeight = UIApplication.sharedApplication().statusBarFrame.height
    var imageHeaderSectionView = UIImageView(image: (UIImage(named: "section_background3.png")))
    
    var customFont = UIFont(name: "ravenna-serial-light-regular", size: 15.0)
    var sectionFont = UIFont(name: "ravenna-serial-medium-regular", size: 15.0)
    let headerFont = UIFont(name: "ravenna-serial-light-regular", size: 20.0)
    
    var promotionArray : [String] = ["SizzlerPromotion9.png", "PizzaPromotion.jpg", "SwensenPromotion.jpg"]
    var restaurantArray : [String] = ["Sizzler", "The Pizza Company", "Burger King"]
    var imageNames : [String] = ["res_sizzler.png", "res_pizzacompany1.png", "res_swensen.jpg"]
    
    var frameWidth : CGFloat = 0.0


    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Setup Navigation
        self.navigationItem.title = "SMART Q AND ORDER"
        
        //        setupTable()
        self.tbvRestaurant.delegate = self
        self.tbvRestaurant.separatorStyle = UITableViewCellSeparatorStyle.None
        
        //1
        self.frameWidth = self.view.frame.width
        let scrollViewWidth:CGFloat = self.view.frame.width
        let scrollViewHeight:CGFloat = self.view.frame.height*0.32
        
        //3
        let imgOne = UIImageView(frame: CGRectMake(0, 0,scrollViewWidth, scrollViewHeight))
        imgOne.image = UIImage(named: "SizzlerPromotion9.png")
        let imgTwo = UIImageView(frame: CGRectMake(scrollViewWidth, 0,scrollViewWidth, scrollViewHeight))
        imgTwo.image = UIImage(named: "Swensens_Mango.jpg")
        let imgThree = UIImageView(frame: CGRectMake(scrollViewWidth*2, 0,scrollViewWidth, scrollViewHeight))
        imgThree.image = UIImage(named: "PizzaPromotion.png")
        
        self.scvPromotion.addSubview(imgOne)
        self.scvPromotion.addSubview(imgTwo)
        self.scvPromotion.addSubview(imgThree)
        
        //4
        self.scvPromotion.contentSize = CGSizeMake(self.view.frame.width*3, self.view.frame.height*0.32)
        self.scvPromotion.delegate = self
        //self.pcPromotion.currentPage = 0
        self.configurePageControl()
        
        // Schedule a timer to auto slide to next page
        NSTimer.scheduledTimerWithTimeInterval(3, target: self, selector: "moveToNextPage", userInfo: nil, repeats: true)
        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        self.scvPromotion.frame = CGRect(x: 0, y: self.navigationController!.navigationBar.frame.height+self.statusBarHeight, width: self.view.frame.width, height: self.view.frame.height*0.32)
        
        self.headerSectionView.backgroundColor = UIColor.blueColor()
        self.headerSectionView.frame = CGRect(x: 0, y: self.scvPromotion.frame.height+self.navigationController!.navigationBar.frame.height+self.statusBarHeight, width: self.view.frame.width, height: 30)
        self.imageHeaderSectionView.frame = CGRectMake(0, 0, self.view.frame.width, 30)
        self.headerSectionView.addSubview(imageHeaderSectionView)
        self.headerLabel = UILabel(frame: CGRectMake(10, 0, self.frameWidth, 30))
        self.headerLabel.text = "Restaurant"
        self.headerLabel.font = self.sectionFont
        self.headerLabel.textColor = UIColor.whiteColor()
        
        self.headerSectionView.addSubview(headerLabel)
        
        self.tbvRestaurant.frame = CGRect(x: 0, y: self.scvPromotion.frame.height+self.navigationController!.navigationBar.frame.height+self.statusBarHeight+self.headerSectionView.frame.height, width: self.view.frame.width, height: 300)
        
        constraintTopOfPageControl.constant = scvPromotion.frame.height - (scvPromotion.frame.height / 6)
        
    }
    
    func moveToNextPage (){
        
        // Move to next page
        let pageWidth:CGFloat = CGRectGetWidth(self.scvPromotion.frame)
        let maxWidth:CGFloat = pageWidth * 3
        let contentOffset:CGFloat = self.scvPromotion.contentOffset.x
        
        var slideToX = contentOffset + pageWidth
        
        if  contentOffset + pageWidth == maxWidth{
            slideToX = 0
            // Each time you move back to the first slide, you may want to hide the button, uncomment the animation below to do so
            //            UIView.animateWithDuration(0.5, animations: { () -> Void in
            //                self.startButton.alpha = 0.0
            //            })
        }
        self.scvPromotion.scrollRectToVisible(CGRectMake(slideToX, 0, pageWidth, CGRectGetHeight(self.scvPromotion.frame)), animated: true)
    }
    
    
    //MARK: UIScrollViewDelegate
    func scrollViewDidEndScrollingAnimation(scrollView: UIScrollView){
        
        // Test the offset and calculate the current page after scrolling ends
        let pageWidth:CGFloat = CGRectGetWidth(scrollView.frame)
        let currentPage:CGFloat = floor((scrollView.contentOffset.x-pageWidth/2)/pageWidth)+1
        // Change the indicator
        self.pcPromotion.currentPage = Int(currentPage);
        
        let btnPromotion = UIButton()
        //btnPromotion.setImage(pageImages[page],forState: .Normal)
        btnPromotion.titleLabel!.text = String(currentPage)
        //        btnPromotion.backgroundColor = UIColor.blueColor()
        btnPromotion.titleLabel?.hidden = true
        btnPromotion.addTarget(self, action: "btnPromotionTapped:", forControlEvents: UIControlEvents.TouchUpInside)
        btnPromotion.frame = CGRectMake((self.scvPromotion.frame.width * CGFloat(currentPage)) , 0, self.scvPromotion.frame.width, self.scvPromotion.frame.height)
        //btnPromotion.frame = CGRectMake(0, 0, frame.width, frame.height)
        
        self.scvPromotion.addSubview(btnPromotion)
        
        
        
        // Change the text accordingly
        //        if Int(currentPage) == 0{
        //            textView.text = "Sweettutos.com is your blog of choice for Mobile tutorials"
        //        }else if Int(currentPage) == 1{
        //            textView.text = "I write mobile tutorials mainly targeting iOS"
        //        }else if Int(currentPage) == 2{
        //            textView.text = "And sometimes I write games tutorials about Unity"
        //        }else{
        //            textView.text = "Keep visiting sweettutos.com for new coming tutorials, and don't forget to subscribe to be notified by email :)"
        //            // Show the "Let's Start" button in the last slide (with a fade in animation)
        //            UIView.animateWithDuration(1.0, animations: { () -> Void in
        //                self.startButton.alpha = 1.0
        //            })
        //        }
    }
    
    
    func btnPromotionTapped(sender:UIButton!){
        /*
        let vc = Detail2ViewController(nibName: "Detail2ViewController", bundle: nil)
        vc.id = "aa"
        navigationController?.pushViewController(vc, animated: true)
        */
        performSegueWithIdentifier("promotionSegue", sender: nil)
        print("BTN PromotionTapped \(pcPromotion.currentPage)")
        
        //        let vc = self.storyboard?.instantiateViewControllerWithIdentifier("PromotionDetailViewController") as! PromotionDetailViewController
        //print("test = \(vc.id)")
        //        var test = promotionArray[pcPromotion.currentPage]
        //        print("SELECTED ID: \(test.prom_id)")
        //        vc.selectedPromotion = promotionArray[pcPromotion.currentPage]
        //        self.navigationController?.pushViewController(vc, animated: true)
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("cell1") as! UITableViewCell!
        
        var imageView = UIImageView(frame: CGRectMake(5, 5, self.frameWidth-10, self.tbvRestaurant.rowHeight-5))
        var image = UIImage(named: imageNames[indexPath.row])
        imageView.image = image
        
        //Just add imageView as subview of cell
        cell.addSubview(imageView)
        cell.sendSubviewToBack(imageView)
        
        return cell
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("SELECTED ROW : \(indexPath.row)")
        self.selectedRestaurant = indexPath.row
        self.performSegueWithIdentifier("selectedrestaurant", sender: nil)
        
    }
    
    @IBAction func exitFromMainPage1(segue:UIStoryboardSegue){
        print("Exit to main page")
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        print("1")
        if segue.identifier == "selectedrestaurant" {
            let branchListViewController = segue.destinationViewController as! BranchListViewController
            branchListViewController.selectedRestaurant = restaurantArray[selectedRestaurant]
            
        }
        
        //        if let indexPath = self.tbvRestaurant.indexPathForSelectedRow()?.row {
        //            print("2")
        //            let restName = restaurantArray[indexPath.row]
        //            print("3")
        //            let destination = segue.destinationViewController as! BranchListViewController
        //            print("4")
        //            destination.rest = restName
        //            
        //            
        //        }
        
    }
    func configurePageControl() {
        // The total number of pages that are available is based on how many available colors we have.
     //   self.pcPromotion = UIPageControl(frame: CGRectMake(50, 300, 200, 50))
        
        self.pcPromotion.numberOfPages = 3
        self.pcPromotion.currentPage = 0
      /*  self.pcPromotion.tintColor = UIColor.redColor()
        self.pcPromotion.pageIndicatorTintColor = UIColor.blackColor()
        self.pcPromotion.currentPageIndicatorTintColor = UIColor.greenColor()*/
        self.scvPromotion.addSubview(self.pcPromotion)
        self.scvPromotion.bringSubviewToFront(self.pcPromotion)
        
    }
    
}
