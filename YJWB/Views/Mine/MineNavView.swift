//
//  MineNavView.swift
//  YJWB
//
//  Created by  ZhouYingJie on 16/6/8.
//  Copyright © 2016年 ZhouYingJie. All rights reserved.
//

import UIKit

class MineNavView: UIView {

    var viewF:CGRect!
    var titleLabel:UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    convenience  init(name:String) {
        self.init()
        self.viewF = setRect(0, y: 0, w: SCREEN_WIDTH, h: NAV_HEIGHT)
        let titleLabel = UILabel()
        titleLabel.text = name
        titleLabel.font = sysFont(17.0)
        titleLabel.textAlignment = .Center
        self.addSubview(titleLabel)
        titleLabel.sd_layout().topSpaceToView(self,20).leftSpaceToView(self,50)
            .widthIs(SCREEN_WIDTH-100).heightIs(44)
    }
    
}