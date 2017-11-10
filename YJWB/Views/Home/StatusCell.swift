//
//  StatusCell.swift
//  YJWB
//
//  Created by  ZhouYingJie on 16/6/1.
//  Copyright © 2016年 ZhouYingJie. All rights reserved.
//

import UIKit

class StatusCell: UITableViewCell {
    var downTapCell:DownTap?
    
    var statusFrame = StatusFrame()
    var statusTopView:StatusTopView!
    
    //数据
    var status:Status{
        set(newStatus){
            self.displayData(newStatus)
        }
        get{
            return self.status
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .None
        self.selectedBackgroundView = UIView()
        self.statusTopView = StatusTopView()
        self.contentView.addSubview(self.statusTopView)
        
        let lineView = UIView()
        lineView.backgroundColor = RGBA(245, g: 245, b: 245, a: 245)
        self.contentView.addSubview(lineView)
        lineView.sd_layout()
        .leftSpaceToView(self.contentView,0)
        .topSpaceToView(self.contentView,0)
        .widthIs(SCREEN_WIDTH)
            .heightIs(10);
        
        //点击原创
        statusTopView.downViewTapBlock { (statusFrame, flag, link) in
            self.downTapCell?(statusFrame:statusFrame,flag:flag,link:link)
        }
    }
    
    //点击箭头
    func downTapCellBlock(block:DownTap){
        self.downTapCell = block
    }
    
    //展示数据
    func displayData(status:Status){
        self.statusFrame.setStatusFrame(status)
        self.statusTopView.setStatusFrame(self.statusFrame)
        self.statusTopView.frame = self.statusFrame.originalViewF
    }
    
    //高
    func cellHeight(status:Status) -> CGFloat {
        self.displayData(status)
        return self.statusTopView.frame.size.height
    }
    
}
