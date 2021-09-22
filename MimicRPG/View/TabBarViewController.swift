//
//  ViewController.swift
//  MimicRPG
//
//  Created by Rodrigo Silva Ribeiro on 09/09/21.
//

import UIKit

class TabBarViewController: UITabBarController {

    weak var coordinator: MainCoordinator?

    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 15.0, *) {
           let appearance = UITabBarAppearance()
           appearance.configureWithOpaqueBackground()
           appearance.backgroundColor = .systemBackground
           self.tabBar.standardAppearance = appearance
//           self.tabBar.scrollEdgeAppearance = appearance
        }

//        self.tabBar.isTranslucent = false
//        self.navigationController?.navigationBar.prefersLargeTitles = true
    }

}
