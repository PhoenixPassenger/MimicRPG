//
//  DisplaySheetCoordinator.swift
//  MimicRPG
//
//  Created by Pedro Henrique on 21/09/21.
//

import UIKit

class DisplaySheetCoordinator : Coordinator {

    var parentCoordinator: Coordinator
    var sheet: Sheet
    var navigationController: UINavigationController

    init(with parent: Coordinator, navController: UINavigationController, sheet: Sheet) {
        parentCoordinator = parent
        self.sheet = sheet
        navigationController = navController
    }

    override func start() {
        let sheetVC = DisplaySheetViewController()
        sheetVC.coordinator = self
        let sheetVM = DisplaySheetViewModel()
        sheetVM.sheet = sheet
        sheetVC.viewModel = sheetVM
        navigationController.pushViewController(sheetVC, animated: true)
    }

    override func finish() {
        parentCoordinator.removeChildCoordinator(self)
        // delegate?.didFinish(from: self)
    }

}
