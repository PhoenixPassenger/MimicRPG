//
//  CharacterAttributesT20.swift
//  MimicRPG
//
//  Created by Gustavo Lemos on 23/09/21.
//

import UIKit

class CharacterAttributesT20: UIView {
    var viewModel: DisplaySheetViewModelType!

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
        viewModel.callEditAttributes()
    }

    let attributeSTRT20: AttributeBoxT20 = {
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
        let stack = UIStackView(arrangedSubviews: [attributeSTRT20, attributeDEST20, attributeCONT20])
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

    func setupView() {
//        for attribute in viewModel.getAttributes() {
//            print(attribute.name)
//        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func configureLayout() {
        NSLayoutConstraint.activate([
            editButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 15),
            editButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            editButton.heightAnchor.constraint(equalToConstant: 34),

            stackPhysical.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: UIScreen.main.bounds.width * 0.03),
            stackPhysical.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: UIScreen.main.bounds.width * -0.03),
            stackPhysical.topAnchor.constraint(equalTo: editButton.bottomAnchor, constant: 15),

            stackMental.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: UIScreen.main.bounds.width * 0.03),
            stackMental.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: UIScreen.main.bounds.width * -0.03),
            stackMental.topAnchor.constraint(equalTo: stackPhysical.bottomAnchor, constant: UIScreen.main.bounds.height * 0.03)
        ])
    }
}
