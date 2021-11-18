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
        self.backgroundColor = UIColor(named: "Background")
        self.selectionStyle = .none
        self.tintColor = UIColor(named: "Azure")
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Properties
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(named: "Azure")
        label.font = UIFontMetrics(forTextStyle: .headline).scaledFont(for: .josefinSansBold17())
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 2
        label.sizeToFit()
        self.addSubview(label)
        return label
    }()

    lazy var valueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(named: "FontColor")
        label.font = UIFontMetrics(forTextStyle: .subheadline).scaledFont(for: .josefinSansBold14())
        label.numberOfLines = 5
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

    func set( titleItem: String, valueItem: String, isPlaceholder: Bool = false) {
        titleLabel.text = titleItem
        valueLabel.text = valueItem

        if isPlaceholder {
            valueLabel.layer.opacity = 0.5
        } else {
            valueLabel.layer.opacity = 1.0
        }
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
