//
//  NetworkingImageViewController.swift
//  MagiPhotoBrowser_Example
//
//  Created by anran on 2018/10/26.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit
import MagiPhotoBrowser

class NetworkingImageViewController: BaseCollectionViewController {
    
    override var name: String {
        return "网络图片-两级：缩略图和高清图"
    }
    
    override func makeDataSource() -> [ResourceModel] {
        var result: [ResourceModel] = []
        guard let url = Bundle.main.url(forResource: "Photos", withExtension: "plist") else {
            return result
        }
        guard let data = try? Data.init(contentsOf: url) else {
            return result
        }
        let decoder = PropertyListDecoder()
        guard let array = try? decoder.decode([[String]].self, from: data) else {
            return result
        }
        array.forEach { item in
            let model = ResourceModel()
            model.firstLevelUrl = item[0]
            model.secondLevelUrl = item[1]
            result.append(model)
        }
        return result
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.magiPhotoBrowser.dequeueReusableCell(BaseCollectionViewCell.self, for: indexPath)
        // 加载一级资源
        if let firstLevel = self.dataSource[indexPath.item].firstLevelUrl {
            let url = URL(string: firstLevel)
            cell.imageView.kf.setImage(with: url)
        } else {
            cell.imageView.kf.setImage(with: nil)
        }
        return cell
    }
    
    override func openPhotoBrowser(with collectionView: UICollectionView, indexPath: IndexPath) {
        // 网图加载器
        let loader = MagiKingfisherLoader()
        // 数据源
        let dataSource = MagiNetworkingDataSource(photoLoader: loader, numberOfItems: { () -> Int in
            return self.dataSource.count
        }, localImage: { index -> UIImage? in
            let cell = collectionView.cellForItem(at: indexPath) as? BaseCollectionViewCell
            return cell?.imageView.image
        }) { index -> String? in
            return self.dataSource[index].secondLevelUrl
        }
        // 视图代理，实现了光点型页码指示器
        let delegate = MagiDefaultPageControlDelegate()
        // 转场动画
        let trans = MagiPhotoBrowserZoomTransitioning { (browser, index, view) -> UIView? in
            let indexPath = IndexPath(item: index, section: 0)
            return collectionView.cellForItem(at: indexPath)
        }
        // 打开浏览器
        MagiPhotoBrowser(dataSource: dataSource, delegate: delegate, transDelegate: trans)
            .show(pageIndex: indexPath.item)
    }
}

