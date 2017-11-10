//
//  BlessViewController.swift
//  GGSTeacher
//
//  Created by cc mac mini on 16/5/13.
//  Copyright © 2016年 庄宇飞. All rights reserved.
//

import UIKit

typealias BlessBlock = (blessBlock:Bool)->Void
class BlessViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    let kWidth = UIScreen.mainScreen().bounds.size.width
    let kHeight = UIScreen.mainScreen().bounds.size.height
    var tbView:UITableView!
    dynamic var offerY:CGFloat = 0.0
    var headView:MineHeaderView!
    var threeBlock:BlessBlock?
    deinit{
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.createTableView()
    }
    
     //FIXME:-----接收的通知
    func notiAction(notification:NSNotification){
        var dic = notification.userInfo
        let y:CGFloat = (dic!["inforY"] as? CGFloat)!
        if y >= 136{
            if tbView.contentOffset.y < 136{
                tbView.contentOffset.y = 136
            }
        }else{
            tbView.contentOffset.y = y
        }
    }
    
     //FIXME:-----创建 tableView
    func createTableView(){
        tbView = UITableView(frame: CGRect(x: 0, y: 0, width:kWidth , height: kHeight), style:UITableViewStyle.Grouped)
        tbView.dataSource = self
        tbView.delegate = self
        self.view.addSubview(tbView!)
        
        headView = MineHeaderView.init(frame: setRect(0, y: 0, w: SCREEN_WIDTH, h: 200))
        headView.frame = CGRect(x: 0, y: 0, width: kWidth, height: 200)
        self.tbView.tableHeaderView = headView
        
        self.tbView!.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "notiAction:", name: "inforSwift", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "notiAction:", name: "turorSwift", object: nil)

    }
    
    //FIXME:-----tableView delegate
    func numberOfSectionsInTableView(tableView: UITableView) -> Int{
        
        return 2
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        if section == 0{
            return 1
        }else{
            
            return 20
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let identity:String = "cell"
        var cell:UITableViewCell! = tableView.dequeueReusableCellWithIdentifier(identity, forIndexPath: indexPath)
        if (cell == nil) {
            cell = UITableViewCell(style: .Default, reuseIdentifier: identity)
        }
        cell.textLabel?.text = "FEI       ->\(indexPath.row)"
        if (indexPath.row % 3) == 0{
            cell.backgroundColor = UIColor.purpleColor()
        }else{
             cell.backgroundColor = UIColor.whiteColor()
        }
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 0{
            return 40
        }else{
            
            return 50
        }
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
    }
    
     //FIXME:-----scrollView delegate
    func scrollViewDidScroll(scrollView: UIScrollView) {
        self.offerY = scrollView.contentOffset.y
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        if(threeBlock != nil){
            threeBlock!(blessBlock:true)
        }
        let offer:CGFloat = scrollView.contentOffset.y
        tbView.contentOffset.y = offer
        var dic:Dictionary<String,CGFloat> = Dictionary()
        dic["inforY"] = offer
        NSNotificationCenter.defaultCenter().postNotificationName("BlessSwift", object: nil, userInfo: dic)
        
  }
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        if(threeBlock != nil){
            threeBlock!(blessBlock:false)
        }
    }
    
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {//手指松开
       
        if decelerate == false{
           self.scrollViewDidEndDecelerating(scrollView)
        }
    }
}
