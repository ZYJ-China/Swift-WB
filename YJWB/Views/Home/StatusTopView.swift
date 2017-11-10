//
//  TopView.swift
//  YJWB
//
//  Created by  ZhouYingJie on 16/6/1.
//  Copyright © 2016年 ZhouYingJie. All rights reserved.
//

import UIKit

typealias DownTap = (_ statusFrame:StatusFrame,_ flag:Int,_ link:String) -> Void

class StatusTopView: UIView {
    var downTap:DownTap?

    //头像
    var iconView : UIImageView!
    //昵称
    var nameBtn : UIButton!
    //时间
    var timeLabel : UILabel!
    //来源
    var sourceLabel: UILabel!
    var contentLabel:MLEmojiLabel!
    //配图
    var photosView:PhotosView?
    //箭头
    var downView:UIImageView!
    
    //转发控件
    var reStatusView:RestatusView!
    //工具条
    var tooBarView:StatusTooBar!
   lazy var statusFrame = StatusFrame()
    
    var attSText:NSMutableAttributedString!

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //头像
        let iconView = UIImageView()
        iconView.layer.cornerRadius = 17
        iconView.userInteractionEnabled =  true
        self.addSubview(iconView)
        self.iconView = iconView
        
        //昵称
        let nameBtn = UIButton.init(type: .Custom)
        nameBtn.titleLabel!.font = sysFont(NameFont)
        nameBtn.setTitleColor(BLACKCOLOR, forState: .Normal)
        self.addSubview(nameBtn)
        self.nameBtn = nameBtn
        
        //时间
        let timeLabel = UILabel()
        timeLabel.font = sysFont(TimeFont)
        timeLabel.textColor = MAINCOLOR
        self.addSubview(timeLabel)
        self.timeLabel = timeLabel;
        
        //来源
        let sourceLabel = MLEmojiLabel()
        sourceLabel.font = sysFont(SourceFont)
        sourceLabel.textColor = UIColor.lightGrayColor()
        self.addSubview(sourceLabel)
        self.sourceLabel = sourceLabel;
        
        //正文
        let contentLabel = MLEmojiLabel()
        contentLabel.numberOfLines = 0
        contentLabel.font = sysFont(ContentFont)
        contentLabel.isNeedAtAndPoundSign = true
        self.addSubview(contentLabel)
        self.contentLabel = contentLabel;
        
        //配图
        let photosView = PhotosView()
        self.addSubview(photosView)
        self.photosView = photosView;
        
        let downView = UIImageView()
        downView.userInteractionEnabled = true

        downView.image = setImage("home_timeline_down.png")
        self.addSubview(downView)
        self.downView = downView
        
        //转发
        reStatusView = RestatusView()
        reStatusView.backgroundColor = RGBA(245, g: 245, b: 245, a: 1.0)
        self.addSubview(reStatusView)
        
        //工具条
        tooBarView = StatusTooBar()
        self.addSubview(tooBarView)
        
        //点击事件
        self.addViewTap(iconView,flag: 1)
        self.addViewTap(downView,flag: 2)
        
    }
    
    
    func downViewTap(tap:UITapGestureRecognizer) {
        if let indexTag = tap.view?.tag{
            self.downTap?(statusFrame:self.statusFrame,flag:indexTag,link:"")
        }
    }
    
     func downViewTapBlock(block:DownTap){
        self.downTap = block
    }
    
    //设置数据
    func setStatusFrame(statusFrame:StatusFrame){
        self.statusFrame = statusFrame
        self.iconView.sd_setImageWithURL(NSURL.init(string: statusFrame.status.user.profile_image_url!))
        self.iconView.frame = statusFrame.iconViewF
        
        // 昵称
        self.nameBtn.setTitle(statusFrame.status.user.screen_name, forState: .Normal)
        self.nameBtn.frame = statusFrame.nameBtnF
        
        // 时间
        let timeArray = statusFrame.status.created_at.componentsSeparatedByString(" ")
        let dateStr = timeArray[3]
        let dateArray = dateStr.componentsSeparatedByString(":")
        self.timeLabel.text = "\(dateArray[0]):\(dateArray[1])"
        self.timeLabel.frame = statusFrame.timeLabelF

       // 来源
        let sourceArray = statusFrame.status.source!.componentsSeparatedByString(">")
        var sourceStr = ""
        if sourceArray.count > 1{
            sourceStr = sourceArray[1]
        }
        let sourceArray2 = sourceStr.componentsSeparatedByString("<")
            self.sourceLabel.text = "来自 \(sourceArray2[0])"
            self.sourceLabel.frame = statusFrame.sourceLabelF
        // 正文
        if let content = statusFrame.status.text {
            self.contentLabel.delegate = self
            self.contentLabel.text = ("\(content)")
            self.contentLabel.frame = statusFrame.contentLabelF;
        }
        // 配图
        if statusFrame.status.pic_urls?.count > 0{

            self.photosView!.hidden = false;
            let pics = statusFrame.status.pic_urls as? [[String:String]]
            self.photosView!.setupPhotos(pics!)
            self.photosView!.frame = statusFrame.photoViewF;
        } else {
            self.photosView!.hidden = true;
        }
        
        self.reStatusView.setStatusFrame(statusFrame)
        self.reStatusView.frame = statusFrame.retweetViewF!
        self.reStatusView.downTapReViewBlock { (statusFrame, flag, link) in
            self.downTap?(statusFrame:statusFrame,flag:flag,link:link)
        }
        
        //箭头
        self.downView.frame = statusFrame.downViewF
        //工具条
        self.tooBarView.setupData(statusFrame)
        self.tooBarView.frame = statusFrame.statusToolBarF!
        
        self.tooBarView.downTapTooBarBlock { (flag) in
            self.downTap?(statusFrame:self.statusFrame,flag:flag,link:"")
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //点击
    func addViewTap(view:UIView,flag:Int) {
        view.tag = flag
        view.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(StatusTopView.downViewTap(_:))))
    }
}

extension StatusTopView :MLEmojiLabelDelegate {
    
    func mlEmojiLabel(emojiLabel: MLEmojiLabel!, didSelectLink link: String!, withType type: MLEmojiLabelLinkType) {
        
        switch type {
        case MLEmojiLabelLinkType.URL:
            self.downTap?(statusFrame:self.statusFrame,flag:6,link:link)
            //print("点击了链接%@",link);
            
        case MLEmojiLabelLinkType.PhoneNumber:
            print("点击了电话%@",link);
        case MLEmojiLabelLinkType.Email:
            print("点击了邮箱%@",link);
        case MLEmojiLabelLinkType.At:
           // print("点击了用户%@",link);
            self.downTap?(statusFrame:self.statusFrame,flag:7,link:link)
        case MLEmojiLabelLinkType.PoundSign:
          //  print("点击了话题%@",link);
            self.downTap?(statusFrame:self.statusFrame,flag:8,link:link)
        default:
            print("点击了不知道啥%@",link);
            break;
        }
    }
}





