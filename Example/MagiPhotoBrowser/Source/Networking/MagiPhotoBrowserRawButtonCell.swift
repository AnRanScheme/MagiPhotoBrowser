//
//  MagiPhotoBrowserRawButtonCell.swift
//  MagiPhotoBrowser_Example
//
//  Created by anran on 2018/10/26.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit

open class MagiPhotoBrowserRawButtonCell: MagiPhotoBrowserNetworkingCell {
    /// 查看原图按钮
    open var rawButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.white, for: .highlighted)
        button.backgroundColor = UIColor.black.withAlphaComponent(0.08)
        button.setTitle("查看原图", for: .normal)
        button.setTitle("查看原图", for: .highlighted)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1 / UIScreen.main.scale
        button.layer.cornerRadius = 4
        button.layer.masksToBounds = true
        return button
    }()
    
    /// 保存原图url
    public var rawURLString: String?
    
    /// 引用图片加载器
    public var photoLoader: MagiPhotoLoader?
    
    /// 初始化
    open override func setupViews() {
        super.setupViews()
        rawButton.addTarget(self, action: #selector(onRawImageButton), for: .touchUpInside)
        rawButton.isHidden = true
        contentView.addSubview(rawButton)
    }
    
    /// 布局
    open override func layoutSubviews() {
        super.layoutSubviews()
        rawButton.sizeToFit()
        rawButton.bounds.size.width += 14
        rawButton.center = CGPoint(x: contentView.bounds.width / 2,
                                   y: contentView.bounds.height - 25 - rawButton.bounds.height)
    }
    
    /// 刷新数据
    open func reloadData(photoLoader: MagiPhotoLoader,
                         localImage: UIImage?,
                         autoloadURLString: String?,
                         rawURLString: String?) {
        // 重置环境
        progressView.isHidden = true
        progressView.progress = 0
        rawButton.isHidden = true
        // 保存原图链接
        self.rawURLString = rawURLString
        self.photoLoader = photoLoader
        // url是否有效
        guard let urlString = rawURLString, let url = URL(string: urlString) else {
            // 降级到加载高清图
            super.reloadData(photoLoader: photoLoader, localImage: localImage, autoloadURLString: autoloadURLString)
            return
        }
        // 如果有原图缓存，则显示原图
        if let image = photoLoader.imageCached(on: imageView, url: url) {
            photoLoader.setImage(on: imageView, url: url, placeholder: image, progressBlock: { (_, _) in
                // Empty.
            }) {
                self.setNeedsLayout()
            }
            self.setNeedsLayout()
        }
            // 否则加载高清图
        else {
            rawButton.isHidden = false
            super.reloadData(photoLoader: photoLoader, localImage: localImage, autoloadURLString: autoloadURLString)
        }
    }
    
    /// 响应查看原图按钮
    @objc open func onRawImageButton(_ button: UIButton) {
        self.rawButton.isHidden = true
        self.progressView.isHidden = false
        self.progressView.progress = 0
        guard let urlString = rawURLString, let url = URL(string: urlString) else {
            progressView.isHidden = true
            return
        }
        photoLoader?.setImage(on: imageView, url: url, placeholder: imageView.image, progressBlock: { receivedSize, totalSize in
            if totalSize > 0 {
                self.progressView.progress = CGFloat(receivedSize) / CGFloat(totalSize)
            } else {
                self.progressView.progress = 0
            }
        }) {
            self.progressView.isHidden = true
            self.setNeedsLayout()
        }
    }
}
