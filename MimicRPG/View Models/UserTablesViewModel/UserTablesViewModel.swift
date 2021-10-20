//
//  UserTablesViewModel.swift
//  MimicRPG
//
//  Created by Eduardo Oliveira on 20/10/21.
//
// swiftlint:disable force_cast

import Foundation
import UIKit

final class UserTablesViewModel {

//    var sheets: [Sheet]? = []

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    public weak var output: UserTablesViewModelOutput?
}

extension UserTablesViewModel: UserTablesViewModelType {

//    func fetchSheets() -> [Sheet] {
//        do {
//            self.sheets = try context.fetch(Sheet.fetchRequest())
//        } catch {
//            fatalError("Unable to fetch data from core data ")
//        }
//        return self.sheets!
//    }
}
