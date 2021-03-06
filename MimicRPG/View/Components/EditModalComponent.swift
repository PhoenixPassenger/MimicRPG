//
//  EditModalComponent.swift
//  MimicRPG
//
//  Created by Eduardo Oliveira on 30/09/21.
//

import UIKit

enum TypeOfModalComponent {
    case text
    case stepper
    case switchButton
}

class EditModalComponent: UIView {

    var isMultiline: Bool = false
    var typeOfModalComponent: TypeOfModalComponent = .text

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFontMetrics(forTextStyle: .subheadline).scaledFont(for: .josefinSansRegular())
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 2
        return label
    }()

    lazy var valueText: UITextView = {
        let field = UITextView()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.font = UIFontMetrics(forTextStyle: .body).scaledFont(for: .josefinSansRegular())
        field.delegate = self
        field.layer.borderWidth = 1
        field.layer.cornerRadius = 5
        field.textContainer.lineBreakMode = .byWordWrapping
        field.layer.borderColor = UIColor.systemGray3.cgColor
        field.backgroundColor = UIColor(named: "SecondaryBackground")
        field.textContainerInset = UIEdgeInsets(top: (field.font?.lineHeight)!/4, left: 8, bottom: 0, right: 0)
        return field
    }()

    lazy var titleStepper: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "0"
        label.font = UIFontMetrics(forTextStyle: .body).scaledFont(for: .josefinSansRegular())
        label.heightAnchor.constraint(equalToConstant: label.font!.lineHeight).isActive = true
        return label
    }()

    lazy var valueStepper: UIStepper = {
        let stepper = UIStepper()
        stepper.translatesAutoresizingMaskIntoConstraints = false
        stepper.addTarget(self, action: #selector(stepperChanged(sender:)), for: .valueChanged)
        return stepper
    }()

    lazy var stackStepper: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [titleStepper, valueStepper])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.layer.borderWidth = 1
        stack.layer.cornerRadius = 5
        stack.layer.borderColor = UIColor.systemGray3.cgColor
        stack.layoutMargins = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        stack.isLayoutMarginsRelativeArrangement = true
        stack.backgroundColor = UIColor(named: "SecondaryBackground")
        self.addSubview(stack)
        return stack
    }()

    lazy var trainedSwitch: UISwitch = {
        let switchButton = UISwitch()
        switchButton.isOn = false
        switchButton.isEnabled = true
        return switchButton
    }()

    lazy var stackSwitch: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [titleStepper, trainedSwitch])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.layer.borderWidth = 1
        stack.layer.cornerRadius = 5
        stack.layer.borderColor = UIColor.systemGray3.cgColor
        stack.layoutMargins = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        stack.isLayoutMarginsRelativeArrangement = true
        stack.backgroundColor = UIColor(named: "SecondaryBackground")
        self.addSubview(stack)
        return stack
    }()

    lazy var stack: UIStackView = {
        var stack = UIStackView()

        switch typeOfModalComponent {
        case .text:
            stack = UIStackView(arrangedSubviews: [titleLabel, valueText])
        case .stepper:
            stack = UIStackView(arrangedSubviews: [titleLabel, stackStepper])
        case .switchButton:
            stack = UIStackView(arrangedSubviews: [titleLabel, stackSwitch])
        }

        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.alignment = .fill
        stack.spacing = 0
        self.addSubview(stack)
        return stack
    }()

    @objc func stepperChanged(sender: UIStepper) {
        titleStepper.text = ("\(Int(sender.value))")
    }

    @objc func tapDone(sender: Any) {
        self.endEditing(true)
    }

    func setStepperValue(with value: Int) {
        self.valueStepper.value = Double(value)
        self.titleStepper.text = "\(Int(self.valueStepper.value))"
    }

    func setBoxTextValue(with value: String) {
        self.valueText.text = value
    }

    func getStepperValue() -> Int {
        return Int(self.valueStepper.value)
    }

    func getBoxText() -> String {
        return self.valueText.text
    }

    init(titleText: String, multiline: Bool = false, type: TypeOfModalComponent, actualStepper: Int = 0, maxStepper: Int = 100) {
        super.init(frame: .zero)
        titleLabel.text = titleText
        self.isMultiline = multiline
        self.typeOfModalComponent = type
        self.valueStepper.value = Double(actualStepper)
        self.titleStepper.text = "\(self.valueStepper.value)"
        self.valueStepper.maximumValue = Double(maxStepper)
        configureLayout()
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
    }

    private func configureLayout() {
        NSLayoutConstraint.activate([
            stack.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            stack.leadingAnchor.constraint(equalTo: self.leadingAnchor)
        ])

        if isMultiline {
            valueText.heightAnchor.constraint(equalToConstant: valueText.font!.lineHeight * 4.7).isActive = true
            valueText.textContainer.maximumNumberOfLines = 10
            self.heightAnchor.constraint(equalToConstant: valueText.font!.lineHeight * 5.7).isActive = true
        } else {
            valueText.heightAnchor.constraint(equalToConstant: valueText.font!.lineHeight * 1.7).isActive = true
            valueText.textContainer.maximumNumberOfLines = 1
            self.heightAnchor.constraint(equalToConstant: valueText.font!.lineHeight * 2.7).isActive = true
        }
        if typeOfModalComponent == .stepper {
            stackStepper.heightAnchor.constraint(equalToConstant: valueText.font!.lineHeight * 2.1).isActive = true
        }
    }
}

extension EditModalComponent: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if isMultiline == false {
            if(text == "\n") {
                textView.resignFirstResponder()
                return false
            }
        }
        return true
    }
}
