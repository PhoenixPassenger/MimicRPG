//
//  DiceRollerViewModel.swift
//  MimicRPG
//
//  Created by Eduardo Oliveira on 16/09/21.
//

import Foundation
import UIKit

final class DiceRollerViewModel {
    public weak var output: DiceRollerViewModelOutput?
}

extension DiceRollerViewModel: DiceRollerViewModelType {
    
    func numberOfSections() -> Int {
        return 1
    }
    
    func viewForHeaderInSection(section: Int) -> UIView {
        let view = UIView()
        return view
    }
    
    
    func didSelectRowAt(indexPath: IndexPath) {
        //
    }
    
    
}
