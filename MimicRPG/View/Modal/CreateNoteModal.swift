//
//  CreateNoteModal.swift
//  MimicRPG
//
//  Created by Pedro Henrique on 04/10/21.
//
// swiftlint:disable force_cast

import UIKit

class CreateNoteModal: UIViewController {

    var viewModel : DisplaySheetViewModelType!
    var isEditMode: Bool = false
    var editNote: Notes?
    var paginator: Int = 0
    let lastPage: Int = 0

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    var selectedRow: Int = 0
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

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
        label.text = "CreateNote".localized()
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

    lazy var sheetNoteNameView: EditModalComponent = {
        let view = EditModalComponent(titleText: "NoteTitle".localized(), type: .text)
        return view
    }()

    lazy var sheetNoteDescView: EditModalComponent = {
        let view = EditModalComponent(titleText: "NoteContents".localized(), multiline: true, type: .text)
        return view
    }()

    lazy var firstStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [sheetNoteNameView, sheetNoteDescView])
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
        if paginator == 0 {
            dismiss(animated: true, completion: nil)
        } else {
            paginator -= 1
            updateUI()
        }
    }

    @objc func rightButtonBehavior() {
        if paginator == lastPage {
            createNewNote()
            dismiss(animated: true, completion: nil)
        } else {
            paginator += 1
            updateUI()
        }
    }

    func updateUI() {
        if paginator == 0 {
            leftButton.setTitle("Cancel".localized(), for: .normal)
        } else {
            leftButton.setTitle("Back".localized(), for: .normal)
        }

        if paginator == lastPage {
            rightButton.setTitle("Confirm".localized(), for: .normal)
        } else {
            rightButton.setTitle("Next".localized(), for: .normal)
        }
    }

    func fillForm(name: String, desc: String, note: Notes) {
        sheetNoteNameView.valueText.text = name
        sheetNoteDescView.valueText.text = desc
        self.editNote = note
        self.isEditMode = true
    }

    private func additionalConfigurations() {
        configureLayout()
        view.backgroundColor = UIColor(named: "Background")
        updateUI()
    }

    // MARK: - CoreData
    func createNewNote() {
        guard let name = sheetNoteNameView.valueText.text else {return}
        guard let desc = sheetNoteDescView.valueText.text else {return}
        !self.isEditMode ? self.viewModel.newNote(name: name, text: desc) : self.viewModel.editNote(name: name, text: desc, note: self.editNote!)
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

            firstStack.topAnchor.constraint(equalTo: navigationBar.bottomAnchor, constant: 30),
            firstStack.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            firstStack.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16)
        ])
    }
}
