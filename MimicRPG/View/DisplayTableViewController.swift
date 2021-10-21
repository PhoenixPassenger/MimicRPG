//
//  DisplayTableViewController.swift
//  MimicRPG
//
//  Created by Eduardo Oliveira on 20/10/21.
//
// swiftlint:disable force_cast

import UIKit

class DisplayTableViewController: UIViewController {

    var buttons: [UIButton] = []
    var viewModel: DisplayTableViewModelType!
    var coordinator: Coordinator?

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

    var tableNotes: UITableView = UITableView()

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
        configureConstraints()
        updateElements()
    }

    func configureConstraints() {
        tableNotes.translatesAutoresizingMaskIntoConstraints = false
        tableNotes.register(CharacterNotesCell.self, forCellReuseIdentifier: "MyCell")
        tableNotes.delegate = self
        tableNotes.dataSource = self
        view.addSubview(tableNotes)

        NSLayoutConstraint.activate([
            bannerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -(navigationController?.navigationBar.frame.height)!),
            bannerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bannerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bannerView.heightAnchor.constraint(equalToConstant: 139),

            titleView.topAnchor.constraint(equalTo: bannerView.bottomAnchor, constant: 15),
            titleView.leadingAnchor.constraint(equalTo: bannerView.leadingAnchor, constant: 16),

            tableNotes.topAnchor.constraint(equalTo: titleView.bottomAnchor),
            tableNotes.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableNotes.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableNotes.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    func updateElements() {
        titleView.text = viewModel.table?.name

        let view = TableNotes()
        view.viewModel = self.viewModel
        tableNotes = view
        view.setupTableView()
    }
}

extension DisplayTableViewController: DisplayTableViewModelOutput {
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
        tableNotes.reloadData()
    }
}

extension DisplayTableViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.getNotes().count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellWrap = tableView.dequeueReusableCell(withIdentifier: "MyCell") as? CharacterNotesCell
        guard let cell = cellWrap else { fatalError() }
        let notes = self.viewModel.getNotes()
        let noteRow = notes[indexPath.row]
        cell.set(titleItem: noteRow.name ?? "Nota", valueItem: (noteRow.characteristics?.stringValue) ?? "Descrição")
//        cell.set(titleItem: "Nota de mesa", valueItem: "Descrição")
        return cell
    }
}
