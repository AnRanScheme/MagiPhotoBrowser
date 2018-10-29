//
//  HomeViewController.swift
//  MagiPhotoBrowser_Example
//
//  Created by anran on 2018/10/26.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit

class HomeViewController: UITableViewController {
    
    private let reusedId = "reused"
    var dataSources: [BaseCollectionViewController] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        dataSources = makeDataSource()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
}

// MARK: - Customize
extension HomeViewController {
    
    private func setupUI() {
        navigationItem.title = "MagiPhotoBrowser"
        navigationItem.backBarButtonItem = UIBarButtonItem(
            title: "",
            style: .plain,
            target: nil,
            action: nil)
        tableView.register(UITableViewCell.self,
                           forCellReuseIdentifier: reusedId)
    }
    
    private func makeDataSource() -> [BaseCollectionViewController] {
        return [
            LocalImageViewController(),
            LongPressedViewController(),
            LocalDefaultPageControlViewController(),
            LocalNumberControlViewController(),
            ZoomViewController(),
            ZoomFrameViewController(),
            NetworkingImageViewController(),
            RawImageViewController(),
            GIFImageViewController(),
            WebpImageViewController()
        ]
    }
    
}

// MARK: - Action
extension HomeViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSources.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reusedId) ?? UITableViewCell.init(style: .default,
                                                                                                   reuseIdentifier: reusedId)
        cell.textLabel?.text = dataSources[indexPath.row].name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        navigationController?.pushViewController(dataSources[indexPath.row], animated: true)
    }
    
}

