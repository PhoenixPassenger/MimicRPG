//
//  CharacterAttributesCthulhu.swift
//  MimicRPG
//
//  Created by Eduardo Oliveira on 05/10/21.
//

import UIKit

class CharacterAttributesCthulhu: UIView {

    let attributeFORCthulhu: AttributeBoxCthulhu = {
        let view = AttributeBoxCthulhu(attribute: "FOR", value: 50)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let attributeDESCthulhu: AttributeBoxCthulhu = {
        let view = AttributeBoxCthulhu(attribute: "DEX".localized(), value: 55)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let attributeINTCthulhu: AttributeBoxCthulhu = {
        let view = AttributeBoxCthulhu(attribute: "INT", value: 55)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let attributeCONCthulhu: AttributeBoxCthulhu = {
        let view = AttributeBoxCthulhu(attribute: "CON", value: 75)
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
        let view = AttributeBoxCthulhu(attribute: "EDU", value: 61)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let attributeMOVCthulhu: AttributeBoxCthulhu = {
        let view = AttributeBoxCthulhu(attribute: "MOV", value: 8, isMovement: true)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var firstStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [attributeFORCthulhu, attributeDESCthulhu, attributeINTCthulhu])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fillEqually
        stack.spacing = 15
        self.addSubview(stack)
        return stack
    }()
    lazy var secondStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [attributeCONCthulhu, attributeAPPCthulhu, attributePOWCthulhu])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .equalSpacing
        stack.spacing = 15
        self.addSubview(stack)
        return stack
    }()
    lazy var thirdStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [attributeSIZCthulhu, attributeEDUCthulhu, attributeMOVCthulhu])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .equalSpacing
        stack.spacing = 15
        self.addSubview(stack)
        return stack
    }()
    init() {
        super.init(frame: .zero)
        configureLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func configureLayout() {
        NSLayoutConstraint.activate([
            // Incluir botão de editar depois bem aqui

            firstStack.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: -0),
            firstStack.topAnchor.constraint(equalTo: self.topAnchor, constant: 15),

            secondStack.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: -0),
            secondStack.topAnchor.constraint(equalTo: firstStack.bottomAnchor, constant: 15),

            thirdStack.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: -0),
            thirdStack.topAnchor.constraint(equalTo: secondStack.bottomAnchor, constant: 15)
            ])

    }
}
