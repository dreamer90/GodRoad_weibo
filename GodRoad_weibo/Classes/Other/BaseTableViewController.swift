//
//  BaseTableViewController.swift
//  GodRoad_weibo
//
//  Created by hyfsoft on 16/6/29.
//  Copyright © 2016年 李太白. All rights reserved.
//

import UIKit

class BaseTableViewController: UITableViewController,VisitorViewDelegate
    {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
 
    // 判断用户是否登陆
    var userLogin = UserAccount.userLogin()
    // 定义属性保存未登录界面
    var visitorView:VisitorView?
    
    override func loadView() {
        
        userLogin ? super.loadView() : setupVisitorView()
    }
    
    // MARK: - 内部控制方法
    /**
     创建未登录界面
     */
    func setupVisitorView()
    {
        // 1.初始化登陆页面
        let customView = VisitorView()
        customView.delegate = self
        view = customView
        visitorView = customView
        
        // 2.设置导航栏未登录按钮
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "注册", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(VisitorViewDelegate.loginBtnWillClick))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "登陆", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(VisitorViewDelegate.registerBtnWillClick))
    }
    
    func loginBtnWillClick() {
        // 1.弹出登陆界面
        // 1.弹出登录界面
        let oauthVC = OAuthViewController()
        let nav = UINavigationController(rootViewController: oauthVC)
        presentViewController(nav, animated: true, completion: nil)
    }

    
    func registerBtnWillClick() {
        
    }

}
