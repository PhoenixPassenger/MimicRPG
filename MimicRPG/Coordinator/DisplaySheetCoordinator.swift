//
//  DisplaySheetCoordinator.swift
//  MimicRPG
//
//  Created by Pedro Henrique on 21/09/21.
//

import UIKit

class DisplaySheetCoordinator : Coordinator {

    var parentCoordinator: Coordinator

    var navigationController: UINavigationController

    init(with parent: Coordinator, navController: UINavigationController) {
        parentCoordinator = parent
        navigationController = navController
    }

    override func start() {
        let sheetVC = DisplaySheetViewController()
        sheetVC.coordinator = self
        navigationController.pushViewController(sheetVC, animated: true)
    }

    override func finish() {
        parentCoordinator.removeChildCoordinator(self)
    }

}
