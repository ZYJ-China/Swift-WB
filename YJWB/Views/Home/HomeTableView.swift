//
//  HomeTableView.swift
//  YJWB
//
//  Created by  ZhouYingJie on 16/6/1.
//  Copyright © 2016年 ZhouYingJie. All rights reserved.
//



import UIKit
class HomeTableView: UITableView{
    typealias OffsetTable  = (offset:CGFloat) -> Void
    
    var dowTapTable:DownTap?
    var offsetTable:OffsetTable?
    lazy var statusData : [Status] = {
        let status = [Status]()
        return status
    }()
    
    let cellID = "statuIdentifier"
    
    deinit {
        self.delegate = nil
        self.dataSource = nil   
    }
    
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        self.separatorStyle = .None
        self.delegate = self
        self.dataSource = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //点击箭头
    func downTapTableBlock(block:DownTap){
        self.dowTapTable = block
    }
    
    func getOffsetY(block:OffsetTable){
        self.offsetTable = block
    }
}


extension HomeTableView:UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.statusData.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let statusCell = StatusCell.init(style: .Default, reuseIdentifier:cellID)
        statusCell.status = self.statusData[indexPath.row]
        
        //点击箭头
        statusCell.downTapCellBlock { (statusFrame, flag, link) in
            self.dowTapTable?(statusFrame:statusFrame,flag:flag,link:link)
        }
    
        
        return statusCell
    }
}


extension HomeTableView:UITableViewDelegate {
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let statusCell = StatusCell.init(style: .Default, reuseIdentifier: "identifier")
        return statusCell.cellHeight(self.statusData[indexPath.row])
    }
}


extension HomeTableView:UIScrollViewDelegate {
    func scrollViewDidScroll(scrollView: UIScrollView) {
        self.offsetTable?(offset:scrollView.contentOffset.y)
    }
}





