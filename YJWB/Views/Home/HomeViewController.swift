//
//  HomeViewController.swift
//  微博
//
//  Created by  ZhouYingJie on 16/5/31.
//  Copyright © 2016年 ZhouYingJie. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController {
    
    var isOpen:Bool = false
    var page = 1
    
    lazy var statusData : [Status] = {
        let status = [Status]()
        return status
    }()
  
    
    lazy var listTableView: HomeTableView = {
        let tempTableView = HomeTableView.init(frame: CGRect(x:0,y: 0,width: SCREEN_WIDTH,height: SCREEN_HEIGHT - NAV_HEIGHT - TABBAR_HEIGHT), style: .Plain)
        tempTableView.backgroundColor = VIEWBACKCOLOR
        return tempTableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(self.listTableView)
        setNavButton()
        addMJHeaderAndFooter()
        listTableView.headerBeginRefresh()
        blockAction()
    }
    
    
    //回调
    func blockAction(){
        self.listTableView.downTapTableBlock { (statusFrame, flag, link) in
            /*
                flag 1:头像 2:箭头 3:转发 4：评论 5：点赞
             */
            switch flag{
            case 1:
                print("头像")
            case 2:
                self.tapIconView()
            case 3:
                print("转发")
            case 4:
                print("评论")
            case 5:
                print("点赞")
            case 6:
                print("链接: \(link)")
            case 7:
                print("用户: \(link)")
            case 8:
                print("话题: \(link)")
            case 9:
                print("转发链接: \(link)")
            case 10:
                print("转发用户: \(link)")
            case 11:
                print("转发话题: \(link)")
            default:
                break
            }
            
        }
        
    }
    
    func addMJHeaderAndFooter(){
        self.listTableView.headerAddMJRefresh { () -> Void in
            self.statusData.removeAll()
            self.listTableView.footerResetNoMoreData()
            self.page = 1
            self.loadData()
            if !Share.isConnect(){
                self.listTableView.headerEndRefresh()
            }
        }

        self.listTableView.footerAddMJRefresh { () -> Void in
            self.page += 1
            self.loadData()
        }
    }
    
    func loadData() {
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) { () -> Void in
        StatusModel.loadDataWithSuccess(self.page, success: { (dataArray) in
            //数据
          //  print(dataArray)
            for tempDict in dataArray! {
                let statusValue = JSON(tempDict)
                self.statusData.append(Status(statusData:statusValue))
            }
            self.listTableView.statusData = self.statusData
            
            if self.page == 1{
                self.listTableView.headerEndRefresh()
            }else{
                self.listTableView.footerEndRefresh()
            }
            
            dispatch_async(dispatch_get_main_queue(), {
                self.listTableView.reloadData()
            })

            }, failure: { (error) in
                self.listTableView.headerEndRefresh()
                self.listTableView.footerEndRefresh()
                dispatch_async(dispatch_get_main_queue(), {
                    self.showMessage(netError)
                })
            })
        }
    }
    
    func setNavButton() {
        self.navigationController?.navigationBarHidden = true
//        let screen_name = USERDEFAULRTS.valueForKey("screen_name") as! String
//        let titleBtn = UIButton.init(type: .Custom)
//        titleBtn.setTitle(screen_name, forState: .Normal)
//        titleBtn.setImage(setImage("navigationbar_arrow_down"), forState: .Normal)
//        titleBtn.adjustsImageWhenHighlighted = false;
//        titleBtn.titleLabel!.font = sysFont(16.0)
//        titleBtn.titleLabel!.textAlignment = .Center;
//        titleBtn.setTitleColor(BLACKCOLOR, forState: .Normal)
//        self.navigationItem.titleView = titleBtn
//        titleBtn.sd_layout().widthIs(SCREEN_WIDTH).heightIs(44)
//        titleBtn.addTarget(self, action: #selector(HomeViewController.changeList(_:)), forControlEvents: .TouchUpInside)
//        
//        //字体宽
//        let  titleRect = sizeWithFont(screen_name, font: sysFont(16.0), size: CGSizeMake(SCREEN_WIDTH,44))
//        titleBtn.imageEdgeInsets = UIEdgeInsetsMake(0, titleRect.width/2+10, 0, -titleRect.width/2-10)
//        titleBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -titleRect.width/2-10, 0, titleRect.width/2+10)
//
//        self.setLeftNavBtn("tabbar_profile", action: #selector(HomeViewController.tapAction))
//        }
    
        
        let naviBar = UIToolbar.init(frame: setRect(0, y: 0, w: SCREEN_WIDTH, h: NAV_HEIGHT))
        naviBar.barTintColor = WHITECOLOR
        naviBar.layer.shadowColor = UIColor.blackColor().CGColor
        naviBar.layer.shadowOpacity = 0.1
        naviBar.layer.shadowOffset = CGSize(width: 0, height: 0.2)

        self.view.addSubview(naviBar)
        self.listTableView.contentInset = UIEdgeInsetsMake(NAV_HEIGHT, 0, 0, 0);
        self.listTableView.scrollIndicatorInsets = UIEdgeInsetsMake(NAV_HEIGHT, 0, 0, 0);
    }
    func tapAction()  {
        
    }
    
    func changeList(buton:UIButton) {
        self.isOpen = !self.isOpen;
        let image = self.isOpen ? setImage("navigationbar_arrow_up"):setImage("navigationbar_arrow_down")
        buton.setImage(image, forState: .Normal)
    }
}


//block操作
private extension HomeViewController {
    func tapIconView() {
        let items = ["收藏","帮上头条","取消关注","屏蔽","举报"]
        let actionSheet = YJPopView.init(items: items, type: .Sheet)
        actionSheet.show()
        actionSheet.didSelectItem({ (index) in
            print(index)
        })
    }
}

