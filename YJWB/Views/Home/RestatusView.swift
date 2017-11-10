//
//  RestatusView.swift
//  YJWB
//
//  Created by  ZhouYingJie on 16/6/3.
//  Copyright © 2016年 ZhouYingJie. All rights reserved.
//



class RestatusView: UIView {
    var downTapReView:DownTap?
    //昵称
    var retweetNameBtn:UIButton!
    //转发正文
 var retweetContentLabel:MLEmojiLabel!
  lazy var statusFrame = StatusFrame()
    /** 转发微博配图 */
    var retweetPhotoView:PhotosView?
    var attText:NSMutableAttributedString!
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let retweetContentLabel = MLEmojiLabel()
        retweetContentLabel.numberOfLines = 0;
        retweetContentLabel.alpha = 0.8
        retweetContentLabel.font = sysFont(ContentFont)
        retweetContentLabel.isNeedAtAndPoundSign = true;
        self.addSubview(retweetContentLabel)
        self.retweetContentLabel = retweetContentLabel;

         //配图
        let retweetPhotoView = PhotosView()
        self.addSubview(retweetPhotoView)
        self.retweetPhotoView = retweetPhotoView;
        
    }
    
    func setStatusFrame(statusFrame:StatusFrame){
        self.statusFrame = statusFrame
        //正文
        if let content = statusFrame.status.reStatus.text{
            
            if let name = statusFrame.status.reStatus.user.screen_name{
                let allName = "@\(name):\(content)"
                retweetContentLabel.delegate = self
                self.retweetContentLabel.text = allName
                self.retweetContentLabel.frame = statusFrame.retweetContentLabelF!;
            }
        }
        
        // 配图
        if statusFrame.status.reStatus.pic_urls?.count > 0{
            self.retweetPhotoView!.hidden = false;
            let pics = statusFrame.status.reStatus.pic_urls as? [[String:String]]
            self.retweetPhotoView!.setupPhotos(pics!)
            self.retweetPhotoView!.frame = statusFrame.retweetPhotoViewF!;
        } else {
            self.retweetPhotoView!.hidden = true;
        }


    }
    
    func downTapReViewBlock(block:DownTap){
        self.downTapReView = block
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension RestatusView :MLEmojiLabelDelegate {
    
    func mlEmojiLabel(emojiLabel: MLEmojiLabel!, didSelectLink link: String!, withType type: MLEmojiLabelLinkType) {
        
            switch type {
            case MLEmojiLabelLinkType.URL:
              //  print("点击了链接%@",link);
                self.downTapReView?(statusFrame:self.statusFrame,flag:9,link:link)

            case MLEmojiLabelLinkType.PhoneNumber:
                print("点击了电话%@",link);
            case MLEmojiLabelLinkType.Email:
                print("点击了邮箱%@",link);
            case MLEmojiLabelLinkType.At:
               // print("点击了用户%@",link);
                self.downTapReView?(statusFrame:self.statusFrame,flag:10,link:link)
            case MLEmojiLabelLinkType.PoundSign:
                //print("点击了话题%@",link);
                self.downTapReView?(statusFrame:self.statusFrame,flag:11,link:link)
            default:
                print("点击了不知道啥%@",link);
                break;
        }
    }
}






