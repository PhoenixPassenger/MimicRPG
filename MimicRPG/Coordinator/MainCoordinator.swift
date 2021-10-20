//
//  Main.swift
//  MimicRPG
//
//  Created by Rodrigo Silva Ribeiro on 09/09/21.
//

import Foundation
import UIKit

class MainCoordinator : Coordinator {
    var tabBarController: TabBarViewController
    init(tabBarController: TabBarViewController) {
        self.tabBarController = tabBarController
    }

    override func start() {

        tabBarController.coordinator = self

        let sheetsViewController = UserSheetsViewController()
        sheetsViewController.viewModel = UserSheetsViewModel()
        sheetsViewController.viewModel.output = sheetsViewController
        sheetsViewController.title = "TabBarSheets".localized()
        sheetsViewController.tabBarItem = UITabBarItem(title: "TabBarSheets".localized(), image: UIImage(systemName: "doc.on.doc"),
                                       selectedImage: UIImage(systemName: "doc.on.doc.fill"))
        
        let tablesViewController = UserTablesViewController()
        tablesViewController.viewModel = UserTablesViewModel()
        tablesViewController.viewModel.output = tablesViewController
        tablesViewController.title = "TabBarTables".localized()
        tablesViewController.tabBarItem = UITabBarItem(title: "TabBarSheets".localized(), image: UIImage(systemName: "doc.on.doc"),
                                       selectedImage: UIImage(systemName: "doc.on.doc.fill"))

        let diceRollerViewController = DiceRollerViewController()
        diceRollerViewController.viewModel = DiceRollerViewModel()
        diceRollerViewController.viewModel.output = diceRollerViewController
        diceRollerViewController.coordinator = self
        diceRollerViewController.title = "TabBarDice".localized()
        diceRollerViewController.tabBarItem = UITabBarItem(title: "TabBarDice".localized(), image: UIImage(named: "TabDice"),
                                                           selectedImage: UIImage(named: "TabDice"))

        let settingsViewController = SettingsViewController()
        settingsViewController.viewModel = SettingsViewModel()
        settingsViewController.viewModel.output = settingsViewController
        settingsViewController.coordinator = self
        settingsViewController.title = "TabBarOptions".localized()
        settingsViewController.tabBarItem = UITabBarItem(title: "TabBarOptions".localized(), image: UIImage(systemName: "gearshape"),
                                                         selectedImage: UIImage(systemName: "gearshape.fill"))

        let sheetsNavigationController = UINavigationController(rootViewController: sheetsViewController)
        let tablesNavigationController = UINavigationController(rootViewController: tablesViewController)
        let diceNavigationController = UINavigationController(rootViewController: diceRollerViewController)
        let settingsNavigationController = UINavigationController(rootViewController: settingsViewController)

        let sheetsCoord = UserSheetsCoordinator(with: self, navController: sheetsNavigationController)
        sheetsViewController.coordinator = sheetsCoord

        tabBarController.viewControllers = [sheetsNavigationController, tablesNavigationController, diceNavigationController,settingsNavigationController]

//        navigationController.pushViewController(startingViewController, animated: false)
    }

    override func finish() {

    }
}
