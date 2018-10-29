//
//  MagiPhotoBrowserZoomAnimator.swift
//  MagiPhotoBrowser_Example
//
//  Created by anran on 2018/10/26.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation
import UIKit

/// Zoom动画命名空间
public class MagiPhotoBrowserZoomAnimator: NSObject {
    /// 转场时做动画效果的视图
    public var zoomView: () -> UIView?
    
    /// 动画开始位置
    public var startFrame: (_ transContainer: UIView) -> CGRect?
    
    /// 动画结束位置
    public var endFrame: (_ transContainer: UIView) -> CGRect?
    
    /// 初始化，三个回调中，只要有一个返回nil值，就无法执行zoom动画，将转为执行Fade动画。
    public init(zoomView: @escaping () -> UIView?,
                startFrame: @escaping (_ superView: UIView) -> CGRect?,
                endFrame: @escaping (_ superView: UIView) -> CGRect?) {
        self.zoomView = zoomView
        self.startFrame = startFrame
        self.endFrame = endFrame
    }
    
}

