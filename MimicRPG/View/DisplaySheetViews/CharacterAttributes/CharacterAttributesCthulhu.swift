//
//  CharacterAttributesCthulhu.swift
//  MimicRPG
//
//  Created by Eduardo Oliveira on 05/10/21.
//
// swiftlint:disable cyclomatic_complexity

import UIKit

class CharacterAttributesCthulhu: UIView {
    var viewModel: DisplaySheetViewModelType!
    let scrollView: UIScrollView = UIScrollView()

    lazy var editButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.frame = CGRect(x: UIScreen.main.bounds.width * 0.9, y: 0, width: 30, height: 30)
        button.setTitle("Edit".localized(), for: .normal)
        button.setTitleColor(UIColor(named: "Azure"), for: .normal)
        button.addTarget(self, action: #selector(self.editAttributes), for: .touchUpInside)
        self.addSubview(button)
        return button
    }()

    @objc func editAttributes() {
        viewModel.callEditAttributesCthulhu()
    }

    let attributeSTRCthulhu: AttributeBoxCthulhu = {
        let view = AttributeBoxCthulhu(attribute: "STR".localized(), value: 50)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let attributeDEXCthulhu: AttributeBoxCthulhu = {
        let view = AttributeBoxCthulhu(attribute: "DEX".localized(), value: 55)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let attributeINTCthulhu: AttributeBoxCthulhu = {
        let view = AttributeBoxCthulhu(attribute: "INT".localized(), value: 55)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let attributeCONCthulhu: AttributeBoxCthulhu = {
        let view = AttributeBoxCthulhu(attribute: "CON".localized(), value: 75)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let attributeAPPCthulhu: AttributeBoxCthulhu = {
        let view = AttributeBoxCthulhu(attribute: "APP".localized(), value: 45)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let attributePOWCthulhu: AttributeBoxCthulhu = {
        let view = AttributeBoxCthulhu(attribute: "POW".localized(), value: 50)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let attributeSIZCthulhu: AttributeBoxCthulhu = {
        let view = AttributeBoxCthulhu(attribute: "SIZ".localized(), value: 80)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let attributeEDUCthulhu: AttributeBoxCthulhu = {
        let view = AttributeBoxCthulhu(attribute: "EDU".localized(), value: 61)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let attributeMOVCthulhu: AttributeBoxCthulhu = {
        let view = AttributeBoxCthulhu(attribute: "MOV".localized(), value: 8, isMovement: true)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var firstStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [attributeSTRCthulhu, attributeDEXCthulhu, attributeINTCthulhu])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.spacing = UIScreen.main.bounds.width * 0.02
        stack.distribution = .fillEqually
//        self.addSubview(stack)
        return stack
    }()
    lazy var secondStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [attributeCONCthulhu, attributeAPPCthulhu, attributePOWCthulhu])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.spacing = UIScreen.main.bounds.width * 0.02
        stack.distribution = .fillEqually
//        self.addSubview(stack)
        return stack
    }()
    lazy var thirdStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [attributeSIZCthulhu, attributeEDUCthulhu, attributeMOVCthulhu])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.spacing = UIScreen.main.bounds.width * 0.02
        stack.distribution = .fillEqually
//        self.addSubview(stack)
        return stack
    }()
    init() {
        super.init(frame: .zero)
        self.backgroundColor = UIColor(named: "Background")

        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.contentSize = CGSize(width: .zero, height: 38)
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.layer.zPosition = 1

        scrollView.addSubview(firstStack)
        scrollView.addSubview(secondStack)
        scrollView.addSubview(thirdStack)
        scrollView.clipsToBounds = true
        self.addSubview(scrollView)

        configureLayout()
    }

    func setupView() {
        for attribute in viewModel.getAttributes() {
            switch (attribute.name) {
            case SkillCthulhuAttributes.getAttribute(.STR)().name:
                attributeSTRCthulhu.setAttributeValue(with: Int(attribute.value))
            case SkillCthulhuAttributes.getAttribute(.DEX)().name:
                attributeDEXCthulhu.setAttributeValue(with: Int(attribute.value))
            case SkillCthulhuAttributes.getAttribute(.INT)().name:
                attributeINTCthulhu.setAttributeValue(with: Int(attribute.value))
            case SkillCthulhuAttributes.getAttribute(.CON)().name:
                attributeCONCthulhu.setAttributeValue(with: Int(attribute.value))
            case SkillCthulhuAttributes.getAttribute(.APP)().name:
                attributeAPPCthulhu.setAttributeValue(with: Int(attribute.value))
            case SkillCthulhuAttributes.getAttribute(.POW)().name:
                attributePOWCthulhu.setAttributeValue(with: Int(attribute.value))
            case SkillCthulhuAttributes.getAttribute(.SIZ)().name:
                attributeSIZCthulhu.setAttributeValue(with: Int(attribute.value))
            case SkillCthulhuAttributes.getAttribute(.EDU)().name:
                attributeEDUCthulhu.setAttributeValue(with: Int(attribute.value))
            case SkillCthulhuAttributes.getAttribute(.MOV)().name:
                attributeMOVCthulhu.setAttributeValue(with: Int(attribute.value), isMovement: true)
            default:
                attributeSTRCthulhu.setAttributeValue(with: Int(attribute.value))
            }
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func configureLayout() {
        NSLayoutConstraint.activate([
            editButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 15),
            editButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            editButton.heightAnchor.constraint(equalToConstant: 34),

            scrollView.topAnchor.constraint(equalTo: editButton.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor),

            firstStack.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            firstStack.topAnchor.constraint(equalTo: scrollView.topAnchor),

            secondStack.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            secondStack.topAnchor.constraint(equalTo: firstStack.bottomAnchor, constant: UIScreen.main.bounds.height * 0.03),

            thirdStack.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            thirdStack.topAnchor.constraint(equalTo: secondStack.bottomAnchor, constant: UIScreen.main.bounds.height * 0.03),
            thirdStack.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
            ])

    }
}
