//
//  LocalNumberControlViewController.swift
//  MagiPhotoBrowser_Example
//
//  Created by anran on 2018/10/26.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit
import MagiPhotoBrowser

class LocalNumberControlViewController: BaseCollectionViewController {
    
    override var name: String {
        return "数字型页码指示器"
    }
    
    override func makeDataSource() -> [ResourceModel] {
        var result: [ResourceModel] = []
        (0..<6).forEach { index in
            let model = ResourceModel()
            model.localName = "local_\(index)"
            result.append(model)
        }
        return result
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.magiPhotoBrowser.dequeueReusableCell(BaseCollectionViewCell.self, for: indexPath)
        cell.imageView.image = self.dataSource[indexPath.item].localName.flatMap({ name -> UIImage? in
            return UIImage(named: name)
        })
        return cell
    }
    
    override func openPhotoBrowser(with collectionView: UICollectionView, indexPath: IndexPath) {
        // 数据源
        let dataSource = MagiLocalDataSource(numberOfItems: {
            // 共有多少项
            return self.dataSource.count
        }, localImage: { index -> UIImage? in
            // 每一项的图片对象
            return self.dataSource[index].localName.flatMap({ name -> UIImage? in
                return UIImage(named: name)
            })
        })
        // 视图代理，实现了数字型页码指示器
        let delegate = MagiNumberPageControlDelegate()
        // 打开浏览器
        MagiPhotoBrowser(dataSource: dataSource, delegate: delegate).show(pageIndex: indexPath.item)
    }
}

