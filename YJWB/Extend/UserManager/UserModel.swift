//
//  UserModel.swift
//  SwiftStu
//
//  Created by  ZhouYingJie on 16/3/21.
//  Copyright © 2016年 ZhouYingJie. All rights reserved.
//

import UIKit

//用户状态
enum UserState {
    case UnKnow
    case Login
    case UnLogin
}


class UserModel: NSObject,NSCoding{
    var access_token:String?
    var expires_in:String?
    var remind_in:String?
    var uid:String?
    var userState:UserState?
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.access_token = aDecoder.decodeObjectForKey("access_token") as? String
        self.expires_in = aDecoder.decodeObjectForKey("expires_in") as? String
        self.remind_in = aDecoder.decodeObjectForKey("remind_in") as? String
        self.uid = aDecoder.decodeObjectForKey("uid") as? String
        self.userState = aDecoder.decodeObjectForKey("user_state") as? UserState
        super.init()
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(self.access_token, forKey: "access_token")
        aCoder.encodeObject(self.expires_in, forKey: "expires_in")
        aCoder.encodeObject(self.remind_in, forKey: "remind_in")
        aCoder.encodeObject(self.uid, forKey: "uid")
        aCoder.encodeObject(self.userState as? AnyObject  , forKey:"user_state")
    }
    
    func getUserInfo(userDic:[String:NSObject]){
        self.access_token = userDic["access_token"] as? String
        self.expires_in = userDic["expires_in"] as? String
        self.remind_in = userDic["remind_in"] as? String
        self.uid = userDic["uid"] as? String
        self.userState =  .Login
    }
}
