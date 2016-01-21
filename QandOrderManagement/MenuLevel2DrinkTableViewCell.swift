//
//  MenuLevel2DrinkTableViewCell.swift
//  Queue
//
//  Created by Kewalin Sakawattananon on 11/14/2558 BE.
//  Copyright © 2558 IBM. All rights reserved.
//

import UIKit

protocol menuLevel2DrinkDelegate {
    func addToCart(sender:AnyObject?, menu:MenuModel?)
}

class MenuLevel2DrinkTableViewCell: UITableViewCell {
    @IBOutlet weak var txtMenuName : UITextView!
    @IBOutlet weak var lblMenuPrice : UILabel!
    @IBOutlet weak var btnFavorite : UIButton!
    @IBOutlet weak var btnAdd:UIButton!
    var delegate:menuLevel2DrinkDelegate?
    var menu:MenuModel?
    override func awakeFromNib() {
        super.awakeFromNib()
        btnAdd.layer.cornerRadius = 5
        btnAdd.layer.borderWidth = 1
        btnAdd.layer.borderColor = UIColor(red: 41.0/255.0, green: 108/255.0, blue: 163/255.0, alpha: 1.0).CGColor
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    @IBAction func addToCart(sender:AnyObject?){
        print("ADD TO CART")
        delegate?.addToCart(sender, menu: menu)
    }
    
}
