//
//  Main.swift
//  MimicRPG
//
//  Created by Rodrigo Silva Ribeiro on 09/09/21.
//

import Foundation
import UIKit

class MainCoordinator : Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let startingViewController = TabBarViewController()
        startingViewController.coordinator = self

        let sheetsViewController = UserSheetsViewController()
        sheetsViewController.coordinator = self
        sheetsViewController.title = "Fichas"
        sheetsViewController.tabBarItem = UITabBarItem(title: "Fichas", image: UIImage(named: "pencil"),
                                       selectedImage: UIImage(named: "pencil"))

        let diceRollerViewController = DiceRollerViewController()
        diceRollerViewController.coordinator = self
        diceRollerViewController.title = "Dados"
        diceRollerViewController.tabBarItem = UITabBarItem(title: "Dados", image: UIImage(named: "pencil"),
                                                           selectedImage: UIImage(named: "pencil"))

        let settingsViewController = SettingsViewController()
        settingsViewController.coordinator = self
        settingsViewController.title = "Opções"
        settingsViewController.tabBarItem = UITabBarItem(title: "Opções", image: UIImage(named: "gearshape"),
                                                         selectedImage: UIImage(named: "gearshape.fill"))

        let sheetsNavigationController = UINavigationController(rootViewController: sheetsViewController)
        let diceNavigationController = UINavigationController(rootViewController: diceRollerViewController)
        let settingsNavigationController = UINavigationController(rootViewController: settingsViewController)

        startingViewController.viewControllers = [sheetsNavigationController, diceNavigationController,
                                                  settingsNavigationController]

        navigationController.pushViewController(startingViewController, animated: false)
    }

    func goToSelectedSheet(from controller: UIViewController) {
        let viewController = DisplaySheetViewController()
        
    }
}
