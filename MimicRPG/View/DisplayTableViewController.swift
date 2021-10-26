//
//  DisplayTableViewController.swift
//  MimicRPG
//
//  Created by Eduardo Oliveira on 20/10/21.
//
// swiftlint:disable force_cast

import UIKit

class DisplayTableViewController: UIViewController {

    var viewModel: DisplayTableViewModelType!
    var coordinator: Coordinator?

    var myCollectionView:UICollectionView?

    lazy var bannerView: UIImageView = {
        let bannerView = UIImageView()
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        bannerView.layer.opacity = 0.5
        bannerView.layer.zPosition = 1
        let color = UIImage.imageWithColor(color: .brandy)
        bannerView.image = color
        view.addSubview(bannerView)
        return bannerView
    }()

    lazy var titleView: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Table without name"
        label.font = UIFont.josefinSansBold30()
        label.tintColor = UIColor(named: "FontColor")
        view.addSubview(label)
        return label
    }()

    lazy var collectionHeaderTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Notes".localized()
        label.tintColor = UIColor(named: "FontColor")
        label.font = UIFont.josefinSansRegular()
        view.addSubview(label)
        return label
    }()

    lazy var collectionHeaderButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "plus.circle.fill"), for: .normal)
        button.tintColor = UIColor(named: "Azure")
        button.addTarget(self, action: #selector(self.addSheet), for: .touchUpInside)
        view.addSubview(button)
        return button
    }()

    var tableNotes: TableNotes = TableNotes()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(named: "Background")

        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.titleTextAttributes = [.font:
        UIFont.boldSystemFont(ofSize: 20.0),
                                      .foregroundColor: UIColor.white]
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.prefersLargeTitles = true

        setupElements()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func setupElements() {
        updateElements()
        configureConstraints()
    }

    @objc func addSheet() {
        self.viewModel.addSheetModal()
    }

    func updateElements() {
        titleView.text = viewModel.table?.name

        let view = TableNotes()
        view.viewModel = self.viewModel
        tableNotes = view
        view.setupTableView()

        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: 160, height: 160)
        layout.scrollDirection = .horizontal

        myCollectionView = UICollectionView(frame: CGRect(origin: CGPoint(x: 0, y: 189), size: CGSize(width: self.view.frame.size.width, height: 180)), collectionViewLayout: layout)
        myCollectionView?.register(UserSheet.self, forCellWithReuseIdentifier: "MyCell")
        myCollectionView?.backgroundColor = UIColor.white

        myCollectionView?.dataSource = self
        myCollectionView?.delegate = self
    }

    func configureConstraints() {
        myCollectionView?.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(myCollectionView ?? UICollectionView())

        tableNotes.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableNotes)

        NSLayoutConstraint.activate([
            bannerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -(navigationController?.navigationBar.frame.height)!),
            bannerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bannerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bannerView.heightAnchor.constraint(equalToConstant: 139),

            titleView.topAnchor.constraint(equalTo: bannerView.bottomAnchor, constant: 15),
            titleView.leadingAnchor.constraint(equalTo: bannerView.leadingAnchor, constant: 16),

            collectionHeaderTitle.topAnchor.constraint(equalTo: titleView.bottomAnchor, constant: 7),
            collectionHeaderTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            collectionHeaderButton.topAnchor.constraint(equalTo: titleView.bottomAnchor),
            collectionHeaderButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),

            tableNotes.topAnchor.constraint(equalTo: titleView.bottomAnchor, constant: 190),
            tableNotes.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableNotes.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableNotes.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension DisplayTableViewController: DisplayTableViewModelOutput {
    func displayAddSheetModal() {
        let modal = AddSheetToTableModal()
        modal.tableViewModel = self.viewModel
        self.present(modal, animated: true, completion: nil)
    }

    func displayNewNoteModal() {
        let modal = CreateNoteModal()
        modal.tableViewModel = self.viewModel
        self.present(modal, animated: true, completion: nil)
    }

    func displayEditNoteModal(name: String, desc: String, note: Notes) {
        let modal = CreateNoteModal()
        modal.tableViewModel = self.viewModel
        modal.fillForm(name: name, desc: desc, note: note)
        self.present(modal, animated: true, completion: nil)
    }

    func updateNotes() {
        self.tableNotes.reloadData()
    }
}

extension DisplayTableViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9 // How many cells to display
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath) as? UserSheet else {
            return collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath)
        }
        return myCell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       print("User tapped on item \(indexPath.row)")
    }
}
