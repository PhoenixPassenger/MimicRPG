//
//  TableSheets.swift
//  MimicRPG
//
//  Created by Eduardo Oliveira on 22/10/21.
//

import Foundation
import UIKit

class MockSheet {
    var image: String = ""
    var charName: String = ""
    var desc: String = ""
    var system: String = ""

    init(image: String, charName: String, desc: String, system: String) {
        self.image = image
        self.charName = charName
        self.desc = desc
        self.system = system
    }
}

class TableSheets: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource {

    var viewModel : DisplayTableViewModelType!

    var mockSheets: [MockSheet] = [
            MockSheet(image: "llanowar", charName: "Llanowar", desc: "Guerra da Centelha", system: "T20"),
            MockSheet(image: "llanowar", charName: "Ral", desc: "O Trono de Eldraine", system: "T20"),
            MockSheet(image: "llanowar", charName: "Nahiri", desc: "Retorno de Zendikar", system: "T20")
        ]

    func setupCollectionView() {
        self.register(UserSheet.self, forCellWithReuseIdentifier: "MyCell")
        self.dataSource = self
        self.delegate = self
        self.backgroundColor = UIColor(named: "Background")
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        mockSheets.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath) as? UserSheet else {
            return collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath)
        }
        myCell.set(name: mockSheets[indexPath.row].charName, desc: "", system: mockSheets[indexPath.row].system)
        return myCell
    }
}
