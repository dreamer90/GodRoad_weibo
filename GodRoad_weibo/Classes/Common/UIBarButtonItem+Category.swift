//
//  UIBarButtonItem+Category.swift
//  GodRoad_weibo
//
//  Created by hyfsoft on 16/7/8.
//  Copyright © 2016年 李太白. All rights reserved.
//

import UIKit

extension UIBarButtonItem{

    //func 前加class相当于OC的＋
    class func creatBarButtonItem(imageName:String, target:AnyObject, action:Selector)->UIBarButtonItem {
        let btn = UIButton()
        btn.setImage(UIImage(named: imageName), forState: UIControlState.Normal)
        btn.setImage(UIImage(named: imageName + "_highlighted"), forState: UIControlState.Highlighted)
        btn.addTarget(self, action: action, forControlEvents: UIControlEvents.TouchUpInside)
        btn.sizeToFit()
        return UIBarButtonItem(customView: btn)
    }
    
    
}