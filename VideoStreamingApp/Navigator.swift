//
//  Navigator.swift
//  VideoStreamingApp
//
//  Created by Nguyen Nghia on 1/16/18.
//  Copyright © 2018 Eitguide. All rights reserved.
//

import Foundation
import UIKit

final class Navigator {
    
    static let shared = Navigator()
    
    var navgationVC: UINavigationController {
    
        let tabBarVC = UITabBarController()
        let streamVC = ViewController(vm: StreamViewModel())
        let downloadVC = DownloadViewController(vm: DownloadViewModel())
        
        streamVC.tabBarItem = UITabBarItem(tabBarSystemItem: .mostViewed, tag: 0)
        downloadVC.tabBarItem = UITabBarItem(tabBarSystemItem: .history, tag: 1)
        
        let navVC = UINavigationController(rootViewController: tabBarVC)
        tabBarVC.setViewControllers([streamVC, downloadVC], animated: true)
        return navVC
    }
}
