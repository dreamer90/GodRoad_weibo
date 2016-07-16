//
//  StatusNormalTableViewCell.swift
//  GodRoad_weibo
//
//  Created by hyfsoft on 16/7/16.
//  Copyright © 2016年 李太白. All rights reserved.
//

import UIKit

class StatusNormalTableViewCell: StatusTableViewCell {
    
    
    override func setupUI() {
        super.setupUI()
        
        let cons = pictureView.xmg_AlignVertical(type: XMG_AlignType.BottomLeft, referView: contentLabel, size: CGSizeZero, offset: CGPoint(x: 0, y: 10))
        
        pictureWidthCons = pictureView.xmg_Constraint(cons, attribute: NSLayoutAttribute.Width)
        pictureHeightCons =  pictureView.xmg_Constraint(cons, attribute: NSLayoutAttribute.Height)
        
    }
}
