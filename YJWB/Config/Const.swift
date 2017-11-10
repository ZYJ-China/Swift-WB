//
//  Const.swift
//  微博
//
//  Created by  ZhouYingJie on 16/5/31.
//  Copyright © 2016年 ZhouYingJie. All rights reserved.
//

import UIKit
//Window
let mainWindow = UIApplication.sharedApplication().delegate!.window!
let netError = "网络异常,请检查网络"
//登陆
let Login = "login"
let UnLogin = "unLogin"
//简单宏
let SCREEN_HEIGHT = UIScreen.mainScreen().bounds.size.height
let SCREEN_WIDTH = UIScreen.mainScreen().bounds.size.width
let NAV_HEIGHT : CGFloat = 64.0
let TABBAR_HEIGHT : CGFloat = 48.0
let TopHeight :CGFloat = 40
let BtnHeight :CGFloat = 44
//项目主色
let MAINCOLOR = RGBA(252,g:108,b:8,a:1)
//背景色
let VIEWBACKCOLOR = RGBA(240,g:240,b:240,a: 1)
//透明
let CLEARCOLOR = UIColor.clearColor()
//黑色
let BLACKCOLOR = UIColor.blackColor()
//白色
let WHITECOLOR = UIColor.whiteColor()
//通知
let NOTICENTER = NSNotificationCenter.defaultCenter()
//NSUserDefaults
let USERDEFAULRTS = NSUserDefaults.standardUserDefaults()
//系统版本
let VERSION = UIDevice.currentDevice().systemVersion

let IPHONE_4 = SCREEN_HEIGHT == 480
let IPHONE_5 = SCREEN_HEIGHT == 568
let IPHONE_6 = SCREEN_HEIGHT == 667
let IPHONE_6p = SCREEN_HEIGHT == 736
//appdelegate
let APPDELEGATE = UIApplication.sharedApplication().delegate as! AppDelegate
//获取Main Dispatch Queue
let mainQueue = dispatch_get_main_queue()
//获取Global Dispatch Queue
let globalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
//程序跳转
func openURL(urlString:String) {
    UIApplication.sharedApplication().openURL(NSURL(string: urlString)!)
}
//打电话
func callPhone(numberPhone:String){
    let phoneStr = "telprompt://" + numberPhone
    UIApplication.sharedApplication().openURL(NSURL(string: phoneStr)!)
}

//发短信
func sendMeassage(numberPhone:String){
    let phoneStr = "sms://" + numberPhone
    UIApplication.sharedApplication().openURL(NSURL(string: phoneStr)!)
}
//计算字体宽高
func sizeWithFont(string:String,font:UIFont,size:CGSize) -> CGRect {
    let attributes = [NSFontAttributeName: font]
    
    let option = NSStringDrawingOptions.UsesLineFragmentOrigin
    
    let rect:CGRect = string.boundingRectWithSize(size, options: option, attributes: attributes, context: nil)
    return rect
}
//字体
func sysFont(size:CGFloat) -> UIFont {
    return UIFont.systemFontOfSize(size)
}
func boldFont(size:CGFloat) -> UIFont {
    return UIFont.boldSystemFontOfSize(size)
}

//设置图片name
func setImage(imageName:String) -> UIImage {
    return UIImage(named: imageName)!
}

//RGB颜色
func RGBA(r:CGFloat,g:CGFloat,b:CGFloat,a:CGFloat) -> UIColor{
    return UIColor(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)
}
//高亮颜色
let hightLightColor = RGBA(67, g: 107, b: 163, a: 1.0)
//获取设备名称
func getPlatForm() -> String {
    return UIDevice.currentDevice().systemName
}
//设置坐标
func setRect(x:CGFloat,y:CGFloat,w:CGFloat,h:CGFloat) -> CGRect{
    return CGRect.init(x: x, y: y, width: w, height: h)
}

//多语言
func getLocal(keyStr:String) -> String {
    return  NSLocalizedString(keyStr,comment:"")
}

func fuwenbenLabel(label:UILabel?,font:UIFont,range:NSRange,color:UIColor){
    
    let str = NSMutableAttributedString(string: (label?.text!)!)
    //设置字号
    str.addAttribute(NSFontAttributeName, value: font, range: range)
    //设置文字颜色
    str.addAttribute(NSForegroundColorAttributeName,value:color,range:range)
    label!.attributedText = str;
}
