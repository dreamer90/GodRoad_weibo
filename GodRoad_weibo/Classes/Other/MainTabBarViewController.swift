//
//  MainTabBarViewController.swift
//  GodRoad_weibo
//
//  Created by hyfsoft on 16/6/29.
//  Copyright © 2016年 李太白. All rights reserved.
//

import UIKit

class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // 设置当前控制器对应tabBar的颜色
        tabBar.tintColor = UIColor.orangeColor()
        //加载子控件
        addChildViewControllers()
    }
    
    override func viewWillAppear(animated: Bool) {
        // 1.添加加号按钮
        setupComposeBtn()
        
        // 2.调整加号按钮的位置
        let width = UIScreen.mainScreen().bounds.size.width/CGFloat(viewControllers!.count)
        let rect  = CGRect(x: 0, y: 0, width: width, height: 49)
        // 第一个参数:是frame的大小
        // 第二个参数:是x方向偏移的大小
        // 第三个参数: 是y方向偏移的大小
        composeBtn.frame = CGRectOffset(rect, 2 * width, 0);
    }
    
    // MARK: - 内部控制方法
    private func setupComposeBtn()
    {
        tabBar.addSubview(composeBtn)
    }
    
    func addChildViewControllers(){
        
        //添加控制器
        addChildVC(EssenceTableViewController(), title: "精华", imageName: "tabbar_home")
        addChildVC(DiscoverTableViewController(), title: "发现", imageName: "tabbar_message_center")
        addChildVC(AddArticleViewController(), title: "", imageName: "")
        addChildVC(InfomationTableViewController(), title: "消息", imageName: "tabbar_discover")
        addChildVC(MyTableViewController(), title: "我的", imageName: "tabbar_profile")

    }
    
    func addChildVC(vc:UIViewController, title:String,imageName:String){
        
        //设置对应的数据
        vc.title = title;
        vc.tabBarItem.image = UIImage(named: imageName)
        vc.tabBarItem.selectedImage = UIImage(named: imageName + "_highlighted")
        //包装导航控制器
        let nav = UINavigationController()
        nav.addChildViewController(vc)
        //将导航控制器添加到当前控制器
        addChildViewController(nav)
    }

    // MARK: - 懒加载
    private lazy var composeBtn:UIButton = {
        
        let btn = UIButton()
        
        //设置前景图片
        btn.setImage(UIImage(named:"tabbar_compose_icon_add"), forState: UIControlState.Normal)
        btn.setImage(UIImage(named:"tabbar_compose_icon_add_highlighted"), forState: UIControlState.Highlighted)
        //设置背景图片
        btn.setBackgroundImage(UIImage(named:"tabbar_compose_button"), forState: UIControlState.Normal)
    btn.setBackgroundImage(UIImage(named:"tabbar_compose_button_highlighted"), forState: UIControlState.Highlighted)
        
        btn.addTarget(self, action: #selector(MainTabBarViewController.composeBtnClick), forControlEvents: UIControlEvents.TouchUpInside)
        
        return btn
    }()
    
    func composeBtnClick(){
    
    }
}

