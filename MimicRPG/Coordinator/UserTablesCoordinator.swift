//
//  UserTablesCoordinator.swift
//  MimicRPG
//
//  Created by Eduardo Oliveira on 20/10/21.
//

import UIKit

class UserTablesCoordinator : Coordinator {

    var parentCoordinator: Coordinator

    var navigationController: UINavigationController

    init(with parent: Coordinator, navController: UINavigationController) {
        parentCoordinator = parent
        navigationController = navController
    }

    func goToSelectedSheet(table: Table) {
        let displayCoord = DisplayTableCoordinator(with: self, navController: navigationController, table: table)
        displayCoord.start()
        addChildCoordinator(displayCoord)
    }
}
