//
//  CharacterBioCell.swift
//  MimicRPG
//
//  Created by Rodrigo Silva Ribeiro on 21/09/21.
//

import Foundation
import UIKit
class CharacterBioCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .systemBackground
        self.selectionStyle = .none
        self.tintColor = .blue
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Properties
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .blue
        label.font = UIFont.josefinSansBold17()
        label.sizeToFit()
        self.addSubview(label)
        return label
    }()

    lazy var valueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .darkText
        label.font = UIFont.josefinSansBold14()
        label.numberOfLines = 0
        label.sizeToFit()
        self.addSubview(label)
        return label
    }()

    lazy var stack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [titleLabel, valueLabel])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.alignment = .fill
        stack.spacing = 5
        stack.sizeToFit()
        self.addSubview(stack)
        return stack
    }()

    func set( titleItem: String, valueItem: String) {
        titleLabel.text = titleItem
        valueLabel.text = valueItem
    }

}
extension CharacterBioCell {
    private func setupUI() {
        NSLayoutConstraint.activate([
            stack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            stack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            stack.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            stack.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8)
//            valueLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
}
