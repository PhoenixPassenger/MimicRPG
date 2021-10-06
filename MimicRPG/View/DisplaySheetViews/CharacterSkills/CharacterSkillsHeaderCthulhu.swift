//
//  CharacterSkillsHeaderCthulhu.swift
//  MimicRPG
//
//  Created by Eduardo Oliveira on 05/10/21.
//

import Foundation
import UIKit

class CharacterSkillsHeaderCthulhu: UIView {

    init() {
        super.init(frame: .zero)
        self.backgroundColor = UIColor(named: "Background")
        configureLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(named: "FontColor")
        label.font = UIFont.josefinSansSkillDesc()
        label.text = "Name".localized()
        label.sizeToFit()
        self.addSubview(label)
        return label
    }()

    lazy var totalBox: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        self.addSubview(view)
        return view
    }()

    lazy var totalLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(named: "FontColor")
        label.font = UIFont.josefinSansSkillDesc()
        label.text = "Total"
        label.sizeToFit()
        self.addSubview(label)
        return label
    }()

    lazy var totalBy5Box: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        self.addSubview(view)
        return view
    }()

    lazy var totalBy5Label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = UIColor(named: "FontColor")
        label.font = UIFont.josefinSansSkillDesc()
        label.text = "Total\n/5"
        label.sizeToFit()
        self.addSubview(label)
        return label
    }()

    lazy var totalBy2Box: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        self.addSubview(view)
        return view
    }()

    lazy var totalBy2Label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = UIColor(named: "FontColor")
        label.font = UIFont.josefinSansSkillDesc()
        label.text = "Total\n/2"
        label.sizeToFit()
        self.addSubview(label)
        return label
    }()

    private func configureLayout() {
        NSLayoutConstraint.activate([
            totalBox.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            totalBox.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            totalBox.widthAnchor.constraint(equalToConstant: 62),
            totalBox.heightAnchor.constraint(equalToConstant: 38),

            totalLabel.centerXAnchor.constraint(equalTo: totalBox.centerXAnchor),
            totalLabel.centerYAnchor.constraint(equalTo: totalBox.centerYAnchor),

            totalBy5Box.trailingAnchor.constraint(equalTo: totalBox.leadingAnchor),
            totalBy5Box.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            totalBy5Box.widthAnchor.constraint(equalToConstant: 40),
            totalBy5Box.heightAnchor.constraint(equalToConstant: 38),

            totalBy5Label.centerXAnchor.constraint(equalTo: totalBy5Box.centerXAnchor),
            totalBy5Label.centerYAnchor.constraint(equalTo: totalBy5Box.centerYAnchor),

            totalBy2Box.trailingAnchor.constraint(equalTo: totalBy5Box.leadingAnchor),
            totalBy2Box.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            totalBy2Box.widthAnchor.constraint(equalToConstant: 40),
            totalBy2Box.heightAnchor.constraint(equalToConstant: 38),

            totalBy2Label.centerXAnchor.constraint(equalTo: totalBy2Box.centerXAnchor),
            totalBy2Label.centerYAnchor.constraint(equalTo: totalBy2Box.centerYAnchor),

            titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 12)
        ])
    }
}

