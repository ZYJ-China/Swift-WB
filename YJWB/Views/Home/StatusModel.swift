//
//  StatusModel.swift
//  YJWB
//
//  Created by  ZhouYingJie on 16/6/1.
//  Copyright © 2016年 ZhouYingJie. All rights reserved.
//

struct StatusModel {

    //获取自己关注的最新微博
    static func loadDataWithSuccess(page:Int,success:[[String:NSObject]]? -> Void, failure:NSError? -> Void){
        self.loadUserData()
        var params = [String:NSObject]()
        params["access_token"] = UserManager.sharedInstance.curUserInfo?.access_token
        params["count"] = 20
        params["page"] = page
        
        NetManager.GET(home_timeline, params: params, success: { (result) in
            if let dict = result as? [String:NSObject]{
                let tempArray = dict["statuses"] as? [[String:NSObject]]
                success(tempArray)
            }
            
        }) { (error) in
            failure(error)
        }
    }
    
    static func getEmotionsWithSuccess(success:[[String:NSObject]] -> Void){
        self.loadUserData()
        
        var params = [String:NSObject]()
        
        params["access_token"] = UserManager.sharedInstance.curUserInfo?.access_token
        NetManager.GET(emotion, params: params, success: { (result) in
            
            if let emotios  = result as? [[String:NSObject]]{
                success(emotios)
            }
            
        }) { (error) in
        
        }
    }
    
    //返回表情对应的URL
    static func getEmotionUrl(emtionStr:String,success:String -> Void) {
    
        let emotios = USERDEFAULRTS.valueForKey("emotions") as! [[String:NSObject]]
                for tempDic in emotios{
                    if  let emotion = tempDic["value"] {
                        if emotion == emtionStr{
                            success(tempDic["url"] as! String)
                        }
                    }
                    
                }
    }
}


private extension StatusModel{
    //取用户数据
   static func loadUserData() {
        UserManager.sharedInstance.curUserInfo = UserManager.sharedInstance.loadUserData()
    }

}
