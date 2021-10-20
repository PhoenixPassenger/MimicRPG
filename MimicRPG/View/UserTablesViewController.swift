//
//  UserTablesViewController.swift
//  MimicRPG
//
//  Created by Eduardo Oliveira on 20/10/21.
//
import UIKit

private let reuseIdentifier = "Cell"

class MockTable {
    var image: String = ""
    var tableName: String = ""
    var numberOfPlayers: String = ""
    var system: String = ""

    init(image: String, name: String, numberOfPlayers: String, system: String) {
        self.image = image
        self.tableName = name
        self.numberOfPlayers = numberOfPlayers
        self.system = system
    }
}

class UserTablesViewController: UIViewController, UISearchResultsUpdating {

    var coordinator: UserTablesCoordinator?
    var viewModel: UserTablesViewModelType!

    var collectionView: UICollectionView?
    let searchController = UISearchController()
    lazy var addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(triggerNewSheetModal))

    var mockTables: [MockTable] = [] {
        didSet {
            filteredTables = mockTables
        }
    }

    var filteredTables: [MockTable] = []

    override func viewDidLoad() {

        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true

        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        addButton.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.josefinSansButton()], for: .normal)
        navigationItem.rightBarButtonItem = addButton

        searchController.searchResultsUpdater = self

        let itemSize = UIScreen.main.bounds.width - 40

        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: itemSize, height: 2*itemSize/5)

        layout.minimumInteritemSpacing = 3
        layout.minimumLineSpacing = 3
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView?.register(TableCell.self, forCellWithReuseIdentifier: reuseIdentifier)

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
        collectionView?.reloadData()
    }

    @objc func toSheet(sheet: Sheet) {
        coordinator?.goToSelectedSheet(sheet: sheet)
    }

    @objc func triggerNewSheetModal() {
        let createSheetModal = CreateSheetModal()
//        createSheetModal.sheetsOutput = viewModel.output
        present(createSheetModal, animated: true, completion: nil)
    }

    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else {
            return
        }
        if text == "" {
            filteredTables = mockTables
        } else {
            filteredTables = mockTables.filter { item in
                return item.tableName.lowercased().contains(text.lowercased())
            }
        }
        collectionView?.reloadData()
    }
}

extension UserTablesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredTables.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? TableCell else {
            return collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        }
        myCell.set(name: filteredTables[indexPath.row].tableName, numberOfPlayers: filteredTables[indexPath.row].numberOfPlayers, system: filteredTables[indexPath.row].system)
        return myCell
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func fetchData() {
        mockTables = [
            MockTable(image: "banner", name: "Guerra da Centelha", numberOfPlayers: "5 jogadores", system: "Tormenta 20"),
            MockTable(image: "banner", name: "O Mistério do Sabiá", numberOfPlayers: "4 jogadores", system: "Cthulhu 7th ed."),
            MockTable(image: "banner", name: "Retorno de Zendikar", numberOfPlayers: "6 jogadores", system: "Tormenta 20")
        ]
    }
}

extension UserTablesViewController: UserTablesViewModelOutput {
    func reloadDisplayData() {
        fetchData()
    }
}

extension UserTablesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        toSheet(sheet: self.filteredSheets[indexPath.row])
    }
}
