//
//  MagiNetworkingDataSource.swift
//  MagiPhotoBrowser_Example
//
//  Created by anran on 2018/10/26.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation
import UIKit

public class MagiNetworkingDataSource: NSObject, MagiPhotoBrowserDataSource {
    
    /// 弱引用 PhotoBrowser
    public weak var browser: MagiPhotoBrowser?
    
    /// 图片加载器
    public var photoLoader: MagiPhotoLoader
    
    /// 共有多少项
    public var numberOfItemsCallback: () -> Int
    
    /// 一级资源，本地图片
    public var localImageCallback: (Int) -> UIImage?
    
    /// 二级资源，自动加载的网络图片
    public var autoloadURLStringCallback: (Int) -> String?
    
    public init(photoLoader: MagiPhotoLoader,
                numberOfItems: @escaping () -> Int,
                localImage: @escaping (Int) -> UIImage?,
                autoloadURLString: @escaping (Int) -> String?) {
        self.photoLoader = photoLoader
        self.numberOfItemsCallback = numberOfItems
        self.localImageCallback = localImage
        self.autoloadURLStringCallback = autoloadURLString
    }
    
    //
    // MARK: - UICollectionViewDataSource
    //
    
    public func registerCell(for collectionView: UICollectionView) {
        collectionView.magiPhotoBrowser.registerCell(MagiPhotoBrowserNetworkingCell.self)
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfItemsCallback()
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.magiPhotoBrowser.dequeueReusableCell(MagiPhotoBrowserNetworkingCell.self, for: indexPath)
        // 一级资源
        let localImage = localImageCallback(indexPath.item)
        // 二级资源
        let autoloadURLString = autoloadURLStringCallback(indexPath.item)
        // 刷新数据
        cell.reloadData(photoLoader: photoLoader, localImage: localImage, autoloadURLString: autoloadURLString)
        return cell
    }
}

