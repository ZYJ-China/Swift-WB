//
//  MineHeaderView.swift
//  YJWB
//
//  Created by  ZhouYingJie on 16/6/8.
//  Copyright © 2016年 ZhouYingJie. All rights reserved.
//

import UIKit

class MineHeaderView: UIView {

    var headImageView:UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let headImageView = UIImageView()
        headImageView.image = setImage("123")
        headImageView.frame = self.bounds
        self.addSubview(headImageView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
