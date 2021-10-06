//
//  UserSheetsViewController.swift
//  MimicRPG
//
//  Created by Pedro Henrique on 13/09/21.
//
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
        switch (system) {
        case "Cthulhu 7th ed.":
            self.system = "CT7"
        case "Tormenta 20":
            self.system = "T20"
        default:
            self.system = "T20"
        }
    }
}

class UserSheetsViewController: UIViewController, UISearchResultsUpdating {

    var coordinator: UserSheetsCoordinator?
    var viewModel: UserSheetsViewModelType!

    var collectionView: UICollectionView?
    let searchController = UISearchController()
    lazy var addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(triggerNewSheetModal))

    var mockSheets: [MockSheet] = [] {
        didSet {
            filteredSheets = mockSheets
        }
    }

    var filteredSheets: [MockSheet] = []

    override func viewDidLoad() {

        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true

        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        addButton.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.josefinSansButton()], for: .normal)
        navigationItem.rightBarButtonItem = addButton

        searchController.searchResultsUpdater = self

        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 30, bottom: 10, right: 30)
        layout.itemSize = CGSize(width: 160, height: 180)

        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView?.register(UserSheet.self, forCellWithReuseIdentifier: reuseIdentifier)

        collectionView?.dataSource = self
        collectionView?.delegate = self

        view.addSubview(collectionView ?? UICollectionView())

        self.fetchData()
    }

    override func viewWillAppear(_ animated: Bool) {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(named: "SecondaryBackground")
        appearance.titleTextAttributes = [.font:
        UIFont.boldSystemFont(ofSize: 20.0),
                                      .foregroundColor: UIColor.white]
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }

    override func viewDidAppear(_ animated: Bool) {
        self.view.backgroundColor = UIColor(named: "Background")
        addButton.tintColor = UIColor(named: "Azure")
        collectionView?.layer.backgroundColor = UIColor(named: "Background")?.cgColor
    }

    @objc func toSheet() {
        coordinator?.goToSelectedSheet()
    }

    @objc func triggerNewSheetModal() {
        let createSheetModal = CreateSheetModal()
        createSheetModal.sheetsOutput = viewModel.output
        present(createSheetModal, animated: true, completion: nil)
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

    func fetchData() {
        let storedSheets = viewModel.fetchSheets()
        mockSheets.removeAll()
        for sheet in storedSheets {
            if let sheetName = sheet.name, let sheetSystem = sheet.system {
                mockSheets.append(MockSheet(image: "llanowar", charName: sheetName, desc: "Guerra da Centelha", system: sheetSystem))
            }
        }
        collectionView?.reloadData()
    }
}

extension UserSheetsViewController: UserSheetsViewModelOutput {
    func reloadDisplayData() {
        fetchData()
    }
}

extension UserSheetsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        toSheet()
    }
}
