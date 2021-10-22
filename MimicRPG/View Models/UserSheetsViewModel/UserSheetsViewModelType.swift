//
//  UserSheetsViewModelType.swift
//  MimicRPG
//
//  Created by Eduardo Oliveira on 23/09/21.
//

import Foundation
import UIKit
protocol UserSheetsViewModelType {
    var output: UserSheetsViewModelOutput? {get set}
    var sheets: [Sheet]? { get set }

    func fetchSheets() -> [Sheet]
}
