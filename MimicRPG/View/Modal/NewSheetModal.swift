//
//  NewSheetModal.swift
//  MimicRPG
//
//  Created by Eduardo Oliveira on 23/09/21.
//

import UIKit

class NewSheetModal: UIViewController {
    var editionAction: (() -> ())?

    var tableView = UITableView()
    var navigationBar: UIView = UIView()
    var titleModal: UILabel = UILabel()
    var leftButton: UIButton = UIButton()
    var rightButton: UIButton = UIButton()

    init(action: @escaping () -> ()) {
        super.init(nibName: nil, bundle: nil)
        editionAction = action
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
      }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(named: "Background")

        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")

        self.view.addSubview(tableView)
        self.tableView.tableFooterView = UIView()

        setupButtons()
        configureConstraints()

        leftButton.addTarget(self, action: #selector(leftButtonBehavior), for: .touchUpInside)
        rightButton.addTarget(self, action: #selector(rightButtonBehavior), for: .touchUpInside)
    }

    @objc func leftButtonBehavior() {
        dismiss(animated: true, completion: editionAction)
    }

    @objc func rightButtonBehavior() {
//        createNewInvestigator()
        dismiss(animated: true, completion: editionAction)
    }

    func setupButtons() {
        navigationBar.translatesAutoresizingMaskIntoConstraints = false
        navigationBar.backgroundColor = UIColor(named: "SecondaryBackground")
        self.view.addSubview(navigationBar)

        titleModal.translatesAutoresizingMaskIntoConstraints = false
        titleModal.textColor = UIColor(named: "FontColor")
        titleModal.text = "Nova Ficha"
        titleModal.font = UIFont.josefinSansButton()
        self.view.addSubview(titleModal)

        leftButton.translatesAutoresizingMaskIntoConstraints = false
        leftButton.setTitle("Cancelar", for: .normal)
        leftButton.setTitleColor(UIColor(named: "Azure"), for: .normal)
        leftButton.titleLabel?.font = UIFont.josefinSansButton()
        self.view.addSubview(leftButton)

        rightButton.translatesAutoresizingMaskIntoConstraints = false
        rightButton.setTitle("Confirmar", for: .normal)
        rightButton.setTitleColor(UIColor(named: "Azure"), for: .normal)
        rightButton.titleLabel?.font = UIFont.josefinSansButton()
        self.view.addSubview(rightButton)
    }

    func configureConstraints() {
        tableView.contentOffset = CGPoint(x: -18, y: -18)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            navigationBar.topAnchor.constraint(equalTo: self.view.topAnchor),
            navigationBar.heightAnchor.constraint(equalToConstant: 55),
            navigationBar.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            navigationBar.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),

            titleModal.centerXAnchor.constraint(equalTo: navigationBar.centerXAnchor),
            titleModal.centerYAnchor.constraint(equalTo: navigationBar.centerYAnchor),

            leftButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            leftButton.centerYAnchor.constraint(equalTo: navigationBar.centerYAnchor),

            rightButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16),
            rightButton.centerYAnchor.constraint(equalTo: navigationBar.centerYAnchor),

            tableView.topAnchor.constraint(equalTo: navigationBar.bottomAnchor, constant: 30),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension NewSheetModal: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath as IndexPath)
        return cell
    }
}
