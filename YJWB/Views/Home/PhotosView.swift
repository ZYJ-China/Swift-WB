//
//  PhotosView.swift
//  YJWB
//
//  Created by  ZhouYingJie on 16/6/2.
//  Copyright © 2016年 ZhouYingJie. All rights reserved.
//

//((SCREEN_WIDTH - Padding - 44) - 30)/3
let PhotoW:CGFloat = ((SCREEN_WIDTH - 64) - 30)/3
let PhotoH:CGFloat = ((SCREEN_WIDTH - 64) - 30)/3
let PhotoMargin:CGFloat = 5

class PhotosView: UIView {
    var gifImageView :UIImageView!
    var photoView:UIImageView!
    var photos:[[String:String]]!
    override init(frame: CGRect) {
        super.init(frame: frame)
        // 初始化9个子控件
        for i in 0..<9 {
            photoView = UIImageView()
            photoView.tag = i; // tag
            photoView.userInteractionEnabled = true
            self.addSubview(photoView)
            photoView.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(PhotosView.photoTap(_:))))

            gifImageView = UIImageView.init(image: setImage("timeline_image_gif"))
            gifImageView.frame = setRect(PhotoW-27, y: PhotoW-20, w: 27, h: 20)
           // photoView.addSubview(gifImageView)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func photoTap(tap:UITapGestureRecognizer) {
       
        let index = tap.view?.tag
        let count = self.photos.count;
        // 1.封装图片数据1
        var tapPhotos = [MJPhoto]()
        
        for i in 0..<count {
            // 替换为中等尺寸图片
            let url = self.photos[i]["thumbnail_pic"]!
            let urlLarge = url.stringByReplacingOccurrencesOfString("thumbnail", withString: "large")
            let photo = MJPhoto()
            photo.url = NSURL.init(string: urlLarge)
            photo.srcImageView = self.subviews[i] as! UIImageView // 来源于哪个UIImageView
            tapPhotos.append(photo)
        }
        // 2.显示相册
        let browser = MJPhotoBrowser()
        browser.currentPhotoIndex =  UInt(index!) // 弹出相册时显示的第一张图片是？
        browser.photos = tapPhotos // 设置所有的图片
        browser.show()
    }
    
    
    func setupPhotos(photos:[[String:String]]) {
        self.photos = photos
        for index in 0..<self.subviews.count {
            let photoView = self.subviews[index] as! UIImageView
            
            if index < photos.count {
                photoView.hidden = false;
                let url = photos[index]["thumbnail_pic"]!
                var urlLarge:String!
                
                if (photos.count == 1) {
                    photoView.contentMode = .ScaleAspectFill
                    photoView.clipsToBounds = true
                    urlLarge = url.stringByReplacingOccurrencesOfString("thumbnail", withString: "large")
                    photoView.sd_setImageWithURL(NSURL.init(string: urlLarge), placeholderImage: setImage("timeline_image_placeholder"))
                } else {
                    photoView.contentMode = .ScaleAspectFill
                    photoView.clipsToBounds = true
                    
                    if url.hasSuffix(".gif"){
                        photoView.sd_setImageWithURL(NSURL.init(string: url), placeholderImage: setImage("timeline_image_placeholder"))
                        //self.gifImageView.hidden = false
                    }else{
                        urlLarge = url.stringByReplacingOccurrencesOfString("thumbnail", withString: "bmiddle")
                        photoView.sd_setImageWithURL(NSURL.init(string: urlLarge), placeholderImage: setImage("timeline_image_placeholder"))
                        //self.gifImageView.hidden = true
                    }

                }

                
                                // 设置frame
                let maxColumns:Int = (photos.count == 4) ? 2 : 3;
                let col:Int = index % maxColumns
                let row:Int = index / maxColumns
                let photoX:CGFloat =  CGFloat(col) * (PhotoW + PhotoMargin)
                let photoY:CGFloat = CGFloat(row) * (PhotoH + PhotoMargin)
                photoView.frame = CGRectMake(photoX, photoY, PhotoW, PhotoH)
                
               
            } else {
                photoView.hidden = false
            }
        }

    }
    
    // 根据图片个数返回photosView大小
    class func sizeWithPhotosCount(count:Int) -> CGSize{
        // 一行最多3列
        let maxColumns:Int = (count == 4) ? 2 : 3;
        
        // 总行数
        let rows:Int = (count + maxColumns - 1) / maxColumns;
        // 高度
        let photosH:CGFloat = CGFloat(rows) * PhotoH + (CGFloat(rows) - 1) * PhotoMargin;
        
        // 总列数
        let cols:Int = (count >= maxColumns) ? maxColumns : count;
        // 宽度
        let photosW:CGFloat = CGFloat(cols) * PhotoW + (CGFloat(cols) - 1) * PhotoMargin;
        
        return CGSizeMake(photosW, photosH);
    }
}
