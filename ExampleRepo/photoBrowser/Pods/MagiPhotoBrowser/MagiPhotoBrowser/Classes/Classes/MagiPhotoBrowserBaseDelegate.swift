//
//  MagiPhotoBrowserBaseDelegate.swift
//  MagiPhotoBrowser_Example
//
//  Created by anran on 2018/10/26.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation
import UIKit

open class MagiPhotoBrowserBaseDelegate: NSObject, MagiPhotoBrowserDelegate {
    
    /// 弱引用 PhotoBrowser
    public weak var browser: MagiPhotoBrowser?
    
    /// 图片内容缩张模式
    public var contentMode: UIView.ContentMode = .scaleAspectFill
    
    /// 长按回调。回传参数分别是：浏览器，图片序号，图片对象，手势对象
    public var longPressedCallback: ((MagiPhotoBrowser, Int, UIImage?, UILongPressGestureRecognizer) -> Void)?

    // MARK: - 处理状态栏
    
    /// 是否需要遮盖状态栏。默认true
    open var isNeedCoverStatusBar = true
    
    /// 保存原windowLevel
    public var originWindowLevel: UIWindow.Level?
    
    /// 遮盖状态栏。以改变windowLevel的方式遮盖
    /// - parameter cover: true-遮盖；false-不遮盖
    open func coverStatusBar(_ cover: Bool) {
        guard isNeedCoverStatusBar else {
            return
        }
        guard let window = browser?.view.window ?? UIApplication.shared.keyWindow else {
            return
        }
        if originWindowLevel == nil {
            originWindowLevel = window.windowLevel
        }
        guard let originLevel = originWindowLevel else {
            return
        }
        window.windowLevel = cover ? .statusBar : originLevel
    }

    // MARK: - UICollectionViewDelegate
    
    open func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let cell = cell as? MagiPhotoBrowserBaseCell else {
            return
        }
        cell.imageView.contentMode = contentMode
        // 绑定 Cell 回调事件
        // 单击
        cell.clickCallback = { _ in
            self.browser?.dismiss(animated: true, completion: nil)
        }
        // 拖
        cell.panChangedCallback = { scale in
            // 实测用scale的平方，效果比线性好些
            let alpha = scale * scale
            self.browser?.transDelegate.maskAlpha = alpha
            // 半透明时重现状态栏，否则遮盖状态栏
            self.coverStatusBar(scale > 0.95)
        }
        // 拖完松手
        cell.panReleasedCallback = { isDown in
            if isDown {
                self.browser?.dismiss(animated: true, completion: nil)
            } else {
                self.browser?.transDelegate.maskAlpha = 1.0
                self.coverStatusBar(true)
            }
        }
        // 长按
        weak var weakCell = cell
        cell.longPressedCallback = { gesture in
            if let browser = self.browser {
                self.longPressedCallback?(browser, indexPath.item, weakCell?.imageView.image, gesture)
            }
        }
    }
    
    /// scrollView滑动
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        browser?.pageIndex = Int(scrollView.contentOffset.x / scrollView.bounds.width)
    }
    
    /// 取当前显示页的内容视图。比如是 ImageView.
    public func displayingContentView(_ browser: MagiPhotoBrowser, pageIndex: Int) -> UIView? {
        let indexPath = IndexPath.init(item: pageIndex, section: 0)
        let cell = browser.collectionView.cellForItem(at: indexPath) as? MagiPhotoBrowserBaseCell
        return cell?.imageView
    }
    
    /// 取转场动画视图
    public func transitionZoomView(_ browser: MagiPhotoBrowser, pageIndex: Int) -> UIView? {
        let indexPath = IndexPath.init(item: pageIndex, section: 0)
        let cell = browser.collectionView.cellForItem(at: indexPath) as? MagiPhotoBrowserBaseCell
        return UIImageView(image: cell?.imageView.image)
    }
    
    public func photoBrowser(_ browser: MagiPhotoBrowser, pageIndexDidChanged pageIndex: Int) {
        // Empty.
    }
    
    public func photoBrowserViewDidLoad(_ browser: MagiPhotoBrowser) {
        // Empty.
    }
    
    public func photoBrowser(_ browser: MagiPhotoBrowser, viewWillAppear animated: Bool) {
        // 遮盖状态栏
        coverStatusBar(true)
    }
    
    public func photoBrowserViewWillLayoutSubviews(_ browser: MagiPhotoBrowser) {
        // Empty.
    }
    
    public func photoBrowserViewDidLayoutSubviews(_ browser: MagiPhotoBrowser) {
        // Empty.
    }
    
    public func photoBrowser(_ browser: MagiPhotoBrowser, viewDidAppear animated: Bool) {
        // Empty.
    }
    
    public func photoBrowser(_ browser: MagiPhotoBrowser, viewWillDisappear animated: Bool) {
        // 还原状态栏
        coverStatusBar(false)
    }
    
    public func photoBrowser(_ browser: MagiPhotoBrowser, viewDidDisappear animated: Bool) {
        // Empty.
    }
}
