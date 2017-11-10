//
//  TeacherHomePageMoreVC.swift
//  GGSTeacher
//
//  Created by cc mac mini on 16/5/13
//  Copyright © 2016年 庄宇飞. All rights reserved.
//

/*
    这里提醒一下tableView的contentSize的height要给的足够的长，不然滑动下一个控制器时，frame会闪动，微博的size给的长，估计也是这个原因吧
    代码还需要简化，这里只是达到效果，公参考
*/
import UIKit

class TeacherHomePageMoreVC: UIViewController,UIScrollViewDelegate{

    var navView:UIToolbar?
    var bacScrollView:UIScrollView!
    let kWidth = UIScreen.mainScreen().bounds.size.width
    let kHeight = UIScreen.mainScreen().bounds.size.height
    var arrs = ["资料","辅导","更多"]
    var toorView:UIView!
    var toorViewH:UIToolbar!
    var scrollLineView:UIView!
    var scrollLineViewH:UIView!
    var firstVC:InforMationViewController?
    var secondVC:TutorViewController?
    var threeVC:BlessViewController?
    var isScroll:Bool = true
    var oldF:CGFloat = 0.0
    var orginW:CGFloat = UIScreen.mainScreen().bounds.size.width/7
    var s:NSInteger = 0
    
    deinit{
        firstVC?.removeObserver(self, forKeyPath: "offerY")
        secondVC?.removeObserver(self, forKeyPath: "offerY")
        threeVC?.removeObserver(self, forKeyPath: "offerY")
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: .Default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.setBackgroundImage(nil, forBarMetrics: .Default)
        self.navigationController?.navigationBar.shadowImage = nil
    }
    
    func back(){
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        self.automaticallyAdjustsScrollViewInsets = false
        self.navTitleView()
        self.addController()
        self.addButton()
        let vc:InforMationViewController = (self.childViewControllers.first! as? InforMationViewController)!
        vc.view.frame = self.bacScrollView.bounds
        self.bacScrollView.addSubview(vc.view)
    }
    
    //FIXME:添加控制器
    func addController(){
        let vc:InforMationViewController = InforMationViewController()
        weak var weakSelf = self
        vc.firstBlock = {(isScroll:Bool)->Void in
            self.isScroll = isScroll
            weakSelf?.isTouchToButton()
        }
        vc.view.backgroundColor = UIColor.whiteColor()
        firstVC = vc
        firstVC!.addObserver(self, forKeyPath: "offerY", options: NSKeyValueObservingOptions.New, context: nil)
        self.addChildViewController(vc)
        
        let vc2:TutorViewController = TutorViewController()
        vc2.secondBlock = {(isScroll:Bool)->Void in
        self.isScroll = isScroll
           weakSelf?.isTouchToButton()
        }
        vc2.view.backgroundColor = UIColor.whiteColor()
        secondVC = vc2
        secondVC!.addObserver(self, forKeyPath: "offerY", options: NSKeyValueObservingOptions.New, context: nil)
        self.addChildViewController(vc2)
        
        let vc3:BlessViewController = BlessViewController()
        vc3.threeBlock = {(isScroll:Bool)->Void in
            self.isScroll = isScroll
            weakSelf?.isTouchToButton()
        }
        vc3.view.backgroundColor = UIColor.whiteColor()
        threeVC = vc3
        threeVC!.addObserver(self, forKeyPath: "offerY", options: NSKeyValueObservingOptions.New, context: nil)
        self.addChildViewController(vc3)
    }
    
    //FIXME:---判断button是否可点击
    func isTouchToButton(){
        if self.isScroll == true{
            self.toorView.userInteractionEnabled = true
            self.toorViewH.userInteractionEnabled = true
        }else{

            self.toorView.userInteractionEnabled = false
            self.toorViewH.userInteractionEnabled = false
        }
    }
    
    //FIXME:KVO接收
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        let offsetY = change?["new"] as! CGFloat
        let s = offsetY - oldF
        oldF = offsetY
        self.toorView.frame.origin.y -= s
        
        if offsetY >= 136 {
            self.toorViewH.hidden = false
        }else{
        
            self.toorViewH.hidden = true
        }
        
