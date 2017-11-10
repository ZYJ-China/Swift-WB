//
//  StatusFrame.swift
//  YJWB
//
//  Created by  ZhouYingJie on 16/6/1.
//  Copyright © 2016年 ZhouYingJie. All rights reserved.
//
// 间距
let Padding:CGFloat = 10.0
// 昵称字体
let NameFont:CGFloat = 14.0
// 时间字体
let TimeFont:CGFloat = 10.0
// 来源字体
let SourceFont:CGFloat = 10.0
// 正文字体
let ContentFont:CGFloat = 14.0

struct StatusFrame {
    //父控件
   var originalViewF:CGRect!
    //头像
   var iconViewF:CGRect!
    //昵称
   var nameBtnF:CGRect!
    //时间
   var timeLabelF:CGRect!
    //来源
   var sourceLabelF:CGRect!
    //正文
   var contentLabelF:CGRect!
    //配图
   var photoViewF:CGRect!
    
    //向下箭头
    var downViewF:CGRect!
    
    //转发父控件
   var retweetViewF:CGRect?
    //转发昵称
   var retweetNameBtnF:CGRect?
    //转发正文
   var retweetContentLabelF:CGRect?
    //转发配图
   var retweetPhotoViewF:CGRect?
    
    //工具条父控件
   var statusToolBarF:CGRect!
    
