//
//  CharacterAttributesT20.swift
//  MimicRPG
//
//  Created by Gustavo Lemos on 23/09/21.
//

import UIKit

class CharacterAttributesT20: UIView {
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
        viewModel.callEditAttributesT20()
    }

    let attributeSTRT20: AttributeBoxT20 = {
        let view = AttributeBoxT20(attribute: "AttributesSTR".localized(), value: 20)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let attributeDEXT20: AttributeBoxT20 = {
        let view = AttributeBoxT20(attribute: "AttributesDEX".localized(), value: 18)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let attributeCONT20: AttributeBoxT20 = {
        let view = AttributeBoxT20(attribute: "AttributesCON".localized(), value: 16)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let attributeINTT20: AttributeBoxT20 = {
        let view = AttributeBoxT20(attribute: "AttributesINT".localized(), value: 14)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let attributeWIST20: AttributeBoxT20 = {
        let view = AttributeBoxT20(attribute: "AttributesWIS".localized(), value: 12)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let attributeCHAT20: AttributeBoxT20 = {
        let view = AttributeBoxT20(attribute: "AttributesCHA".localized(), value: 8)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    lazy var stackPhysical: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [attributeSTRT20, attributeDEXT20, attributeCONT20])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fillEqually
//        self.addSubview(stack)
        return stack
    }()
    lazy var stackMental: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [attributeINTT20, attributeWIST20, attributeCHAT20])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.alignment = .fill
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

        scrollView.addSubview(stackPhysical)
        scrollView.addSubview(stackMental)
        scrollView.clipsToBounds = true
        self.addSubview(scrollView)

        configureLayout()
    }

    func setupView() {
        for attribute in viewModel.getAttributes() {
            switch (attribute.name) {
            case SkillT20Attributes.getAttribute(.STR)().name:
                attributeSTRT20.setAttributeValue(with: Int(attribute.value))
            case SkillT20Attributes.getAttribute(.DEX)().name:
                attributeDEXT20.setAttributeValue(with: Int(attribute.value))
            case SkillT20Attributes.getAttribute(.CON)().name:
                attributeCONT20.setAttributeValue(with: Int(attribute.value))
            case SkillT20Attributes.getAttribute(.INT)().name:
                attributeINTT20.setAttributeValue(with: Int(attribute.value))
            case SkillT20Attributes.getAttribute(.WIS)().name:
                attributeWIST20.setAttributeValue(with: Int(attribute.value))
            case SkillT20Attributes.getAttribute(.CHA)().name:
                attributeCHAT20.setAttributeValue(with: Int(attribute.value))
            default:
                attributeSTRT20.setAttributeValue(with: Int(attribute.value))
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

            stackPhysical.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            stackPhysical.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 35),

            stackMental.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            stackMental.topAnchor.constraint(equalTo: stackPhysical.bottomAnchor, constant: UIScreen.main.bounds.height * 0.03),
            stackMental.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ])
    }
}