        if offsetY > 0{
            self.navView!.alpha = ((offsetY-10)/100)
        }else if offsetY == 0{
            UIView.animateWithDuration(0.23, animations: { () -> Void in
                self.navView!.alpha = ((offsetY-10)/100)
            })
        }
    }
    
    //FIXME:添加button
    func addButton(){
        for var i=0; i<arrs.count; ++i{
            let W:CGFloat = orginW
            let H:CGFloat = 40
            let Y:CGFloat = 0
            let X:CGFloat = CGFloat(i) * (W + orginW) + W
            
            let button:UIButton = UIButton()
            button.frame = CGRect(x: X, y: Y, width: W, height: H)
            button.setTitleColor(UIColor.blackColor(), forState: .Normal)
            button.setTitle(arrs[i], forState: .Normal)
            button.titleLabel?.font = UIFont.systemFontOfSize(15.0)
            button.tag = i
            button.addTarget(self, action: "buttonAction:", forControlEvents: .TouchUpInside)
            self.toorView.addSubview(button)
            
            let buttonH:UIButton = UIButton()
            buttonH.frame = CGRect(x: X, y: Y, width: W, height: H)
            buttonH.setTitleColor(UIColor.blackColor(), forState: .Normal)
            buttonH.setTitle(arrs[i], forState: .Normal)
            buttonH.titleLabel?.font = UIFont.systemFontOfSize(15.0)
            buttonH.tag = i
            buttonH.addTarget(self, action: "buttonAction:", forControlEvents: .TouchUpInside)
            self.toorViewH.addSubview(buttonH)
        }
    }
    
    //FIXME:button点击事件
    func buttonAction(sender:UIButton){
        UIView.animateWithDuration(0.3) { () -> Void in
                self.scrollLineViewH.frame.origin.x  = CGFloat(sender.tag) * (self.orginW + self.orginW) + self.orginW
                self.scrollLineView.frame.origin.x  = CGFloat(sender.tag) * (self.orginW + self.orginW) + self.orginW
        }
        
        let selectedVC:UIViewController = self.childViewControllers[sender.tag]
        if (selectedVC.view.superview == nil){
            selectedVC.view.frame = self.bacScrollView.bounds
            self.bacScrollView.addSubview(selectedVC.view)
        }
            self.bacScrollView.bringSubviewToFront(selectedVC.view)
    }
    
    //FIXME:添加控件
    func navTitleView(){
        bacScrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: kWidth, height: kHeight))
        bacScrollView.delegate = self
        bacScrollView.showsHorizontalScrollIndicator = false
        bacScrollView.showsVerticalScrollIndicator = false
        bacScrollView.backgroundColor = UIColor.greenColor()
        self.view.addSubview(bacScrollView)
        
        navView = UIToolbar(frame: CGRect(x: 0, y: 0, width: kWidth, height: 64))
        navView!.backgroundColor = UIColor.whiteColor()
        navView!.layer.shadowColor = UIColor.grayColor().CGColor
        navView!.layer.shadowOpacity = 0.5
        navView!.layer.shadowOffset = CGSize(width: 0, height: 0.2)

        let titleLabel = UILabel(frame: CGRect(x: 0, y: 30, width: kWidth, height: 20))
        titleLabel.textColor = UIColor.blackColor()
        titleLabel.text = "个人主页"
        titleLabel.font = UIFont.boldSystemFontOfSize(17.0)
        titleLabel.textAlignment = .Center
        navView!.addSubview(titleLabel)
        navView!.alpha = 0
        self.view.addSubview(navView!)

        toorViewH = UIToolbar(frame: CGRect(x: 0, y: 64, width: kWidth, height: 40))
        toorViewH.hidden = true
        self.view.insertSubview(toorViewH, aboveSubview: self.bacScrollView)
        scrollLineViewH = UIView(frame: CGRect(x: orginW, y: 37, width: orginW, height: 3))
        scrollLineViewH.backgroundColor = UIColor.greenColor()
        toorViewH.addSubview(scrollLineViewH)

        
        toorView = UIView(frame: CGRect(x: 0, y: 200, width: kWidth, height: 40))
        toorView.backgroundColor = UIColor(colorLiteralRed: 245/255.0, green: 245/255.0, blue: 245/255.0, alpha:1)
        toorView.layer.shadowColor = UIColor.grayColor().CGColor
        self.view.insertSubview(toorView, aboveSubview: self.bacScrollView)
        scrollLineView = UIView(frame: CGRect(x: orginW, y: 37, width: orginW, height: 3))
        scrollLineView.backgroundColor = UIColor.greenColor()
        toorView.addSubview(scrollLineView)
        
    }
}
