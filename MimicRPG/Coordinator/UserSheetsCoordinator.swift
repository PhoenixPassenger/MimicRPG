//
//  UserSheetsCoordinator.swift
//  MimicRPG
//
//  Created by Pedro Henrique on 21/09/21.
//

import UIKit

class UserSheetsCoordinator : Coordinator {

    var parentCoordinator: Coordinator

    var navigationController: UINavigationController

    init(with parent: Coordinator, navController: UINavigationController) {
        parentCoordinator = parent
        navigationController = navController
    }

    func goToSelectedSheet(sheet: Sheet) {
        let displayCoord = DisplaySheetCoordinator(with: self, navController: navigationController, sheet: sheet)
        displayCoord.start()
        addChildCoordinator(displayCoord)
    }

}
