//
//  CreateItemModal.swift
//  MimicRPG
//
//  Created by Eduardo Oliveira on 01/10/21.
//
// swiftlint:disable force_cast

import UIKit

class CreateItemModal: UIViewController {
    var viewModel : DisplaySheetViewModelType!
    var isEditMode: Bool = false
    var editItem: Item?

    var paginator: Int = 0
    let lastPage: Int = 1

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
        label.text = "NewItem".localized()
        label.font = UIFontMetrics(forTextStyle: .title1).scaledFont(for: .josefinSansButton())
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

    // MARK: - Breadcrumb

    lazy var breadcrumb: BreadcrumbForm = {
        let breadcrumb = BreadcrumbForm()
        breadcrumb.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(breadcrumb)
        return breadcrumb
    }()

    // MARK: - First Group

    lazy var sheetItemNameView: EditModalComponent = {
        let view = EditModalComponent(titleText: "ItemName".localized(), type: .text)
        return view
    }()

    lazy var sheetItemQtdView: EditModalComponent = {
        let view = EditModalComponent(titleText: "Quantity".localized(), type: .stepper)
        return view
    }()

    lazy var firstStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [sheetItemNameView, sheetItemQtdView])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.alignment = .fill
        stack.spacing = 22
        self.view.addSubview(stack)
        return stack
    }()

    // MARK: - Second Group

    lazy var sheetItemDescView: EditModalComponent = {
        let view = EditModalComponent(titleText: "Description".localized(),multiline: true, type: .text)
        return view
    }()

    lazy var secondStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [sheetItemDescView])
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

        if (isEditMode) {
            titleModal.text = "EditItem".localized()
        } else {
            titleModal.text = "NewItem".localized()
        }
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
            createNewItem()
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

        switch paginator {
        case 0:
            firstStack.isHidden = false
            secondStack.isHidden = true
        case 1:
            firstStack.isHidden = true
            secondStack.isHidden = false
        default:
            break
        }
        updateBreadcrumb()
    }

    func updateBreadcrumb() {
        UIView.animate(withDuration: 0.3, animations: { [self] in
            switch paginator {
            case 0:
                breadcrumb.firstCircle.transform = CGAffineTransform(scaleX: 1.4, y: 1.4)
                breadcrumb.firstLine.backgroundColor = .systemGray
                breadcrumb.secondCircle.transform = CGAffineTransform.identity
                breadcrumb.secondCircle.backgroundColor = .systemGray
            case 1:
                breadcrumb.firstCircle.transform = CGAffineTransform.identity
                breadcrumb.firstLine.backgroundColor = UIColor(named: "Azure")
                breadcrumb.secondCircle.transform = CGAffineTransform(scaleX: 1.4, y: 1.4)
                breadcrumb.secondCircle.backgroundColor = UIColor(named: "Azure")
            default:
                break
            }
        })
    }

    func fillForm(name: String, desc: String, uses: Int, item: Item) {
        sheetItemNameView.valueText.text = name
        sheetItemQtdView.valueStepper.value = Double(uses)
        sheetItemQtdView.titleStepper.text = String(uses)
        sheetItemDescView.valueText.text = desc
        self.editItem = item
        self.isEditMode = true
    }

    private func additionalConfigurations() {
        configureLayout()
        view.backgroundColor = UIColor(named: "Background")
        updateUI()
    }

    // MARK: - CoreData
    func createNewItem() {
        let name = sheetItemNameView.valueText.text ?? ""
        let uses = Int(sheetItemQtdView.valueStepper.value)
        let desc = sheetItemDescView.valueText.text ?? ""
        !self.isEditMode ? self.viewModel.createNewItem(name: name, uses: uses, description: desc)
        : self.viewModel.editItem(name: name, description: desc, uses: uses, item: self.editItem!)
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

            breadcrumb.topAnchor.constraint(equalTo: navigationBar.bottomAnchor, constant: 30),
            breadcrumb.centerXAnchor.constraint(equalTo: navigationBar.centerXAnchor),
            breadcrumb.heightAnchor.constraint(equalToConstant: 9),
            breadcrumb.widthAnchor.constraint(equalToConstant: 32),

            firstStack.topAnchor.constraint(equalTo: breadcrumb.bottomAnchor, constant: 10),
            firstStack.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            firstStack.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16),

            secondStack.topAnchor.constraint(equalTo: breadcrumb.bottomAnchor, constant: 10),
            secondStack.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            secondStack.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16)
        ])
    }
}
