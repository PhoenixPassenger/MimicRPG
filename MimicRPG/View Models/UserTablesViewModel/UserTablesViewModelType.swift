//
//  UserTablesViewModelType.swift
//  MimicRPG
//
//  Created by Eduardo Oliveira on 20/10/21.
//

import Foundation
import UIKit
protocol UserTablesViewModelType {
    var output: UserTablesViewModelOutput? {get set}
    var tables: [Table]? { get set }

    func fetchTables() -> [Table]
}
