//
//  DisplayTableCoordinator.swift
//  MimicRPG
//
//  Created by Eduardo Oliveira on 20/10/21.
//

import UIKit

class DisplayTableCoordinator : Coordinator {

    var parentCoordinator: Coordinator
//    var sheet: Sheet
    var navigationController: UINavigationController

    init(with parent: Coordinator, navController: UINavigationController, sheet: Sheet) {
        parentCoordinator = parent
//        self.sheet = sheet
        navigationController = navController
    }

    override func start() {
        let sheetVC = DisplayTableViewController()
        sheetVC.coordinator = self
        let sheetVM = DisplayTableViewModel()
//        sheetVM.sheet = sheet
        sheetVC.viewModel = sheetVM
        sheetVM.output = sheetVC
        navigationController.pushViewController(sheetVC, animated: true)
    }

    override func finish() {
        parentCoordinator.removeChildCoordinator(self)
        // delegate?.didFinish(from: self)
    }
}
