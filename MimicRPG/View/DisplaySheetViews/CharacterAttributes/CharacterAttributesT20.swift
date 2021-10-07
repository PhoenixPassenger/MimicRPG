//
//  CharacterAttributesT20.swift
//  MimicRPG
//
//  Created by Gustavo Lemos on 23/09/21.
//

import UIKit

class CharacterAttributesT20: UIView {

    let attributeFORT20: AttributeBoxT20 = {
        let view = AttributeBoxT20(attribute: "AttributesSTR".localized(), value: 20)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let attributeDEST20: AttributeBoxT20 = {
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
    let attributeSABT20: AttributeBoxT20 = {
        let view = AttributeBoxT20(attribute: "AttributesWIS".localized(), value: 12)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let attributeCART20: AttributeBoxT20 = {
        let view = AttributeBoxT20(attribute: "AttributesCHA".localized(), value: 8)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    lazy var stackPhysical: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [attributeFORT20, attributeDEST20, attributeCONT20])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.spacing = UIScreen.main.bounds.width * 0.03
        stack.distribution = .fillEqually
        self.addSubview(stack)
        return stack
    }()
    lazy var stackMental: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [attributeINTT20, attributeSABT20, attributeCART20])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.spacing = UIScreen.main.bounds.width * 0.03
        stack.distribution = .fillEqually
        self.addSubview(stack)
        return stack
    }()
    init() {
        super.init(frame: .zero)
        self.backgroundColor = UIColor(named: "Background")
        configureLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func configureLayout() {
        NSLayoutConstraint.activate([
            // Incluir botão de editar depois bem aqui

            stackPhysical.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: UIScreen.main.bounds.width * 0.03),
            stackPhysical.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: UIScreen.main.bounds.width * -0.03),
            stackPhysical.topAnchor.constraint(equalTo: self.topAnchor, constant: UIScreen.main.bounds.height * 0.03),

            stackMental.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: UIScreen.main.bounds.width * 0.03),
            stackMental.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: UIScreen.main.bounds.width * -0.03),
            stackMental.topAnchor.constraint(equalTo: stackPhysical.bottomAnchor, constant: UIScreen.main.bounds.height * 0.03)
            ])

    }
}
