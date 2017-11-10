//
//  Status.swift
//  YJWB
//
//  Created by  ZhouYingJie on 16/6/1.
//  Copyright © 2016年 ZhouYingJie. All rights reserved.
//


//MARK:原创微博
struct Status {
    var idStr:String!           //微博id
    var created_at:String!     //时间
    var source:String?         //来源
    var text:String?           //正文
    var pic_urls:[AnyObject]?      //图片
    var reposts_count:Int?   //转发数
    var comments_count:Int?  //评论数
    var attitudes_count:Int?  //表态数
    var user:User!  //用户
    var reStatus:ReStatus!  //转发
   init(statusData:JSON){
        self.idStr = statusData["idstr"].string
        self.created_at = statusData["created_at"].string
        self.source = statusData["source"].string
        self.text = statusData["text"].string
        self.pic_urls = statusData["pic_urls"].arrayObject
        self.reposts_count = statusData["reposts_count"].intValue
        self.comments_count = statusData["comments_count"].intValue
        self.attitudes_count = statusData["attitudes_count"].intValue
        self.user = User.init(userData: statusData["user"])
        self.reStatus = ReStatus.init(reStatusData: statusData["retweeted_status"])
    }
}

////MARK:转发微博
struct ReStatus {
    var idStr:String!           //微博id
    var created_at:String!     //时间
    var source:String?          //来源
    var text:String?           //正文
    var pic_urls:[AnyObject]?      //图片
    var reposts_count:Int = 0    //转发数
    var comments_count:Int = 0  //评论数
    var attitudes_count:Int = 0  //表态数
    var user:User!
    init(reStatusData:JSON){
        self.idStr = reStatusData["idstr"].string
        self.created_at = reStatusData["created_at"].string
        self.source = reStatusData["source"].string
        self.text = reStatusData["text"].string
        self.pic_urls = reStatusData["pic_urls"].arrayObject
        self.reposts_count = reStatusData["reposts_count"].intValue
        self.comments_count = reStatusData["comments_count"].intValue
        self.attitudes_count = reStatusData["attitudes_count"].intValue
        self.user = User.init(userData: reStatusData["user"])
    }
}

//MARK:用户信息
struct User {
    var idStr:String!        //用户ID
    var profile_image_url:String!
    var screen_name :String?
    
    init(userData:JSON){
        self.idStr = userData["idstr"].string
        self.profile_image_url = userData["profile_image_url"].string
        self.screen_name = userData["screen_name"].string
    }
}


struct Emotions {
    //获取表情
    var value:String?
    var url:String? //表情地址
    
    init(emotion:JSON){
        self.value = emotion["value"].string
        self.url = emotion["url"].string
    }
    
}








