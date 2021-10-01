//
//  CharacterAttributesT20.swift
//  MimicRPG
//
//  Created by Gustavo Lemos on 23/09/21.
//

import UIKit

class CharacterAttributesT20: UIView {

    let attributeFORT20: AttributeBoxT20 = {
        let view = AttributeBoxT20(attribute: "FOR", value: 20)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let attributeDEST20: AttributeBoxT20 = {
        let view = AttributeBoxT20(attribute: "DES", value: 18)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let attributeCONT20: AttributeBoxT20 = {
        let view = AttributeBoxT20(attribute: "CON", value: 16)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let attributeINTT20: AttributeBoxT20 = {
        let view = AttributeBoxT20(attribute: "INT", value: 14)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let attributeSABT20: AttributeBoxT20 = {
        let view = AttributeBoxT20(attribute: "SAB", value: 12)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let attributeCART20: AttributeBoxT20 = {
        let view = AttributeBoxT20(attribute: "CAR", value: 8)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    lazy var stackPhysical: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [attributeFORT20, attributeDEST20, attributeCONT20])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fillEqually
        stack.spacing = 15
        self.addSubview(stack)
        return stack
    }()
    lazy var stackMental: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [attributeINTT20, attributeSABT20, attributeCART20])
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
            //Incluir botão de editar depois bem aqui

            stackPhysical.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: -0),
            stackPhysical.topAnchor.constraint(equalTo: self.topAnchor, constant: 15),

            stackMental.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: -0),
            stackMental.topAnchor.constraint(equalTo: stackPhysical.bottomAnchor, constant: 60)
            ])

    }
}
