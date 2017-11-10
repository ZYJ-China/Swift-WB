//
//  OauthViewController.swift
//  微博
//
//  Created by  ZhouYingJie on 16/5/31.
//  Copyright © 2016年 ZhouYingJie. All rights reserved.
//

import UIKit

class OauthViewController: BaseViewController {
    
    let authAuthorizeURL = "https://api.weibo.com/oauth2/authorize?client_id=3744983776&redirect_uri=http://www.baidu.com"
    
    var webView = UIWebView()
    override func viewDidLoad() {
        self.title = "授权 登录"
        self.webView = UIWebView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT))
        self.webView.scalesPageToFit = true;
        self.webView.delegate = self;
        self.view.addSubview(self.webView);
        let url = NSURL(string: authAuthorizeURL)
        let request = NSURLRequest(URL: url!)
        self.webView.loadRequest(request)
    }
}
//MARK:用户信息
extension OauthViewController {
    //获取access_token
    func accessTokenWithCode(code:String)  {
        var params = [String:NSObject]()
        params["client_id"] = "3744983776"
        params["client_secret"] = "6029cb790c3b4e86b52835d92bdac67e"
        params["grant_type"] = "authorization_code"
        params["code"] = code;
        params["redirect_uri"] = "http://www.baidu.com"
        
        NetManager.POST(accessToken , params: params, success: { (result) in
            //   print(result);
            if let dict = result as? [String:NSObject]{
                let user = UserModel()
                user.getUserInfo(dict)
                UserManager.sharedInstance.saveUserData(user)
                self.getUserInfo(dict)
            }
            
        }) { (error) in
            
        }
        
    }
    //获取用户信息
    func getUserInfo(userData:[String:NSObject]) {
        var params = [String:NSObject]()
        params["uid"] = userData["uid"]
        params["access_token"] = userData["access_token"]
        
        NetManager.GET(userInfo, params: params, success: { (result) in
            
            if let userDict = result as? [String:NSObject]{
                USERDEFAULRTS.setValue(userDict["screen_name"], forKey: "screen_name")
                USERDEFAULRTS.synchronize()
            }
            
            self.webView.removeFromSuperview()
            mainWindow?.rootViewController = MainTabBarViewController()
        }) { (error) in
            
        }
        
    }

}

//MARK:UIWebViewDelegate
extension OauthViewController:UIWebViewDelegate{
//    func webViewDidFinishLoad(webView: UIWebView) {
//        self.hudShow()
//    }
//    
//    func webViewDidStartLoad(webView: UIWebView) {
//        self.hudHide()
//    }
    
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        
        let urlString:NSString = request.URL!.absoluteString
        if urlString.hasPrefix("http://www") {
            let range:NSRange = urlString.rangeOfString("code=")
            if range.length != 0{
                let code = urlString.substringFromIndex(range.location + range.length)
                //  print("code = \(code)")
                   self.accessTokenWithCode(code)
            }
        }
        return true
    }

}