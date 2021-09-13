//
//  ViewController.swift
//  MimicRPG
//
//  Created by Rodrigo Silva Ribeiro on 09/09/21.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tabBar.isTranslucent = false
        self.navigationController?.navigationBar.prefersLargeTitles = true

        let sheetsViewController = UserSheetsViewController()
        sheetsViewController.title = "Fichas"
        sheetsViewController.tabBarItem = UITabBarItem(title: "Fichas", image: UIImage(named: "pencil"),
                                       selectedImage: UIImage(named: "pencil"))

        let diceRollerViewController = DiceRollerViewController()
        diceRollerViewController.title = "Dados"
        diceRollerViewController.tabBarItem = UITabBarItem(title: "Dados", image: UIImage(named: "pencil"),
                                                           selectedImage: UIImage(named: "pencil"))

        let settingsViewController = SettingsViewController()
        settingsViewController.title = "Opções"
        settingsViewController.tabBarItem = UITabBarItem(title: "Opções", image: UIImage(named: "gearshape"),
                                                         selectedImage: UIImage(named: "gearshape.fill"))

        let sheetsNavigationController = UINavigationController(rootViewController: sheetsViewController)
        let diceNavigationController = UINavigationController(rootViewController: diceRollerViewController)
        let settingsNavigationController = UINavigationController(rootViewController: settingsViewController)
        self.viewControllers = [sheetsNavigationController, diceNavigationController,
                                settingsNavigationController]
    }

}
