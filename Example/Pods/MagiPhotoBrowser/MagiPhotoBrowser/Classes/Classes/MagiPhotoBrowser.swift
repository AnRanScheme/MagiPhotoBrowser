//
//  MagiPhotoBrowser.swift
//  MagiPhotoBrowser_Example
//
//  Created by anran on 2018/10/26.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit

open class MagiPhotoBrowser: UIViewController {

    // MARK: - Public Properties
    /// 表示了当前显示图片的序号，从0开始计数
    open var pageIndex: Int = 0 {
        didSet {
            if pageIndex != oldValue {
                delegate.photoBrowser(self, pageIndexDidChanged: pageIndex)
            }
        }
    }
    
    /// 左右两张图之间的间隙
    open var photoSpacing: CGFloat = 30
    
    /// CollectionView 数据源
    open var dataSource: MagiPhotoBrowserDataSource
    
    /// CollectionView 代理
    open var delegate: MagiPhotoBrowserDelegate
    
    /// 转场动画代理
    open var transDelegate: MagiPhotoBrowserTransitioningDelegate {
        didSet {
            self.transitioningDelegate = transDelegate
        }
    }
    
    /// 是否处于Peek状态
    open var isPreviewing = false
    
    /// 流型布局
    public lazy var flowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        return layout
    }()
    
    /// 容器
    public lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = UIColor.clear
        collectionView.decelerationRate = UIScrollView.DecelerationRate.fast
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.alwaysBounceVertical = false
        return collectionView
    }()

    // MARK: - Life Cycle

    #if DEBUG
    /// 销毁
    deinit {
        print("deinit:\(self)")
    }
    #endif
    
    /// 初始化
    /// - parameter dataSource: 数据源
    /// - parameter delegate: 视图代理
    /// - parameter transDelegate: 转场动画代理
    public init(dataSource: MagiPhotoBrowserDataSource,
                delegate: MagiPhotoBrowserDelegate = MagiPhotoBrowserBaseDelegate(),
                transDelegate: MagiPhotoBrowserTransitioningDelegate = MagiPhotoBrowserFadeTransitioning()) {
        self.dataSource = dataSource
        self.delegate = delegate
        self.transDelegate = transDelegate
        
        super.init(nibName: nil, bundle: nil)
        self.modalPresentationStyle = .custom
        self.transitioningDelegate = transDelegate
        
        dataSource.browser = self
        delegate.browser = self
        transDelegate.browser = self
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// 打开浏览器
    open func show(pageIndex: Int) {
        self.pageIndex = pageIndex
        UIViewController.magiPhotoBrowser.topMost?.present(self, animated: true, completion: nil)
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(collectionView)
        if #available(iOS 11.0, *) {
            collectionView.contentInsetAdjustmentBehavior = .never
        }
        
        collectionView.delegate = delegate
        collectionView.dataSource = dataSource
        dataSource.registerCell(for: collectionView)
        
        layout()
        collectionView.reloadData()
        scrollToItem(pageIndex, at: .left, animated: false)
        collectionView.layoutIfNeeded()
        delegate.photoBrowserViewDidLoad(self)
    }
    
    private func layout() {
        flowLayout.minimumLineSpacing = photoSpacing
        flowLayout.itemSize = view.bounds.size
        collectionView.frame = view.bounds
        collectionView.frame.size.width = view.bounds.width + photoSpacing
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: photoSpacing)
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        delegate.photoBrowser(self, viewWillAppear: animated)
    }
    
    open override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        delegate.photoBrowserViewWillLayoutSubviews(self)
    }
    
    open override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        layout()
        delegate.photoBrowserViewDidLayoutSubviews(self)
    }
    
    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        delegate.photoBrowser(self, viewDidAppear: animated)
    }
    
    open override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        delegate.photoBrowser(self, viewWillDisappear: animated)
    }
    
    open override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        delegate.photoBrowser(self, viewDidDisappear: animated)
    }
    
    /// 支持旋转
    open override var shouldAutorotate: Bool {
        return true
    }
    
    /// 支持旋转的方向
    open override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .all
    }
    
    /// 屏幕即将旋转回调
    open override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        // 记录旋转前index
        let index = pageIndex
        DispatchQueue.main.asyncAfter(deadline: .now() + coordinator.transitionDuration, execute: {
            self.scrollToItem(index, at: .left, animated: false)
        })
    }
    
    /// 滑到哪张图片
    /// - parameter index: 图片序号，从0开始
    open func scrollToItem(_ index: Int, at position: UICollectionView.ScrollPosition, animated: Bool) {
        pageIndex = index
        let indexPath = IndexPath(item: index, section: 0)
        collectionView.scrollToItem(at: indexPath, at: position, animated: animated)
    }
    
    /// 取当前显示页的内容视图。比如是 ImageView.
    public var displayingContentView: UIView? {
        return delegate.displayingContentView(self, pageIndex: pageIndex)
    }
    
    /// 取转场动画视图
    public var transitionZoomView: UIView? {
        return delegate.transitionZoomView(self, pageIndex: pageIndex)
    }

}
