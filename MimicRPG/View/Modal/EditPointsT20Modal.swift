//
//  EditPointsT20Modal.swift
//  MimicRPG
//
//  Created by Eduardo Oliveira on 04/10/21.
//
// swiftlint:disable force_cast

import UIKit

class EditPointsT20Modal: UIViewController {

    var paginator: Int = 0
    let lastPage: Int = 1

    var viewModel: DisplaySheetViewModelType!

    init(with viewModel: DisplaySheetViewModelType) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
        setStartingPointsValues(with: self.viewModel)
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
        label.text = "EditPoints".localized()
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

    lazy var sheetBonusArmorView: EditModalComponent = {
        let view = EditModalComponent(titleText: "ArmorBonus".localized(), type: .stepper)
        return view
    }()

    lazy var sheetBonusShieldView: EditModalComponent = {
        let view = EditModalComponent(titleText: "ShieldBonus".localized(), type: .stepper)
        return view
    }()

    lazy var sheetOthersView: EditModalComponent = {
        let view = EditModalComponent(titleText: "Others".localized(), type: .stepper)
        return view
    }()

    lazy var firstStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [sheetBonusArmorView, sheetBonusShieldView, sheetOthersView])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.alignment = .fill
        stack.spacing = 22
        self.view.addSubview(stack)
        return stack
    }()

    // MARK: - Second Group

    lazy var sheetTemporaryView: EditModalComponent = {
        let view = EditModalComponent(titleText: "Temporary".localized(), type: .stepper)
        return view
    }()

    lazy var sheetMaxLifeView: EditModalComponent = {
        let view = EditModalComponent(titleText: "MaxLife".localized(), type: .stepper)
        return view
    }()

    lazy var sheetMaxManaView: EditModalComponent = {
        let view = EditModalComponent(titleText: "MaxMana".localized(), type: .stepper)
        return view
    }()

    lazy var secondStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [sheetTemporaryView, sheetMaxLifeView, sheetMaxManaView])
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
            editPoints()
            dismiss(animated: true, completion: viewModel.callReloadPoints)
        } else {
            paginator += 1
            updateUI()
        }
    }

    func setStartingPointsValues(with viewModel: DisplaySheetViewModelType) {
        for point in viewModel.getPoints() {
            switch (point.name) {
            case PointsT20.getPoints(.armorBonus)().name:
                sheetBonusArmorView.setValue(with: Int(point.actualValue))
            case PointsT20.getPoints(.shieldBonus)().name:
                sheetBonusShieldView.setValue(with: Int(point.actualValue))
            case PointsT20.getPoints(.classArmorOthers)().name:
                sheetOthersView.setValue(with: Int(point.actualValue))
            case PointsT20.getPoints(.classArmorTemp)().name:
                sheetTemporaryView.setValue(with: Int(point.actualValue))
            case PointsT20.getPoints(.life)().name:
                sheetMaxLifeView.setValue(with: Int(point.maxValue))
            case PointsT20.getPoints(.mana)().name:
                sheetMaxManaView.setValue(with: Int(point.maxValue))
            default:
                sheetBonusArmorView.setValue(with: Int(point.actualValue))
            }
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

    // MARK: - CoreData
    func editPoints() {
        let editArmorBonus = sheetBonusArmorView.getStepperValue()
        let editShieldBonus = sheetBonusShieldView.getStepperValue()
        let editOthers =  sheetOthersView.getStepperValue()
        let editTemporary = sheetTemporaryView.getStepperValue()
        let editMaxLife = sheetMaxLifeView.getStepperValue()
        let editMaxMana = sheetMaxManaView.getStepperValue()
        viewModel.setPoints(setArmorBonus: editArmorBonus, setShieldBonus: editShieldBonus, setOthers: editOthers, setTemporary: editTemporary, setMaxLife: editMaxLife, setMaxMana: editMaxMana)
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
