//
//  NetManager.swift
//  微博
//
//  Created by  ZhouYingJie on 16/5/31.
//  Copyright © 2016年 ZhouYingJie. All rights reserved.
//

struct NetManager {
    //MARK:POST
    
    static func POST(URLString:String,params:[String:AnyObject]?,success:(AnyObject?) -> Void,failure:(NSError?) -> Void){
        
        if Share.isConnect(){
            let manager = AFHTTPSessionManager()
         //   manager.responseSerializer = AFHTTPResponseSerializer.serializer()
            manager.requestSerializer.timeoutInterval = 10;
            if manager.requestSerializer.timeoutInterval > 10 {
                // mainWindow?.makeToast("请求超时")
                //ShowToast.toastMeassge("请求超时")
            }
            manager.POST(URLString, parameters: params, progress: nil, success: { (task, responseObject) -> Void in
               // print(URLString)
                //print(params)
                //请求成功
                success(responseObject as? NSObject)
                
            }) { (task, error) -> Void in
                //请求失败
                failure(error)
                print(error)
                //ShowToast.toastMeassge(netError)
            }
        }else {
            //ShowToast.toastMeassge(netError)
        }
    }
    //MARK:GET
    static func GET(URLString:String,params:[String:NSObject]?,success:((NSObject?)->Void)?,failure:((NSError?)->Void)?){
        if Share.isConnect() {
            let manager = AFHTTPSessionManager()
            manager.requestSerializer.timeoutInterval = 10;
            if manager.requestSerializer.timeoutInterval > 10 {
               // ShowToast.toastMeassge("请求超时")
            }
            manager.GET(URLString, parameters: params, progress: nil, success: { (task, responseObject) -> Void in
                
                //请求成功
                success?(responseObject as? NSObject)
                
            }) { (task, error) -> Void in
                //请求失败
                failure?(error)
                ShowToast.toastMeassge(netError)
            }
        }else {
           // ShowToast.toastMeassge(netError)
        }
    }

}