    var status:Status!
    mutating func setStatusFrame(status:Status) {
        let user = status.user
        self.status = status
        
        let cellW :CGFloat = SCREEN_WIDTH - Padding //宽度
        
        //原创微博父控件
        let originalW:CGFloat = cellW   //宽
        var originalH:CGFloat = 0       //高
        let originalX:CGFloat = 0
        let originalY:CGFloat = 10
        
        //头像
        let iconXY:CGFloat = Padding;
        let iconWH:CGFloat = 34;
        iconViewF = CGRect.init(x: iconXY, y: iconXY, width: iconWH, height: iconWH)
        
        //昵称
        let nameX:CGFloat = CGRectGetMaxX(iconViewF!) + Padding;
        let nameY:CGFloat = iconXY;
        let nameSize:CGRect = sizeWithFont(user.screen_name!, font: sysFont(NameFont), size: CGSizeMake(SCREEN_WIDTH, 20))
        
        nameBtnF = setRect(nameX, y: nameY, w: nameSize.width, h: nameSize.height)
        //时间
        let timeArray = status.created_at.componentsSeparatedByString(" ")
        let dateStr = timeArray[3]
        let dateArray = dateStr.componentsSeparatedByString(":")
        let timeStr = "\(dateArray[0]):\(dateArray[1])"        
        let timeX:CGFloat = nameX;
        let timeY :CGFloat = CGRectGetMaxY(nameBtnF!) + Padding * 0.5;
        let timeSize:CGRect = sizeWithFont(timeStr, font: sysFont(TimeFont), size: CGSizeMake(SCREEN_WIDTH, 20))
        timeLabelF = setRect(timeX, y: timeY, w: timeSize.width, h: timeSize.height)
        
        //来源
        if let source = status.source{
            let sourceX:CGFloat = CGRectGetMaxX(timeLabelF) + Padding;
            let sourceY = timeY;
            let sourceSize:CGRect = sizeWithFont(source, font: sysFont(SourceFont), size: CGSizeMake(SCREEN_WIDTH, 20))
            sourceLabelF = setRect(sourceX, y: sourceY, w: sourceSize.width, h: sourceSize.height)
        }
        
        
        //正文
        if let contentText = status.text {
            let contentX:CGFloat = nameX;
            let contentY:CGFloat = CGRectGetMaxY(iconViewF) + Padding;
            let contentMaxW:CGFloat = cellW - nameX;
            let contentSize = sizeWithFont(contentText, font: sysFont(ContentFont), size: CGSizeMake(contentMaxW, CGFloat(MAXFLOAT)))
            contentLabelF = setRect(contentX, y: contentY, w: contentSize.width, h: contentSize.height)
            
            originalH = CGRectGetMaxY(contentLabelF);
            originalViewF = setRect(originalX, y: originalY, w: originalW, h: originalH)
        }
        
        //配图
        if status.pic_urls?.count > 0 {
            let photoX:CGFloat = nameX;
            let photoY:CGFloat = CGRectGetMaxY(contentLabelF) + Padding
            let photoSize = PhotosView.sizeWithPhotosCount((status.pic_urls?.count)!)
            photoViewF = setRect(photoX, y: photoY, w: photoSize.width, h: photoSize.height)
            originalH  = CGRectGetMaxY(photoViewF);
            originalViewF = setRect(originalX, y: originalY, w: originalW, h: originalH)
        }
        
        //箭头
        let downX = SCREEN_WIDTH - Padding*3
        let downY = Padding * 1.5
        let downWH:CGFloat = Padding*1.5
        downViewF = setRect(downX, y: downY, w: downWH, h: downWH)
        
        
        
        //转发
        //父控件
        let retweetX:CGFloat = nameX-Padding
        let retweetY:CGFloat = CGRectGetMaxY(originalViewF)
        let retweetW:CGFloat = cellW - nameX        //宽
        var retweetH:CGFloat = 0
        //高
        let retNameX:CGFloat = Padding;
        var retNameY:CGFloat = 0
        
        if (status.reStatus.user.screen_name != nil) {
            
            if status.reStatus.user.screen_name != nil {
                //昵称
                retNameY = Padding
                let name = "@\(status.reStatus.user.screen_name!)"
                let retNameSize:CGRect = sizeWithFont(name, font: sysFont(NameFont), size: CGSizeMake(SCREEN_WIDTH, CGFloat(MAXFLOAT)))
                retweetNameBtnF = setRect(retNameX, y: retNameY, w: retNameSize.width, h: retNameSize.height)
                retweetH = CGRectGetMaxY(retweetNameBtnF!)+Padding

            }else{
                retweetNameBtnF = setRect(retNameX, y: retNameY, w: 0, h: retweetH)
                retweetH = CGRectGetMaxY(retweetNameBtnF!)
            }
            
            if status.reStatus.text != nil{
                //正文+昵称
                var contentStr = ""
                let retContentX:CGFloat = retNameX;
                let retContentY:CGFloat = Padding
                let retContentMaxW:CGFloat = retweetW - 2 * Padding;
                
                if status.reStatus.user.screen_name != nil{
                    contentStr = "@\(status.reStatus.user.screen_name!):\(status.reStatus.text!)"
                }else{
                    contentStr = status.reStatus.text!
                }
                
                let retContentSize:CGRect = sizeWithFont(contentStr, font: sysFont(ContentFont), size:CGSizeMake(retContentMaxW,CGFloat(MAXFLOAT)))
                retweetContentLabelF = setRect(retContentX, y: retContentY, w: retContentSize.width, h: retContentSize.height)
                retweetH = CGRectGetMaxY(retweetContentLabelF!) + Padding;
              
            }else{
                retweetContentLabelF = setRect(retNameX, y: retNameY, w: 0, h: retweetH)
                retweetH = CGRectGetMaxY(retweetContentLabelF!)
            }
            
            if status.reStatus.pic_urls?.count > 0{
                let photoX:CGFloat = Padding;
                let photoY:CGFloat = CGRectGetMaxY(retweetContentLabelF!) + Padding
                let photoSize = PhotosView.sizeWithPhotosCount((status.reStatus.pic_urls?.count)!)
                retweetPhotoViewF = setRect(photoX, y: photoY, w: photoSize.width, h: photoSize.height)
                retweetH = CGRectGetMaxY(retweetPhotoViewF!) + Padding
            }else{
                retweetPhotoViewF = setRect(0, y: 0, w: 0, h: retweetH)
                retweetH = CGRectGetMaxY(retweetPhotoViewF!)
            }
        }

        retweetViewF = setRect(retweetX, y: retweetY, w: retweetW, h: retweetH)
        
        let toolX:CGFloat = originalX;
        let toolY:CGFloat = CGRectGetMaxY(retweetViewF!)+Padding
        let toolW:CGFloat = originalW;
        let toolH:CGFloat = 35;
        statusToolBarF = CGRectMake(toolX, toolY, toolW, toolH);
        
        
        originalH = CGRectGetMaxY(statusToolBarF!)
        originalViewF = setRect(originalX, y: originalY, w: originalW, h: originalH+10)
    }
}












