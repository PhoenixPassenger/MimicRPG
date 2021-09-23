//
//  NewSheetModal.swift
//  MimicRPG
//
//  Created by Eduardo Oliveira on 23/09/21.
//

import UIKit

class NewSheetModal: UIViewController {
    var editionAction: (() -> ())?
    var viewModel: NewSheetModalViewModelType!

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
        tableView.tableFooterView = UIView()

        self.view.addSubview(tableView)

        setupButtons()
        configureConstraints()

        leftButton.addTarget(self, action: #selector(leftButtonBehavior), for: .touchUpInside)
        rightButton.addTarget(self, action: #selector(rightButtonBehavior), for: .touchUpInside)
        viewModel.initSelectedRow()
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
        self.tableView.backgroundColor = UIColor(named: "Background")

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

            tableView.topAnchor.constraint(equalTo: navigationBar.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension NewSheetModal: NewSheetModalViewModelOutput {
    func showSystemsPicker() {
        let viewController = UIViewController()
        let screenWidth = UIScreen.main.bounds.width - 10
        let screenHeight = UIScreen.main.bounds.height / 2
        viewController.preferredContentSize = CGSize(width: screenWidth, height: screenHeight/2)

        let pickerView = UIPickerView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight))
        pickerView.delegate = self
        pickerView.dataSource = self

        pickerView.selectRow(viewModel.selectedRow!, inComponent: 0, animated: true)

        viewController.view.addSubview(pickerView)

        pickerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pickerView.centerXAnchor.constraint(equalTo: viewController.view.centerXAnchor),
            pickerView.centerYAnchor.constraint(equalTo: viewController.view.centerYAnchor)
        ])

        let alert = UIAlertController(title: "titleAlert".localized(), message: "", preferredStyle: .actionSheet)
        alert.setValue(viewController, forKey: "contentViewController")
        alert.addAction(UIAlertAction(title: "Confirm".localized(), style: .default, handler: { _ in
            self.viewModel.changeSystem(pickeredRow: pickerView.selectedRow(inComponent: 0))
        }))
        alert.addAction(UIAlertAction(title: "Cancel".localized(), style: .destructive, handler: { _ in
        }))

        self.present(alert, animated: true, completion: nil)
    }

    func reloadData() {
        self.tableView.reloadData()
    }
}

extension NewSheetModal: UIPickerViewDelegate, UIPickerViewDataSource {
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let screenWidth = UIScreen.main.bounds.width - 10
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 30))
        label.text = self.viewModel.getSystemsDescriptionById(row: row)
        label.font = .systemFont(ofSize: 17)
        label.sizeToFit()
        return label
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.viewModel.getNumberOfSystems()
    }

    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 60
    }
}

extension NewSheetModal: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectRowAt(indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath as IndexPath)
        cell.backgroundColor = UIColor(named: "Background")
        return self.viewModel.cellForRowAt(cell: cell, section: indexPath.section)
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        viewModel.viewForHeaderInSection(section: section)
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.numberOfSections()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
}
