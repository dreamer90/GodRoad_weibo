//
//  AppDelegate.swift
//  GodRoad_weibo
//
//  Created by 李太白 on 16/6/28.
//  Copyright © 2016年 李太白. All rights reserved.
//

import UIKit

// 切换控制器通知
let XMGSwitchRootViewControllerKey = "XMGSwitchRootViewControllerKey"

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        //注册一个通知
        NSNotificationCenter.defaultCenter() .addObserver(self, selector: #selector(AppDelegate.switchRootViewController(_:)), name: "XMGSwitchRootViewControllerKey", object: nil)
        
        // 设置导航条和工具条全局外观
        UINavigationBar.appearance().tintColor = UIColor.orangeColor()
        UITabBar.appearance().tintColor = UIColor.orangeColor()
        
        //创建window
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        window?.makeKeyAndVisible()
        window?.rootViewController = defaultContoller()
        
        return true
    }
    
    deinit{
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    func switchRootViewController(notify:NSNotification){
        if notify.object as! Bool{
            window?.rootViewController = MainTabBarViewController()
        }else{
            window?.rootViewController = WelcomeViewController()
        }
    }

    /**
     用于获取默认界面
     
     :returns: 默认界面
     */
    private func defaultContoller() ->UIViewController
    {
        // 1.检测用户是否登录
        if UserAccount.userLogin(){
            return isNewupdate() ? NewfeatureCollectionViewController() : WelcomeViewController()
        }
        return MainTabBarViewController()
    }
    
    private func isNewupdate() -> Bool{
        // 1.获取当前软件的版本号 --> info.plist
        let currentVersion = NSBundle.mainBundle().infoDictionary!["CFBundleShortVersionString"] as! String
        
        // 2.获取以前的软件版本号 --> 从本地文件中读取(以前自己存储的)
        let sandboxVersion =  NSUserDefaults.standardUserDefaults().objectForKey("CFBundleShortVersionString") as? String ?? ""
        print("current = \(currentVersion) sandbox = \(sandboxVersion)")
        
        // 3.比较当前版本号和以前版本号
        //   2.0                    1.0
        if currentVersion.compare(sandboxVersion) == NSComparisonResult.OrderedDescending
        {
            // 3.1.1存储当前最新的版本号
            NSUserDefaults.standardUserDefaults().setObject(currentVersion, forKey: "CFBundleShortVersionString")
            return true
        }
        
        return false
    }

    
}

