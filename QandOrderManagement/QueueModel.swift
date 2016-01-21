//
//  QueueModel.swift
//  QandOrderManagement
//
//  Created by Pannray Samanphanchai on 11/16/2558 BE.
//  Copyright © 2558 Pannray Samanphanchai. All rights reserved.
//

import Foundation

public class QueueModel {
    
    var queueNo : String = ""
    var restaurant : String = ""
    var branchModel : RestaurantModel = RestaurantModel()
    var noOfPerson : String = ""
    var babyFlag : Bool = false
    var wheelchairFlag : Bool = false
    var specialRequest : String = ""
    var friendList : [String] = [""]
    var confirmCode : Int = 0
    var status : String = ""
    var waitingQueue : Int = 0
    var waitingTime : Int = 0
    
    init(){}
    
    init(queueNo: String, restaurant : String, branchModel: RestaurantModel, noOfPerson: String, babyFlag: Bool, wheelchairFlag: Bool, specialRequest: String, friendList: [String], confirmCode: Int, status: String, waitingQueue: Int, waitingTime: Int){
        self.queueNo = queueNo
        self.restaurant = restaurant
        self.branchModel = branchModel
        self.noOfPerson = noOfPerson
        self.babyFlag = babyFlag
        self.wheelchairFlag = wheelchairFlag
        self.specialRequest = specialRequest
        self.friendList = friendList
        self.confirmCode = confirmCode
        self.status = status
        self.waitingQueue = waitingQueue
        self.waitingTime = waitingTime
        
    }
    
}
