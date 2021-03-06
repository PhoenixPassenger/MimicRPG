//
//  EditSkillT20Modal.swift
//  MimicRPG
//
//  Created by Gustavo Lemos on 05/10/21.
//
// swiftlint:disable force_cast

import UIKit

class EditSkillT20Modal: UIViewController {
/*
 Nota mental: Editar a aparencia dos componentes não editaveis pra ficarem diferentes do resto
 */
    var viewModel : DisplaySheetViewModelType!
    var editSkill : Skill?
   /* var trainedSwitchState:Bool {
        return self.trainedView.trainedSwitch.isOn
    }*/

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
        label.text = "EditSkill".localized()
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

    // MARK: - First Group
    lazy var skillTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(named: "FontColor")
        label.text = (editSkill?.name)!.localized()
        label.font = UIFontMetrics(forTextStyle: .title2).scaledFont(for: .josefinSansBold())
        self.view.addSubview(label)
        return label
    }()
    lazy var halfLevelView: EditModalComponent = {
        let view = EditModalComponent(titleText: "HalfLevel".localized(), type: .text)
        view.valueText.text = "5"
        view.valueText.isEditable = false
        view.valueText.layer.opacity = 0.5
        return view
    }()

    lazy var modifierView: EditModalComponent = {
        let view = EditModalComponent(titleText: "ModifierCHA".localized(), type: .text)
        view.valueText.text = "4"
        view.valueText.isEditable = false
        view.valueText.layer.opacity = 0.5
        return view
    }()

    lazy var otherView: EditModalComponent = {
        let view = EditModalComponent(titleText: "Others".localized(), type: .stepper)
        return view
    }()

    /*lazy var trainedView: EditModalComponent = {
        let view = EditModalComponent(titleText: "Training", type: .switchButton)
        view.titleStepper.text = "Enabled".localized()
        return view
    }()*/

    lazy var firstStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [halfLevelView, modifierView, otherView])
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
        self.viewModel.skillT20SaveChanges(skillOtherValue: Int(otherView.titleStepper.text!)!, skill: self.editSkill!)
        dismiss(animated: true, completion: nil)
    }

    private func additionalConfigurations() {
        configureLayout()
        view.backgroundColor = UIColor(named: "Background")
    }

    func fillForm(name: String, skill: Skill) {
        let levelBy2 = viewModel.getProfile().first(where: {$0.name == "Level"})?.numberValue
        halfLevelView.valueText.text = String(levelBy2!/2)

        let skillAtt = viewModel.getAttributes().first(where: {$0.abbreviation == skill.attribute!})
        let skillAttModif = floor(Double(skillAtt!.value-10)/2)
        modifierView.titleLabel.text = ("Modifier"+(skillAtt?.abbreviation)!).localized()
        modifierView.valueText.text = String(Int(skillAttModif))

        // trainedView.trainedSwitch.isOn = skill.isActivated

        otherView.setStepperValue(with: Int(skill.value))

        self.editSkill = skill
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

            skillTitleLabel.topAnchor.constraint(equalTo: navigationBar.bottomAnchor, constant: 30),
            skillTitleLabel.centerXAnchor.constraint(equalTo: navigationBar.centerXAnchor),

            firstStack.topAnchor.constraint(equalTo: skillTitleLabel.bottomAnchor, constant: 10),
            firstStack.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            firstStack.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16)
        ])
    }

}
