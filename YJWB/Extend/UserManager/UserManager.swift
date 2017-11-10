//
//  UserManager.swift
//  SwiftStu
//
//  Created by  ZhouYingJie on 16/3/21.
//  Copyright © 2016年 ZhouYingJie. All rights reserved.
//

import UIKit

private let path = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentationDirectory, NSSearchPathDomainMask.AllDomainsMask, true)[0].stringByAppendingString("useraa.data")

class UserManager: NSObject {
//
//    let USERARCHIVE = "userinfo.archive"
//    let CURRENT_USER_FILE = "lastUserId.archive"

    var curUserInfo:UserModel?

    class var sharedInstance : UserManager {
        struct Static {
            static var onceToken : dispatch_once_t = 0
            static var userInfo : UserManager? = nil
        }
        dispatch_once(&Static.onceToken) {
            Static.userInfo = UserManager()
        }
        return Static.userInfo!
    }

    override init() {
        let userModel = UserModel()
        self.curUserInfo = userModel
    }


    func saveUserData(user:UserModel)->Bool{
        return NSKeyedArchiver.archiveRootObject(user, toFile: path)
    }
    
    

    func loadUserData()->UserModel?{
      //  print(path)
        return  NSKeyedUnarchiver.unarchiveObjectWithFile(path) as? UserModel
    }  
}
