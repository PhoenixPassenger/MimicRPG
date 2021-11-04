//
//  UserSheetsViewController.swift
//  MimicRPG
//
//  Created by Pedro Henrique on 13/09/21.
//
import UIKit

private let reuseIdentifier = "Cell"

class UserSheetsViewController: UIViewController, UISearchResultsUpdating, UIGestureRecognizerDelegate {

    var coordinator: UserSheetsCoordinator?
    var viewModel: UserSheetsViewModelType!

    var collectionView: UICollectionView?
    let searchController = UISearchController()
    lazy var addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(triggerNewSheetModal))

    var mockSheets: [Sheet] = [] {
        didSet {
            filteredSheets = mockSheets
        }
    }

    var filteredSheets: [Sheet] = []

    override func viewDidLoad() {

        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true

        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        addButton.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.josefinSansButton()], for: .normal)
        navigationItem.rightBarButtonItem = addButton

        searchController.searchResultsUpdater = self

        let itemSize = UIScreen.main.bounds.width/2 - 3

        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: itemSize, height: itemSize)

        layout.minimumInteritemSpacing = 3
        layout.minimumLineSpacing = 3
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView?.register(UserSheet.self, forCellWithReuseIdentifier: reuseIdentifier)

        collectionView?.dataSource = self
        collectionView?.delegate = self

        let gestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(pressSheetCell(_:)))
        gestureRecognizer.minimumPressDuration = 0.5
        gestureRecognizer.delaysTouchesBegan = true
        gestureRecognizer.delegate = self
        self.collectionView?.addGestureRecognizer(gestureRecognizer)

        view.addSubview(collectionView ?? UICollectionView())

        self.fetchData()
    }

    override func viewWillAppear(_ animated: Bool) {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(named: "SecondaryBackground")
        appearance.titleTextAttributes = [.font:
        UIFont.boldSystemFont(ofSize: 20.0),
                                      .foregroundColor: UIColor(named: "FontColor") as Any]
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = UIColor(named: "FontColor")
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
                return item.name!.lowercased().contains(text.lowercased())
            }
        }
        collectionView?.reloadData()
    }

    @objc func pressSheetCell(_ gestureReconizer : UILongPressGestureRecognizer) {
        if gestureReconizer.state != .began {
            return
        }

        let prep = gestureReconizer.location(in: self.collectionView)
        let indexPath = self.collectionView?.indexPathForItem(at: prep)

        if let index = indexPath {
            let cell = self.collectionView?.cellForItem(at: index)
            alertDeleteCell(selected: cell)
        } else {
            print("Could not find index path")
        }
    }

    func alertDeleteCell(selected cell: UICollectionViewCell!) {
        let alert = UIAlertController(title: "DeleteSheetTitle".localized(), message: "DeleteSheetMessage".localized(), preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "DeleteSheetConfirm".localized(), style: .destructive, handler: { _ in
            let sheetCell = cell as? UserSheet
            self.viewModel.deleteSheet(sheet: sheetCell)
        }))
        alert.addAction(UIAlertAction(title: "Cancel".localized(), style: .cancel, handler: { _ in
        }))

        self.present(alert, animated: true, completion: nil)
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
        myCell.set(name: filteredSheets[indexPath.row].name!, desc: filteredSheets[indexPath.row].table?.name
                   ?? "NoTable".localized(), system: filteredSheets[indexPath.row].system!)
        return myCell
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func fetchData() {
        let storedSheets = viewModel.fetchSheets()
        mockSheets.removeAll()
        for sheet in storedSheets {
            mockSheets.append(sheet)
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
        toSheet(sheet: self.filteredSheets[indexPath.row])
    }
}
