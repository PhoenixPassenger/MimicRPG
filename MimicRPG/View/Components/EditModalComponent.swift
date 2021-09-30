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
}

class EditModalComponent: UIView {

    var isMultiline: Bool = false
    var typeOfModalComponent: TypeOfModalComponent = .text
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.josefinSansBold14()
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

    lazy var titleStepper: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "0"
        label.font = UIFont.josefinSansRegular()
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

    lazy var stack: UIStackView = {
        var stack = UIStackView()
        if typeOfModalComponent == .text {
            stack = UIStackView(arrangedSubviews: [titleLabel, valueText])
        } else {
            stack = UIStackView(arrangedSubviews: [titleLabel, stackStepper])
        }
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fillEqually
        self.addSubview(stack)
        return stack
    }()

    @objc func stepperChanged(sender: UIStepper) {
        titleStepper.text = ("\(Int(sender.value))")
    }
    
    @objc func tapDone(sender: Any) {
        self.endEditing(true)
    }

    init(titleText: String, multiline: Bool = false, type: TypeOfModalComponent, actualStepper: Int = 0, maxStepper: Int = 100) {
        super.init(frame: .zero)
        titleLabel.text = titleText
        self.isMultiline = multiline
        self.typeOfModalComponent = type
        self.titleStepper.text = "\(actualStepper)"
        self.valueStepper.value = Double(actualStepper)
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
            stack.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stack.topAnchor.constraint(equalTo: self.topAnchor),
            stack.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])

        if isMultiline {
            valueText.heightAnchor.constraint(equalToConstant: 90).isActive = true
            valueText.textContainer.maximumNumberOfLines = 10
        } else {
            valueText.heightAnchor.constraint(equalToConstant: 35).isActive = true
            valueText.textContainer.maximumNumberOfLines = 1
        }
    }
}

extension EditModalComponent: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
}
