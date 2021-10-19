//
//  AttributeBoxT20.swift
//  MimicRPG
//
//  Created by Gustavo Lemos on 24/09/21.
//

import UIKit

class AttributeBoxT20: UIView {

    lazy var attributeBackgroundT20: UIImageView = {
        let imgView = UIImageView()
        imgView.image = UIImage(named: "T20AttributeBox")
        imgView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(imgView)
        return imgView
    }()
    lazy var attributeLabelT20: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.josefinSansButton()
        // label.sizeToFit()
        self.addSubview(label)
        return label
    }()
    lazy var attributeValueT20: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.josefinSansBold30()
        self.addSubview(label)
        return label
    }()
    lazy var attributeModifierT20: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.josefinSansRegular()
        self.addSubview(label)
        return label
    }()
    init(attribute: String, value: Int) {
        super.init(frame: .zero)
        configureLayout()
        attributeLabelT20.text = attribute
        attributeValueT20.text = String(value)
        // Adicionar o sinal do modificador
        if (value>9) {
            attributeModifierT20.text = "+" + String((value-10)/2)

        } else {
            attributeModifierT20.text = String((value-10)/2)
        }
    }

    func setAttributeValue(with value: Int) {
        attributeValueT20.text = String(value)
        if (value>9) {
            attributeModifierT20.text = "+" + String((value-10)/2)

        } else {
            attributeModifierT20.text = String((value-10)/2)
        }
    }

    private func configureLayout() {
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalTo: attributeBackgroundT20.heightAnchor),
            self.widthAnchor.constraint(equalTo: attributeBackgroundT20.widthAnchor),
            attributeBackgroundT20.topAnchor.constraint(equalTo: self.topAnchor),

            attributeLabelT20.topAnchor.constraint(equalTo: attributeBackgroundT20.topAnchor, constant: 7),
            attributeLabelT20.centerXAnchor.constraint(equalTo: attributeBackgroundT20.centerXAnchor),

            attributeValueT20.centerYAnchor.constraint(equalTo: attributeBackgroundT20.centerYAnchor,constant: -12),
            attributeValueT20.centerXAnchor.constraint(equalTo: attributeBackgroundT20.centerXAnchor),

            attributeModifierT20.bottomAnchor.constraint(equalTo: attributeBackgroundT20.bottomAnchor, constant: -23),
            attributeModifierT20.centerXAnchor.constraint(equalTo: attributeBackgroundT20.centerXAnchor)
        ])
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
