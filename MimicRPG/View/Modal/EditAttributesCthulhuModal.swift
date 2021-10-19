//
//  EditAttributesCthulhuModal.swift
//  MimicRPG
//
//  Created by Eduardo Oliveira on 04/10/21.
//
// swiftlint:disable force_cast

import UIKit

class EditAttributesCthulhuModal: UIViewController {

    var paginator: Int = 0
    let lastPage: Int = 2
    
    var viewModel: DisplaySheetViewModelType!

    init(with viewModel: DisplaySheetViewModelType) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
        setStartingAttributeValues(with: self.viewModel)
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
        label.text = "EditAttributes".localized()
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
        let breadcrumb = BreadcrumbForm(numberOfCrumbs: 3)
        breadcrumb.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(breadcrumb)
        return breadcrumb
    }()

    // MARK: - First Group

    lazy var strengthView: EditModalComponent = {
        let view = EditModalComponent(titleText: "Strength".localized(), type: .stepper)
        return view
    }()

    lazy var dexterityView: EditModalComponent = {
        let view = EditModalComponent(titleText: "Dexterity".localized(), type: .stepper)
        return view
    }()

    lazy var intelligenceView: EditModalComponent = {
        let view = EditModalComponent(titleText: "Intelligence".localized(), type: .stepper)
        return view
    }()

    lazy var firstStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [strengthView, dexterityView, intelligenceView])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.alignment = .fill
        stack.spacing = 22
        self.view.addSubview(stack)
        return stack
    }()

    // MARK: - Second Group

    lazy var constitutionView: EditModalComponent = {
        let view = EditModalComponent(titleText: "Constitution".localized(), type: .stepper)
        return view
    }()

    lazy var appearanceView: EditModalComponent = {
        let view = EditModalComponent(titleText: "Appearance".localized(), type: .stepper)
        return view
    }()
    
    lazy var powerView: EditModalComponent = {
        let view = EditModalComponent(titleText: "Power".localized(), type: .stepper)
        return view
    }()

    lazy var secondStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [constitutionView, appearanceView, powerView])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.alignment = .fill
        stack.spacing = 22
        self.view.addSubview(stack)
        return stack
    }()
    
    // MARK: - Third Group

    lazy var sizeView: EditModalComponent = {
        let view = EditModalComponent(titleText: "Size".localized(), type: .stepper)
        return view
    }()

    lazy var educationView: EditModalComponent = {
        let view = EditModalComponent(titleText: "Education".localized(), type: .stepper)
        return view
    }()

    lazy var moveView: EditModalComponent = {
        let view = EditModalComponent(titleText: "Move".localized(), type: .stepper)
        return view
    }()

    lazy var thirdStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [sizeView, educationView, moveView])
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
            editAttributes()
            dismiss(animated: true, completion: viewModel.callReloadAttributesCthulhu)
        } else {
            paginator += 1
            updateUI()
        }
    }
    
    func setStartingAttributeValues(with viewModel: DisplaySheetViewModelType) {
        for attribute in viewModel.getAttributes() {
            switch (attribute.name) {
            case SkillCthulhuAttributes.getAttribute(.STR)().name:
                strengthView.setStepperValue(with: Int(attribute.value))
            case SkillCthulhuAttributes.getAttribute(.DEX)().name:
                dexterityView.setStepperValue(with: Int(attribute.value))
            case SkillCthulhuAttributes.getAttribute(.INT)().name:
                 intelligenceView.setStepperValue(with: Int(attribute.value))
            case SkillCthulhuAttributes.getAttribute(.CON)().name:
                constitutionView.setStepperValue(with: Int(attribute.value))
            case SkillCthulhuAttributes.getAttribute(.APP)().name:
                appearanceView.setStepperValue(with: Int(attribute.value))
            case SkillCthulhuAttributes.getAttribute(.POW)().name:
                powerView.setStepperValue(with: Int(attribute.value))
            case SkillCthulhuAttributes.getAttribute(.SIZ)().name:
                sizeView.setStepperValue(with: Int(attribute.value))
            case SkillCthulhuAttributes.getAttribute(.EDU)().name:
                educationView.setStepperValue(with: Int(attribute.value))
            case SkillCthulhuAttributes.getAttribute(.MOV)().name:
                moveView.setStepperValue(with: Int(attribute.value))
            default:
                strengthView.setStepperValue(with: Int(attribute.value))
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
            thirdStack.isHidden = true
        case 1:
            firstStack.isHidden = true
            secondStack.isHidden = false
            thirdStack.isHidden = true
        case 2:
            firstStack.isHidden = true
            secondStack.isHidden = true
            thirdStack.isHidden = false
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
                breadcrumb.secondLine.backgroundColor = .systemGray
                breadcrumb.thirdCircle.transform = CGAffineTransform.identity
                breadcrumb.thirdCircle.backgroundColor = .systemGray
            case 1:
                breadcrumb.firstCircle.transform = CGAffineTransform.identity
                breadcrumb.firstLine.backgroundColor = UIColor(named: "Azure")
                breadcrumb.secondCircle.transform = CGAffineTransform(scaleX: 1.4, y: 1.4)
                breadcrumb.secondCircle.backgroundColor = UIColor(named: "Azure")
                breadcrumb.secondLine.backgroundColor = .systemGray
                breadcrumb.thirdCircle.transform = CGAffineTransform.identity
                breadcrumb.thirdCircle.backgroundColor = .systemGray
            case 2:
                breadcrumb.firstCircle.transform = CGAffineTransform.identity
                breadcrumb.firstLine.backgroundColor = UIColor(named: "Azure")
                breadcrumb.secondCircle.transform = CGAffineTransform.identity
                breadcrumb.secondCircle.backgroundColor = UIColor(named: "Azure")
                breadcrumb.secondLine.backgroundColor = UIColor(named: "Azure")
                breadcrumb.thirdCircle.transform = CGAffineTransform(scaleX: 1.4, y: 1.4)
                breadcrumb.thirdCircle.backgroundColor = UIColor(named: "Azure")
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
    func editAttributes() {
        let editSTR = strengthView.getStepperValue()
        let editDEX = dexterityView.getStepperValue()
        let editINT = intelligenceView.getStepperValue()
        let editCON = constitutionView.getStepperValue()
        let editAPP = appearanceView.getStepperValue()
        let editPOW = powerView.getStepperValue()
        let editSIZ = sizeView.getStepperValue()
        let editEDU = educationView.getStepperValue()
        let editMOV = moveView.getStepperValue()
        viewModel.setAttributesCthulhu(setSTR: editSTR, setDEX: editDEX, setINT: editINT, setCON: editCON, setAPP: editAPP, setPOW: editPOW, setSIZ: editSIZ, setEDU: editEDU, setMOV: editMOV)
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
            secondStack.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16),

            thirdStack.topAnchor.constraint(equalTo: breadcrumb.bottomAnchor, constant: 10),
            thirdStack.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            thirdStack.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16)
        ])
    }
}
