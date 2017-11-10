//
//  InfoTableView.swift
//  YJWB
//
//  Created by  ZhouYingJie on 16/6/7.
//  Copyright © 2016年 ZhouYingJie. All rights reserved.
//

import UIKit

class InfoTableView: UITableView {

    typealias InfoTableOffset = (offsetY:CGFloat) -> Void
    var infoTableOffet:InfoTableOffset?
    let cellID = "statuIdentifier1"
    
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        self.separatorStyle = .None
        self.delegate = self
        self.dataSource = self
       // self.registerClass(<#T##cellClass: AnyClass?##AnyClass?#>, forCellReuseIdentifier: <#T##String#>)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func infoTableOffsetBlock(block:InfoTableOffset){
        self.infoTableOffet = block
    }

}
extension InfoTableView:UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor.greenColor()
        return view
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
       let cell = UITableViewCell()
        cell.textLabel?.text = "Info\(indexPath)"
        return cell
    }
}


extension InfoTableView:UITableViewDelegate {
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
}

extension InfoTableView:UIScrollViewDelegate {

    func scrollViewDidScroll(scrollView: UIScrollView) {
        self.infoTableOffet?(offsetY:scrollView.contentOffset.y)
    }
}

