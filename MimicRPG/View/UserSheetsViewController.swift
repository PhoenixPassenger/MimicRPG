//
//  UserSheetsViewController.swift
//  MimicRPG
//
//  Created by Pedro Henrique on 13/09/21.
//

// swiftlint:disable force_cast

import UIKit

private let reuseIdentifier = "Cell"

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

class UserSheetsViewController: UIViewController, UISearchResultsUpdating {

    weak var coordinator: MainCoordinator?

    var collectionView: UICollectionView?
    let searchController = UISearchController()
    let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(toSheet))

    var mockSheets: [MockSheet] = [
        MockSheet(image: "llanowar", charName: "Llanowar", desc: "Guerra da Centelha", system: "T20"),
        MockSheet(image: "llanowar", charName: "Ral", desc: "O Trono de Eldraine", system: "T20"),
        MockSheet(image: "llanowar", charName: "Nahiri", desc: "Retorno de Zendikar", system: "T20"),
        MockSheet(image: "llanowar", charName: "Cleiton Rasta", desc: "O mistério do Sabiá", system: "CT7")
    ]

    var filteredSheets: [MockSheet] = []

    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true

        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.rightBarButtonItem = addButton

        searchController.searchResultsUpdater = self

        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 30, bottom: 10, right: 30)
        layout.itemSize = CGSize(width: 160, height: 180)

        filteredSheets = mockSheets

        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView?.register(UserSheet.self, forCellWithReuseIdentifier: reuseIdentifier)

        collectionView?.dataSource = self
        collectionView?.delegate = self

        view.addSubview(collectionView ?? UICollectionView())
    }

    override func viewDidAppear(_ animated: Bool) {
        self.view.backgroundColor = UIColor(named: "Background")
        self.navigationController?.navigationBar.layer.backgroundColor = UIColor(named: "SecondaryBackground")?.cgColor
        addButton.tintColor = UIColor(named: "Azure")
        collectionView?.layer.backgroundColor = UIColor(named: "Background")?.cgColor
    }

    @objc func toSheet() {
        let viewController = DisplaySheetViewController()
        self.navigationController?.pushViewController(viewController, animated: true)
    }

    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else {
            return
        }
        if text == "" {
            filteredSheets = mockSheets
        } else {
            filteredSheets = mockSheets.filter { item in
                return item.charName.lowercased().contains(text.lowercased())
            }
        }
        collectionView?.reloadData()
    }
}

extension UserSheetsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredSheets.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? UserSheet else {
            return collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        }
        myCell.set(name: filteredSheets[indexPath.row].charName, desc: filteredSheets[indexPath.row].desc, system: filteredSheets[indexPath.row].system)
        return myCell
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func fetchData() {}
}

extension UserSheetsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        toSheet()
    }
}
