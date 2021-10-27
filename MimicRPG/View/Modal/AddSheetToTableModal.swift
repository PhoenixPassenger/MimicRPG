//
//  AddSheetToTableModal.swift
//  MimicRPG
//
//  Created by Eduardo Oliveira on 26/10/21.
//
// swiftlint:disable all

import UIKit

class AddSheetToTableModal: UIViewController {

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    var selectedRow: Int = 0
    var isFetching: Bool = true
    var tableViewModel : DisplayTableViewModelType?
    var sheet: Sheet?

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
        label.text = "AddSheetToTable".localized()
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
        button.setTitleColor(.gray, for: .normal)
        button.titleLabel?.font = UIFont.josefinSansButton()
        button.isEnabled = false
        self.view.addSubview(button)
        return button
    }()

    // MARK: - First Group

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "SheetCode".localized()
        label.font = UIFont.josefinSansButton()
        return label
    }()

    lazy var valueText: UITextView = {
        let field = UITextView()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.font = UIFont.josefinSansRegular()
        field.delegate = self
        field.layer.borderWidth = 1
        field.layer.cornerRadius = 5
        field.textContainer.lineBreakMode = .byWordWrapping
        field.layer.borderColor = UIColor.systemGray3.cgColor
        field.backgroundColor = UIColor(named: "SecondaryBackground")
        return field
    }()

    lazy var feedbackLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.josefinSansButton()
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 2
        return label
    }()
    
    lazy var stack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [titleLabel, valueText, feedbackLabel])
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
        addSheetToTable()
        dismiss(animated: true, completion: nil)
    }

    private func additionalConfigurations() {
        configureLayout()
        view.backgroundColor = UIColor(named: "Background")
    }
    
    func fetchSheetByIdentifier() {
        if let fetchSheet = tableViewModel?.fetchSheetByIdentifier(identifier: valueText.text) {
            if tableViewModel?.table?.system == fetchSheet.system {
                sheet = fetchSheet
                feedbackLabel.text = "Existe uma ficha com esse código!"
                feedbackLabel.textColor = .systemGreen
                rightButton.isEnabled = true
                rightButton.setTitleColor(UIColor(named: "Azure"), for: .normal)
            } else {
                feedbackLabel.text = "A ficha deste código pertence a outro sistema de RPG!"
                feedbackLabel.textColor = .systemRed
                rightButton.isEnabled = false
                rightButton.setTitleColor(.gray, for: .normal)
            }
        } else {
            feedbackLabel.text = "Não existe uma ficha com esse código!"
            feedbackLabel.textColor = .systemRed
            rightButton.isEnabled = false
            rightButton.setTitleColor(.gray, for: .normal)
        }
    }


    // MARK: - CoreData
    func addSheetToTable() {
        if let fetchSheet = sheet {
            tableViewModel?.addSheetToTable(sheet: fetchSheet)
        }
    }

    // MARK: - Layout
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
            stack.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16),
            
            valueText.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
}

extension AddSheetToTableModal: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        // substituir para pesquisa em cloudkit geral por todas fichas
        if isFetching {
            isFetching = false
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) { [self] in
                fetchSheetByIdentifier()
                isFetching = true
            }
        }
    }
}
