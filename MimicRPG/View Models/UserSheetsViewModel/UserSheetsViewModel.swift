
//
//  NewSheetModalViewModel.swift
//  MimicRPG
//
//  Created by Eduardo Oliveira on 23/09/21.
//
// swiftlint:disable force_cast

import Foundation
import UIKit

final class UserSheetsViewModel {
    
    var sheets: [Sheet]? = []
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    public weak var output: UserSheetsViewModelOutput?
}

extension UserSheetsViewModel: UserSheetsViewModelType {
    
    func fetchSheets() -> [Sheet] {
        do {
            self.sheets = try context.fetch(Sheet.fetchRequest())
        } catch {
            fatalError("Unable to fetch data from core data ")
        }
        return self.sheets!
    }
}
