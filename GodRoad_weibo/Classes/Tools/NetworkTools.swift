//
//  NetworkTools.swift
//  GodRoad_weibo
//
//  Created by 李太白 on 16/7/2.
//  Copyright © 2016年 李太白. All rights reserved.
//

import UIKit

class NetworkTools: AFHTTPSessionManager {

    static let tools :NetworkTools = {
        //注意baseurl一定以／结尾
        let url = NSURL(string: "https://api.weibo.com/")
        let t  = NetworkTools(baseURL: url)
        
        //设置AFN能够接受的数据类型
        t.responseSerializer.acceptableContentTypes = NSSet(objects: "application/json", "text/json", "text/javascript", "text/plain") as? Set<String>
        return t
    }()
    
    // 获取单例
    class func shareNetworkTools() ->NetworkTools{
        return tools
    }
}
