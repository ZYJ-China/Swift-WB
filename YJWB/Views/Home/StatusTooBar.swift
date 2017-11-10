//
//  StatusTooBar.swift
//  YJWB
//
//  Created by  ZhouYingJie on 16/6/4.
//  Copyright © 2016年 ZhouYingJie. All rights reserved.
//



class StatusTooBar: UIView {
    typealias DownTapTooBar = (flag:Int) -> Void
    var downTapToobar:DownTapTooBar?
    var toobarImageView = UIImageView()
    lazy var btns = [UIButton]()
    lazy var lines = [UIImageView]()
    var retweetBtn:UIButton!
    var commentBtn:UIButton!
    var unlikeBtn:UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.userInteractionEnabled = true;
        
        self.setupStatusToolBar()
        self.setupBtns()
        self.setupLines()
        self.setupLines()
    }
    
    func setupStatusToolBar(){
        let line =  UIView.init(frame: setRect(0, y: 0, w: SCREEN_WIDTH, h: 1))
        line.backgroundColor = VIEWBACKCOLOR
        self.addSubview(line)
    
        self.toobarImageView.image = setImage("timeline_card_bottom_background")
        self.toobarImageView.highlightedImage = setImage("timeline_card_bottom_background_highlighted")
    }
    
    func setupBtns(){
        self.retweetBtn = self.setBtnTitle("转发", imagheName: "timeline_icon_retweet")
        self.commentBtn = self.setBtnTitle("评论", imagheName: "timeline_icon_comment")
        self.unlikeBtn = self.setBtnTitle("赞", imagheName: "timeline_icon_unlike")
        
        self.retweetBtn.tag = 3
        self.commentBtn.tag = 4
        self.unlikeBtn.tag = 5
    }
    
    func  setupLines() {
        let line = UIImageView()
        line.image = setImage("timeline_card_bottom_line")
        line.highlightedImage = setImage("timeline_card_bottom_line_highlighted")
        self.addSubview(line)
        self.lines.append(line)
    }
    
    func setBtnTitle(name:String,imagheName:String) -> UIButton{
        let btn = UIButton.init(type: .Custom)
        btn.setTitle(name, forState: .Normal)
        btn.setTitleColor(RGBA(133, g: 133, b: 133, a: 1.0), forState: .Normal)
        btn.setImage(setImage(imagheName), forState: .Normal)
        btn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        btn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 5);
        btn.titleLabel!.font = sysFont(12.0)
        btn.addTarget(self, action: #selector(StatusTooBar.btnTapAction(_:)), forControlEvents: .TouchUpInside)
        self.addSubview(btn)
        self.btns.append(btn)
        return btn;
    }
    
    
    func btnTapAction(btn:UIButton){
        self.downTapToobar?(flag:btn.tag)
    }
    
    func downTapTooBarBlock(block:DownTapTooBar){
        self.downTapToobar = block
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // 设置按钮的frame
        let btnY:CGFloat = 0;
        let btnH:CGFloat  = self.bounds.size.height
        let btnW:CGFloat  = self.bounds.size.width / CGFloat(self.btns.count)
        for index in 0 ..< self.btns.count {
            let btnX = CGFloat(index) * btnW;
            let btn:UIButton = self.btns[index];
            btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
        }
       
        
        // 设置线条的frame
        let lineY:CGFloat  = 0;
        let lineW:CGFloat  = 2;
        let lineH:CGFloat  = self.bounds.size.height;
        for  index in 0 ..< self.lines.count{
            let lineX = CGFloat(index + 1) * btnW;
            let line:UIImageView = self.lines[index];
            line.frame = CGRectMake(lineX, lineY, lineW, lineH);
        }
    }
    
    
    
    func setupData(statusFrame:StatusFrame){
        
        if let repostCount = statusFrame.status.reposts_count{
            if repostCount > 0{
                self.setupBtn(self.retweetBtn, count:repostCount)
            }
        }
        
        if let commentCount = statusFrame.status.comments_count{
            if commentCount > 0{
                self.setupBtn(self.commentBtn, count:commentCount)
            }

        }
        
        if let attitudCount = statusFrame.status.attitudes_count{
            if attitudCount > 0{
               self.setupBtn(self.unlikeBtn, count:attitudCount)
            }
        }
    }
    
    
    func setupBtn(btn:UIButton,count:Int){
        var title = ""
        if (count < 10000) {
            title = String(count)
        } else {
            title = String(format: "%.1f万",Double(count) / 10000.0)
            title = title.stringByReplacingOccurrencesOfString(".0", withString: "")
        }
        btn.setTitle(title, forState: .Normal)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}





























