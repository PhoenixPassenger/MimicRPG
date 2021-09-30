//
//  CreateSheetModal.swift
//  MimicRPG
//
//  Created by Eduardo Oliveira on 30/09/21.
//

import UIKit

enum Systems: String, CaseIterable {
    case ct7 = "CT7"
    case t20 = "T20"

    var description: String {
        switch self {
        case .ct7:
            return "Cthulhu 7th ed."
        case .t20:
            return "Tormenta 20"
        }
    }

    init?(id : Int) {
        switch id {
        case 0:
            self = .ct7
        case 1:
            self = .t20
        default:
            return nil
        }
    }
}

class CreateSheetModal: UIViewController {

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    var selectedRow: Int = 0

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
      }

    // MARK: - NavBar
    lazy var navigationBar: UIView = {
        let bar = UIView()
        bar.translatesAutoresizingMaskIntoConstraints = false
        bar.backgroundColor = UIColor(named: "SecondaryBackground")
        self.view.addSubview(bar)
        return bar
    }()

    lazy var titleModal: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(named: "FontColor")
        label.text = "NewSheet".localized()
        label.font = UIFont.josefinSansButton()
        self.view.addSubview(label)
        return label
    }()

    lazy var leftButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Cancel".localized(), for: .normal)
        button.setTitleColor(UIColor(named: "Azure"), for: .normal)
        button.titleLabel?.font = UIFont.josefinSansButton()
        self.view.addSubview(button)
        return button
    }()

    lazy var rightButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Confirm".localized(), for: .normal)
        button.setTitleColor(UIColor(named: "Azure"), for: .normal)
        button.titleLabel?.font = UIFont.josefinSansButton()
        self.view.addSubview(button)
        return button
    }()

    // MARK: - First Group

    lazy var sheetNameView: EditModalComponent = {
        let view = EditModalComponent(titleText: "Name".localized(), type: .text)
        return view
    }()

    lazy var systemTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "System".localized()
        label.font = UIFont.josefinSansBold14()
        return label
    }()

    lazy var systemButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel!.font = UIFont.josefinSansRegular()
        button.setTitle("\(Systems(id: selectedRow)?.description ?? "")", for: .normal)
        button.contentHorizontalAlignment = .left
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 5
        button.layer.borderColor = UIColor.systemGray3.cgColor
        button.addTarget(self, action: #selector(showSystemsPicker), for: .touchUpInside)
        button.backgroundColor = UIColor(named: "SecondaryBackground")
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0)
        button.heightAnchor.constraint(equalToConstant: 35).isActive = true
        return button
    }()

    lazy var systemStack: UIStackView = {
        var stack = UIStackView(arrangedSubviews: [systemTitleLabel, systemButton])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fillEqually
        return stack
    }()

    lazy var stack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [sheetNameView, systemStack])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.alignment = .fill
        stack.spacing = 22
        self.view.addSubview(stack)
        return stack
    }()

    // MARK: - Functions

    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        additionalConfigurations()
        leftButton.addTarget(self, action: #selector(leftButtonBehavior), for: .touchUpInside)
        rightButton.addTarget(self, action: #selector(rightButtonBehavior), for: .touchUpInside)
    }

    @objc func leftButtonBehavior() {
        dismiss(animated: true, completion: nil)
    }

    @objc func rightButtonBehavior() {
        createNewInvestigator()
        dismiss(animated: true, completion: nil)
    }

    private func additionalConfigurations() {
        configureLayout()
        view.backgroundColor = UIColor(named: "Background")
    }

    @objc func showSystemsPicker() {
        let viewController = UIViewController()
        let screenWidth = UIScreen.main.bounds.width - 10
        let screenHeight = UIScreen.main.bounds.height / 2
        viewController.preferredContentSize = CGSize(width: screenWidth, height: screenHeight/2)

        let pickerView = UIPickerView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight))
        pickerView.delegate = self
        pickerView.dataSource = self

        pickerView.selectRow(selectedRow, inComponent: 0, animated: true)
        viewController.view.addSubview(pickerView)

        pickerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pickerView.centerXAnchor.constraint(equalTo: viewController.view.centerXAnchor),
            pickerView.centerYAnchor.constraint(equalTo: viewController.view.centerYAnchor)
        ])

        let alert = UIAlertController(title: "titleAlert".localized(), message: "", preferredStyle: .actionSheet)
        alert.setValue(viewController, forKey: "contentViewController")
        alert.addAction(UIAlertAction(title: "Confirm".localized(), style: .default, handler: { [self] _ in
            selectedRow = pickerView.selectedRow(inComponent: 0)
            systemButton.setTitle("\(Systems(id: selectedRow)?.description ?? "")", for: .normal)
        }))
        alert.addAction(UIAlertAction(title: "Cancel".localized(), style: .destructive, handler: { _ in
        }))

        self.present(alert, animated: true, completion: nil)
    }

    func createNewInvestigator() {
//        self.investigatorPresenter.newInvestigator(investigatorNameView.valueText.text, occupationView.valueText.text)
    }

    private func configureLayout() {
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

            stack.topAnchor.constraint(equalTo: navigationBar.bottomAnchor, constant: 30),
            stack.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            stack.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16)
        ])
    }
}

extension CreateSheetModal: UIPickerViewDelegate, UIPickerViewDataSource {
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let screenWidth = UIScreen.main.bounds.width - 10
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 30))
        label.text = Systems(id: row)?.description
        label.font = .systemFont(ofSize: 17)
        label.sizeToFit()
        return label
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Systems.allCases.count
    }

    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 60
    }
}