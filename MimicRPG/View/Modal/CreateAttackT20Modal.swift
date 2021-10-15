//
//  CreateAttackModal.swift
//  MimicRPG
//
//  Created by Eduardo Oliveira on 04/10/21.
//
// swiftlint:disable all

import UIKit

class CreateAttackT20Modal: UIViewController {

    var paginator: Int = 0
    let lastPage: Int = 1

    var isEditMode: Bool = false
    var editingAttack: Attack!

    var viewModel: DisplaySheetViewModelType!

    init(with: DisplaySheetViewModelType) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = with
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
        label.text = "NewAttack".localized()
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

    // MARK: - Breadcrumb

    lazy var breadcrumb: BreadcrumbForm = {
        let breadcrumb = BreadcrumbForm()
        breadcrumb.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(breadcrumb)
        return breadcrumb
    }()

    // MARK: - First Group

    lazy var sheetAttackNameView: EditModalComponent = {
        let view = EditModalComponent(titleText: "AttackName".localized(), type: .text)
        return view
    }()

    lazy var sheetAttackDamageView: EditModalComponent = {
        let view = EditModalComponent(titleText: "Damage".localized(), type: .text)
        return view
    }()

    lazy var sheetAttackBonusView: EditModalComponent = {
        let view = EditModalComponent(titleText: "AttackBonus".localized(), type: .stepper)
        return view
    }()

    lazy var firstStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [sheetAttackNameView, sheetAttackDamageView, sheetAttackBonusView])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.alignment = .fill
        stack.spacing = 22
        self.view.addSubview(stack)
        return stack
    }()

    // MARK: - Second Group

    lazy var sheetAttackTypeView: EditModalComponent = {
        let view = EditModalComponent(titleText: "Type".localized(), type: .text)
        return view
    }()

    lazy var sheetAttackRangeView: EditModalComponent = {
        let view = EditModalComponent(titleText: "Range".localized(), type: .text)
        return view
    }()

    lazy var sheetAttackCriticalView: EditModalComponent = {
        let view = EditModalComponent(titleText: "Critical".localized(), type: .text)
        return view
    }()

    lazy var secondStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [sheetAttackTypeView, sheetAttackRangeView, sheetAttackCriticalView])
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
            self.isEditMode ? editAttack() : createNewAttack()
            dismiss(animated: true, completion: viewModel.callReloadAttacksT20)
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
                breadcrumb.line.backgroundColor = .systemGray
                breadcrumb.secondCircle.transform = CGAffineTransform.identity
                breadcrumb.secondCircle.backgroundColor = .systemGray
            case 1:
                breadcrumb.firstCircle.transform = CGAffineTransform.identity
                breadcrumb.line.backgroundColor = UIColor(named: "Azure")
                breadcrumb.secondCircle.transform = CGAffineTransform(scaleX: 1.4, y: 1.4)
                breadcrumb.secondCircle.backgroundColor = UIColor(named: "Azure")
            default:
                break
            }
        })
    }

    private func additionalConfigurations() {
        configureLayout()
        view.backgroundColor = UIColor(named: "Background")
        updateUI()
    }

    func fillForm(currentAttack: Attack) {
        self.isEditMode = true
        self.title = "EditAttack".localized()
        self.editingAttack = currentAttack

        sheetAttackNameView.setBoxTextValue(with: currentAttack.name ?? "")
        let attackCharac = editingAttack.characteristics?.allObjects as? [Characteristics]

        var attackDamage = ""
        var attackBonus = 0
        var attackType = ""
        var attackReach = ""
        var attackCritical = ""
        if let charArr = attackCharac {
            for currentChar in charArr {
                switch (currentChar.name) {
                case AttackCharacteristicsT20.getCharacteristicName(.attackDamage)():
                    attackDamage = currentChar.stringValue ?? ""
                case AttackCharacteristicsT20.getCharacteristicName(.attackBonus)():
                    attackBonus = Int(currentChar.numberValue)
                case AttackCharacteristicsT20.getCharacteristicName(.attackType)():
                    attackType = currentChar.stringValue ?? ""
                case AttackCharacteristicsT20.getCharacteristicName(.attackReach)():
                    attackReach = currentChar.stringValue ?? ""
                case AttackCharacteristicsT20.getCharacteristicName(.attackCritical)():
                    attackCritical = currentChar.stringValue ?? ""
                default:
                    attackDamage = currentChar.stringValue ?? ""
                }
            }
        }

        sheetAttackDamageView.setBoxTextValue(with: attackDamage)
        sheetAttackBonusView.setStepperValue(with: attackBonus)
        sheetAttackTypeView.setBoxTextValue(with: attackType)
        sheetAttackRangeView.setBoxTextValue(with: attackReach)
        sheetAttackCriticalView.setBoxTextValue(with: attackCritical)
    }

    // MARK: - CoreData
    func createNewAttack() {
        let newName = sheetAttackNameView.getBoxText()
        let newDamage = sheetAttackDamageView.getBoxText()
        let newBonus = sheetAttackBonusView.getStepperValue()
        let newType = sheetAttackTypeView.getBoxText()
        let newRange = sheetAttackRangeView.getBoxText()
        let newCritical = sheetAttackCriticalView.getBoxText()
        viewModel.createAttackT20(attackName: newName, attackDamage: newDamage, attackBonus: newBonus, attackType: newType, attackRange: newRange, criticalBonus: newCritical)
    }

    func editAttack() {
        let newName = sheetAttackNameView.getBoxText()
        let newDamage = sheetAttackDamageView.getBoxText()
        let newBonus = sheetAttackBonusView.getStepperValue()
        let newType = sheetAttackTypeView.getBoxText()
        let newRange = sheetAttackRangeView.getBoxText()
        let newCritical = sheetAttackCriticalView.getBoxText()
        viewModel.editCurrentAttackT20(currentAttack: self.editingAttack, attackName: newName, attackDamage: newDamage, attackBonus: newBonus, attackType: newType, attackRange: newRange, criticalBonus: newCritical)
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
