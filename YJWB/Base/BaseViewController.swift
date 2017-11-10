//
//  BaseViewController.swift
//  微博
//
//  Created by  ZhouYingJie on 16/5/31.
//  Copyright © 2016年 ZhouYingJie. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.baseConfigure()
        
    }
    
    //导航栏标题
    func setupTitle(title:String){
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.textAlignment = .Center
        titleLabel.font = sysFont(16)
        self.navigationItem.titleView = titleLabel
        titleLabel.sd_layout().widthIs(100).heightIs(44);
    }
    
    //设置返回按钮
    func backItem(){
        let leftBarBtn = UIBarButtonItem(title: "", style: .Plain, target: self,
                                         action: #selector(BaseViewController.backToPrevious))
        leftBarBtn.image = UIImage(named: "yx_back")
        self.navigationController!.navigationBar.barStyle = .Default
        self.navigationController!.navigationBar.tintColor = BLACKCOLOR; // 返回箭头的颜色
        
        //用于消除左边空隙，要不然按钮顶不到最前面
        let spacer = UIBarButtonItem(barButtonSystemItem: .FixedSpace, target: nil,
                                     action: nil)
        spacer.width = -10
        navigationItem.leftBarButtonItems = [spacer, leftBarBtn]
    }

    func backToPrevious() {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    //导航左侧按钮
    func setLeftNavBtn(imageName:String,action:Selector){
        let leftBarBtn = UIBarButtonItem(title: "", style: .Plain, target: self,
                                         action: action)
        leftBarBtn.image = UIImage(named: imageName)
        self.navigationController!.navigationBar.tintColor = UIColor.lightGrayColor();
        let spacer = UIBarButtonItem(barButtonSystemItem: .FixedSpace, target: nil,
                                     action: nil)
        spacer.width = -10
        navigationItem.leftBarButtonItems = [spacer, leftBarBtn]
    }
}

//封装HUD
extension BaseViewController {
    //提示
    func showMessage(message:String) {
        let textHud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        textHud.mode = .Text
        textHud.animationType = .Zoom;
        textHud.margin = 15.0;
        textHud.yOffset = -20.0;
        textHud.removeFromSuperViewOnHide = true;
        textHud.hide(true, afterDelay: 1.0);
        textHud.labelText = message;
    }
    
    func hudShow(){
       MBProgressHUD.showHUDAddedTo(self.view, animated: true)
    }
    
    func hudHide() {
        MBProgressHUD.hideHUDForView(self.view, animated: true)
    }
}

//配置
private extension BaseViewController {
   
    func baseConfigure(){
        self.view.backgroundColor = VIEWBACKCOLOR
        //导航栏背景白色
//       self.navigationController?.navigationBar.barTintColor =  WHITECOLOR
//        self.navigationController?.navigationBar.backgroundColor = WHITECOLOR
        self.edgesForExtendedLayout = .None
        self.automaticallyAdjustsScrollViewInsets = false
        
    }

}













