//
//  Coordinator.swift
//  MimicRPG
//
//  Created by Rodrigo Silva Ribeiro on 09/09/21.
//

import UIKit

class Coordinator {
    private(set) var childCoordinators: [Coordinator] = []

    func start() {

    }

    func finish() {

    }

    public func addChildCoordinator(_ coordinator: Coordinator) {
        childCoordinators.append(coordinator)
    }

    public func removeChildCoordinator(_ coordinator: Coordinator) {
        if let index = childCoordinators.firstIndex(of: coordinator) {
            childCoordinators.remove(at: index)
        } else {
            print("Couldn't remove coordinator: \(coordinator). It's not a child coordinator.")
        }
    }
}

extension Coordinator: Equatable {

    static func == (lhs: Coordinator, rhs: Coordinator) -> Bool {
        return lhs === rhs
    }

}
