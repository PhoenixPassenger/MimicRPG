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

    @discardableResult func deleteSheet(receivedSheet: Sheet?) -> Bool {
        var success: Bool = false
        if let receivedSheet = receivedSheet {
            let storedSheets = fetchSheets()
            for sheet in storedSheets {
                if (receivedSheet.identifier == sheet.identifier) {
                    context.delete(sheet)
                    do {
                        try context.save()
                        success = true
                    } catch {
                        fatalError("Unable to fetch data from core data ")
                    }
                    break
                }
            }
        }
        self.output?.reloadDisplayData()
        return success
    }

    func getAbbSystemName(system: String) -> String {
        if system == "Tormenta 20" {
            return "T20"
        } else if system == "Cthulhu 7th ed." {
            return "CT7"
        }
        return ""
    }

    func fetchSheets() -> [Sheet] {
        do {
            self.sheets = try context.fetch(Sheet.fetchRequest())
        } catch {
            fatalError("Unable to fetch data from core data ")
        }
        return self.sheets!
    }
}
