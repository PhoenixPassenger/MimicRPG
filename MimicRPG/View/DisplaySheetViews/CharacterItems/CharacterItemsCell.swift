//
//  CharacterItemsCell.swift
//  MimicRPG
//
//  Created by Rodrigo Silva Ribeiro on 23/09/21.
//

import Foundation
import UIKit
class CharacterItemsCell: UITableViewCell {

    lazy var itemNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.josefinSansSemiBold16()
        return label
    }()

    lazy var itemUsesBackground: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 5
        view.backgroundColor = .lightBrandy
        return view
    }()

    lazy var itemUsesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.josefinSansDetail()
        label.textAlignment = .center
        label.textColor = .black
        label.backgroundColor = .clear
        label.text = "Uses".localized()
        self.addSubview(label)
        return label
    }()

    lazy var firstStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [itemNameLabel, itemUsesBackground])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 5, right: 0)
        stack.isLayoutMarginsRelativeArrangement = true
        stack.spacing = 15
        return stack
    }()

    lazy var itemDescriptionTextLabel: UITextView = {
        let field = UITextView()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.font = UIFont.josefinSansDetail()
        field.textColor = .black
        field.backgroundColor = .pinkT20
        field.isEditable = false
        field.layer.cornerRadius = 5
        field.textContainer.lineBreakMode = .byWordWrapping
        field.textContainerInset = UIEdgeInsets(top: 3, left: 3, bottom: 3, right: 3)
        return field
    }()

    lazy var stack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [firstStack, itemDescriptionTextLabel])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.alignment = .fill
        stack.spacing = 2
        stack.backgroundColor = .brandy
        stack.layoutMargins = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        stack.isLayoutMarginsRelativeArrangement = true
        stack.layer.cornerRadius = 5
        self.addSubview(stack)
        return stack
    }()

    func set(itemName: String, itemDescription: String, itemUses: Int) {
        configureLayout()
        self.backgroundColor = .clear
        itemNameLabel.text = itemName
        itemDescriptionTextLabel.text = itemDescription
        itemUsesLabel.text = "Uses".localized() + "\(itemUses)"
    }
    private func configureLayout() {
        self.sendSubviewToBack(itemUsesBackground)
        NSLayoutConstraint.activate([
            stack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15),
            stack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            stack.topAnchor.constraint(equalTo: self.topAnchor),
            stack.bottomAnchor.constraint(equalTo: self.bottomAnchor),

            itemUsesBackground.heightAnchor.constraint(equalToConstant: 22),
            itemUsesBackground.widthAnchor.constraint(equalToConstant: 59),

            itemUsesLabel.leadingAnchor.constraint(equalTo: itemUsesBackground.leadingAnchor, constant: 3),
            itemUsesLabel.centerYAnchor.constraint(equalTo: itemUsesBackground.centerYAnchor)
        ])
    }
}
