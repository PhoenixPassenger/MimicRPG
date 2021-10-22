//
//  DisplayTableCoordinator.swift
//  MimicRPG
//
//  Created by Eduardo Oliveira on 20/10/21.
//

import UIKit

class DisplayTableCoordinator : Coordinator {

    var parentCoordinator: Coordinator
    var table: Table
    var navigationController: UINavigationController

    init(with parent: Coordinator, navController: UINavigationController, table: Table) {
        parentCoordinator = parent
        self.table = table
        navigationController = navController
    }

    override func start() {
        let sheetVC = DisplayTableViewController()
        sheetVC.coordinator = self
        let sheetVM = DisplayTableViewModel()
        sheetVM.table = table
        sheetVC.viewModel = sheetVM
        sheetVM.output = sheetVC
        navigationController.pushViewController(sheetVC, animated: true)
    }

    override func finish() {
        parentCoordinator.removeChildCoordinator(self)
        // delegate?.didFinish(from: self)
    }
}
