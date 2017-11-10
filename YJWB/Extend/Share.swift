//
//  Share.swift
//  微博
//
//  Created by  ZhouYingJie on 16/5/31.
//  Copyright © 2016年 ZhouYingJie. All rights reserved.
//

struct Share {
    //MARK: - 网络监测 -
    static func isConnect() -> Bool {
        var retValue = false
        let reachability = try! Reachability.reachabilityForInternetConnection()
        //判断连接状态
        if reachability.isReachable(){
            // statusLabel.text = "网络连接：可用"
            retValue = true
        }else{
            //  statusLabel.text = "网络连接：不可用"]
            retValue = false
        }
        
        //判断连接类型
        //        if reachability!.isReachableViaWiFi() {
        //           // typeLabel.text = "连接类型：WiFi"
        //        }else if reachability!.isReachableViaWWAN() {
        //           // typeLabel.text = "连接类型：移动网络"
        //        }else {
        //           // typeLabel.text = "连接类型：没有网络连接"
        //        }
        
        return retValue
    }
    
    //时间戳
    static func stringToTimeStamp(stringTime:String)->String {
        
        let dfmatter = NSDateFormatter()
        dfmatter.dateFormat="yyyy年MM月dd日"
        let date = dfmatter.dateFromString(stringTime)
        
        let dateStamp:NSTimeInterval = date!.timeIntervalSince1970
        
        let dateSt:Int = Int(dateStamp)
        print(dateSt)
        return String(dateSt)
        
    }
    
    static func imageWithColor(color:UIColor) -> UIImage{
        let rect = CGRectMake(0.0, 0.0, 1.0, 1.0)
        UIGraphicsBeginImageContext(rect.size);
        let context:CGContextRef = UIGraphicsGetCurrentContext()!;
        
        CGContextSetFillColorWithColor(context, color.CGColor)
        
        CGContextFillRect(context, rect);
        let image:UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext();
        return image
    }
}
