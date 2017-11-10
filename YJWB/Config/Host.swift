//
//  Host.swift
//  微博
//
//  Created by  ZhouYingJie on 16/5/31.
//  Copyright © 2016年 ZhouYingJie. All rights reserved.
//

let mainHost  =  "https://api.weibo.com/"

//oauth2授权
let oauth = mainHost + "oauth2/authorize"
//获取token
let accessToken = mainHost + "oauth2/access_token"
//用户信息
let userInfo = "https://api.weibo.com/2/users/show.json"

//首页微博接口
let pulic = "https://api.weibo.com/2/statuses/public_timeline.json"
//自己关注的
let home_timeline = "https://api.weibo.com/2/statuses/home_timeline.json"
//表情
let emotion = "https://api.weibo.com/2/emotions.json"