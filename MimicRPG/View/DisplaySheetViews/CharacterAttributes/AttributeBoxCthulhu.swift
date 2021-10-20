//
//  AttributeCthulhu.swift
//  MimicRPG
//
//  Created by Eduardo Oliveira on 05/10/21.
//

import UIKit

class AttributeBoxCthulhu: UIView {

    lazy var attributeBackgroundCthulhu: UIImageView = {
        let imgView = UIImageView()
        imgView.image = UIImage(named: "CthulhuAttributeBox")
        imgView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(imgView)
        return imgView
    }()
    lazy var attributeLabelCthulhu: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.josefinSansButton()
        // label.sizeToFit()
        self.addSubview(label)
        return label
    }()
    lazy var attributeValueCthulhu: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.josefinSansBold30()
        self.addSubview(label)
        return label
    }()
    lazy var attributeValueBy2Cthulhu: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.josefinSansRegular()
        self.addSubview(label)
        return label
    }()
    lazy var attributeValueBy5Cthulhu: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.josefinSansRegular()
        self.addSubview(label)
        return label
    }()
    init(attribute: String, value: Int, isMovement: Bool = false) {
        super.init(frame: .zero)
        configureLayout()
        attributeLabelCthulhu.text = attribute
        attributeValueCthulhu.text = String(value)
        if isMovement {
            attributeValueBy2Cthulhu.text = "-1"
            attributeValueBy5Cthulhu.text = "+1"
        } else {
            attributeValueBy2Cthulhu.text = "\(Int(value/2))"
            attributeValueBy5Cthulhu.text = "\(Int(value/5))"
        }
    }
    func setAttributeValue(with value: Int, isMovement: Bool = false) {
        attributeValueCthulhu.text = String(value)
        if isMovement {
            attributeValueBy2Cthulhu.text = "-1"
            attributeValueBy5Cthulhu.text = "+1"
        } else {
            attributeValueBy2Cthulhu.text = "\(Int(value/2))"
            attributeValueBy5Cthulhu.text = "\(Int(value/5))"
        }
    }

    private func configureLayout() {
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalTo: attributeBackgroundCthulhu.heightAnchor),
            self.widthAnchor.constraint(equalTo: attributeBackgroundCthulhu.widthAnchor),
            attributeBackgroundCthulhu.topAnchor.constraint(equalTo: self.topAnchor),

            attributeLabelCthulhu.topAnchor.constraint(equalTo: attributeBackgroundCthulhu.topAnchor, constant: 7),
            attributeLabelCthulhu.centerXAnchor.constraint(equalTo: attributeBackgroundCthulhu.centerXAnchor),

            attributeValueCthulhu.centerYAnchor.constraint(equalTo: attributeBackgroundCthulhu.centerYAnchor, constant: -5),
            attributeValueCthulhu.centerXAnchor.constraint(equalTo: attributeBackgroundCthulhu.centerXAnchor),

            attributeValueBy2Cthulhu.bottomAnchor.constraint(equalTo: attributeBackgroundCthulhu.bottomAnchor, constant: -10),
            attributeValueBy2Cthulhu.centerXAnchor.constraint(equalTo: attributeBackgroundCthulhu.centerXAnchor, constant: -20),
            attributeValueBy5Cthulhu.bottomAnchor.constraint(equalTo: attributeBackgroundCthulhu.bottomAnchor, constant: -10),
            attributeValueBy5Cthulhu.centerXAnchor.constraint(equalTo: attributeBackgroundCthulhu.centerXAnchor, constant: 20)
        ])
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
