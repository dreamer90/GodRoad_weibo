//
//  EssenceTableViewController.swift
//  GodRoad_weibo
//
//  Created by hyfsoft on 16/6/29.
//  Copyright © 2016年 李太白. All rights reserved.
//

import UIKit

class EssenceTableViewController: BaseTableViewController {

    /// 保存微博数组
    var statuses: [Status]?
        {
        didSet{
            // 当别人设置完毕数据, 就刷新表格
            tableView.reloadData()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.whiteColor()
        // 1.如果没有登录, 就设置未登录界面的信息
        if !userLogin{
        
            visitorView?.setupVisitorInfo(true, imageName: "visitordiscover_feed_image_house", message: "关注一些人，回这里看看有什么惊喜")
            return
        }
        
        // 2.初始化导航条
        setupNav()
        
        // 3.添加下拉刷新控件

        
        // 4.加载数据
        loadData()
    }

    /**
     初始化导航条
     */
    private func setupNav(){
        // 1.初始化左右按钮
        navigationItem.leftBarButtonItem = UIBarButtonItem.creatBarButtonItem("navigationbar_friendattention", target: self, action: #selector(EssenceTableViewController.leftItemClick))
        navigationItem.rightBarButtonItem = UIBarButtonItem.creatBarButtonItem("navigationbar_pop", target: self, action: #selector(EssenceTableViewController.rightItemClick))
        
        // 2.初始化标题按钮
        let titleBtn = TitleButton()
        titleBtn.setTitle("凯撒大帝", forState: UIControlState.Normal)
        titleBtn.addTarget(self, action: #selector(EssenceTableViewController.titleBtnClick(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        navigationItem.titleView = titleBtn
    }
    
    func titleBtnClick(btn: TitleButton)
    {
        // 2.弹出菜单
        let sb = UIStoryboard(name: "PopoverViewController", bundle: nil)
        let vc = sb.instantiateInitialViewController()
        // 2.1设置专场动画
        vc?.transitioningDelegate = popverAnimator
        // 2.2设置转场样式
        vc?.modalPresentationStyle = UIModalPresentationStyle.Custom
        
        presentViewController(vc!, animated: true, completion: nil)
    }
    
    func leftItemClick()
    {
        print(#function)
    }
    
    func rightItemClick()
    {
        print(#function)
    }
    
    /// 定义变量记录当前是上拉还是下拉
    var pullupRefreshFlag = false
    /**
     获取微博数据
     如果想调用一个私有的方法:
     1.去掉private
     2.@objc, 当做OC方法来处理
     */
     @objc private func loadData(){
        
        // 1.默认当做下拉处理
        var since_id = statuses?.first?.id ?? 0
        
        var max_id = 0
        // 2.判断是否是上拉
        if pullupRefreshFlag
        {
            since_id = 0
            max_id = statuses?.last?.id ?? 0
        }
        
        Status.loadStatuses(since_id, max_id: max_id) { (models, error) -> () in
            
            // 接收刷新
            self.refreshControl?.endRefreshing()
            
            if error != nil
            {
                return
            }
            // 下拉刷新
            if since_id > 0
            {
                // 如果是下拉刷新, 就将获取到的数据, 拼接在原有数据的前面
                self.statuses = models! + self.statuses!
                
                // 显示刷新提醒
//                self.showNewStatusCount(models?.count ?? 0)
            }else if max_id > 0
            {
                // 如果是上拉加载更多, 就将获取到的数据, 拼接在原有数据的后面
                self.statuses = self.statuses! + models!
            }
            else
            {
                self.statuses = models
            }
        }
    }
    
    // MARK: - 懒加载
    // 一定要定义一个属性来报错自定义转场对象, 否则会报错
    private lazy var popverAnimator:PopoverAnimator = {
        let pa = PopoverAnimator()
        pa.presentFrame = CGRect(x: 100, y: 56, width: 200, height: 350)
        return pa
    }()
    
    /// 刷新提醒控件
    private lazy var newStatusLabel: UILabel =
        {
            let label = UILabel()
            let height: CGFloat = 44
            
            label.frame =  CGRect(x: 0, y: 0, width: UIScreen.mainScreen().bounds.width, height: height)
            
            label.backgroundColor = UIColor.orangeColor()
            label.textColor = UIColor.whiteColor()
            label.textAlignment = NSTextAlignment.Center
            
            // 加载 navBar 上面，不会随着 tableView 一起滚动
            self.navigationController?.navigationBar.insertSubview(label, atIndex: 0)
            
            label.hidden = true
            return label
    }()
    
    /// 微博行高的缓存, 利用字典作为容器. key就是微博的id, 值就是对应微博的行高
    var rowCache: [Int: CGFloat] = [Int: CGFloat]()
    
    override func didReceiveMemoryWarning() {
        // 清空缓存
        rowCache.removeAll()
    }
}

extension EssenceTableViewController
{
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return statuses?.count ?? 0
    }
    
    // 返回行高
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        // 1.取出对应行的模型
        let status = statuses![indexPath.row]
        
        // 2.判断缓存中有没有
        if let height = rowCache[status.id]
        {
            return height
        }
        
        // 3.拿到cell
        let cell = tableView.dequeueReusableCellWithIdentifier(StatusTableViewCellIdentifier.cellID(status)) as! StatusTableViewCell
        
        // 4.拿到对应行的行高
        let rowHeight = cell.rowHeight(status)
        
        // 5.缓存行高
        rowCache[status.id] = rowHeight
        
        // 6.返回行高
        return rowHeight
    }
}




