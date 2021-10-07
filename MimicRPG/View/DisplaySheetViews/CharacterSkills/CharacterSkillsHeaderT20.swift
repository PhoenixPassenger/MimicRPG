//
//  CharacterSkillsHeader.swift
//  MimicRPG
//
//  Created by Eduardo Oliveira on 25/09/21.
//

import Foundation
import UIKit

class CharacterSkillsHeaderT20: UIView {

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

    lazy var otherBox: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        self.addSubview(view)
        return view
    }()

    lazy var otherLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(named: "FontColor")
        label.font = UIFont.josefinSansSkillDesc()
        label.text = "Others".localized()
        label.sizeToFit()
        self.addSubview(label)
        return label
    }()

    lazy var modAttributeBox: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        self.addSubview(view)
        return view
    }()

    lazy var modAttributeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = UIColor(named: "FontColor")
        label.font = UIFont.josefinSansSkillDesc()
        label.text = "AttribMod".localized()
        label.sizeToFit()
        self.addSubview(label)
        return label
    }()

    lazy var levelby2Box: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        self.addSubview(view)
        return view
    }()

    lazy var levelby2Label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = UIColor(named: "FontColor")
        label.font = UIFont.josefinSansSkillDesc()
        label.text = "LevelBy2".localized()
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

            otherBox.trailingAnchor.constraint(equalTo: totalBox.leadingAnchor),
            otherBox.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            otherBox.widthAnchor.constraint(equalToConstant: 40),
            otherBox.heightAnchor.constraint(equalToConstant: 38),

            otherLabel.centerXAnchor.constraint(equalTo: otherBox.centerXAnchor),
            otherLabel.centerYAnchor.constraint(equalTo: otherBox.centerYAnchor),

            modAttributeBox.trailingAnchor.constraint(equalTo: otherBox.leadingAnchor),
            modAttributeBox.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            modAttributeBox.widthAnchor.constraint(equalToConstant: 40),
            modAttributeBox.heightAnchor.constraint(equalToConstant: 38),

            modAttributeLabel.centerXAnchor.constraint(equalTo: modAttributeBox.centerXAnchor),
            modAttributeLabel.centerYAnchor.constraint(equalTo: modAttributeBox.centerYAnchor),

            levelby2Box.trailingAnchor.constraint(equalTo: modAttributeBox.leadingAnchor),
            levelby2Box.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            levelby2Box.widthAnchor.constraint(equalToConstant: 40),
            levelby2Box.heightAnchor.constraint(equalToConstant: 38),

            levelby2Label.centerXAnchor.constraint(equalTo: levelby2Box.centerXAnchor),
            levelby2Label.centerYAnchor.constraint(equalTo: levelby2Box.centerYAnchor),

            titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 12)
        ])
    }
}
