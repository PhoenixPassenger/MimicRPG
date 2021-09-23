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
        sheetsViewController.title = "Fichas"
        sheetsViewController.tabBarItem = UITabBarItem(title: "Fichas", image: UIImage(named: "pencil"),
                                       selectedImage: UIImage(named: "pencil"))

        let diceRollerViewController = DiceRollerViewController()
        diceRollerViewController.viewModel = DiceRollerViewModel()
        diceRollerViewController.viewModel.output = diceRollerViewController
        diceRollerViewController.coordinator = self
        diceRollerViewController.title = "Dados"
        diceRollerViewController.tabBarItem = UITabBarItem(title: "Dados", image: UIImage(named: "pencil"),
                                                           selectedImage: UIImage(named: "pencil"))

        let settingsViewController = SettingsViewController()
        settingsViewController.viewModel = SettingsViewModel()
        settingsViewController.viewModel.output = settingsViewController
        settingsViewController.coordinator = self
        settingsViewController.title = "Options".localized()
        settingsViewController.tabBarItem = UITabBarItem(title: "Options".localized(), image: UIImage(named: "gearshape"),
                                                         selectedImage: UIImage(named: "gearshape.fill"))

        let sheetsNavigationController = UINavigationController(rootViewController: sheetsViewController)
        let diceNavigationController = UINavigationController(rootViewController: diceRollerViewController)
        let settingsNavigationController = UINavigationController(rootViewController: settingsViewController)

        let sheetsCoord = UserSheetsCoordinator(with: self, navController: sheetsNavigationController)
        sheetsViewController.coordinator = sheetsCoord

        tabBarController.viewControllers = [sheetsNavigationController, diceNavigationController,settingsNavigationController]

//        navigationController.pushViewController(startingViewController, animated: false)
    }

    override func finish() {

    }
}
