//
//  CharacterSkillsCell.swift
//  MimicRPG
//
//  Created by Eduardo Oliveira on 24/09/21.
//

import Foundation
import UIKit
class CharacterSkillsCell: UITableViewCell {

    var isChecked: Bool = false
    var total: Int = 0
    var other: Int = 0
    var modAttribute: Int = 0
    var attribute: String = "CON"
    var levelBy2: Int = 0

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor(named: "Brandy")
        self.selectionStyle = .none
        self.tintColor = UIColor(named: "Azure")
        contentView.isUserInteractionEnabled = true
        configureLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    lazy var checkbox: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        addSubview(view)
        return view
    }()

    lazy var checkmark: UIImageView = {
        let imageView = UIImageView()
        imageView.isHidden = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = UIColor(named: "Ivory")
        imageView.image = UIImage(systemName: "checkmark")
        addSubview(imageView)
        return imageView
    }()

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .ivory
        label.font = UIFont.josefinSansBold17()
        label.sizeToFit()
        self.addSubview(label)
        return label
    }()

    lazy var totalBox: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: "Brandy")
        self.addSubview(view)
        return view
    }()

    lazy var diceImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "dice_t20")
        self.addSubview(imageView)
        return imageView
    }()

    lazy var totalLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .ivory
        label.font = UIFont.josefinSansBold30()
        label.text = "+\(total)"
        label.sizeToFit()
        self.addSubview(label)
        return label
    }()

    lazy var totalLeftBar: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        self.addSubview(view)
        return view
    }()

    lazy var otherBox: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: "LightBrandy")
        self.addSubview(view)
        return view
    }()

    lazy var otherLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.josefinSansSemiBold24()
        label.text = "\(other)"
        label.sizeToFit()
        self.addSubview(label)
        return label
    }()

    lazy var otherLeftBar: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        self.addSubview(view)
        return view
    }()

    lazy var modAttributeBox: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: "LightBrandy")
        self.addSubview(view)
        return view
    }()

    lazy var modAttributeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.josefinSansSemiBold24()
        label.text = "\(modAttribute)"
        label.sizeToFit()
        self.addSubview(label)
        return label
    }()

    lazy var modAttributeDesc: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.josefinSansDetail9()
        label.text = "\(attribute)"
        label.sizeToFit()
        self.addSubview(label)
        return label
    }()

    lazy var modAttributeLeftBar: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        self.addSubview(view)
        return view
    }()

    lazy var levelBy2Box: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: "LightBrandy")
        self.addSubview(view)
        return view
    }()

    lazy var levelBy2Label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.josefinSansSemiBold24()
        label.text = "\(levelBy2)"
        label.sizeToFit()
        self.addSubview(label)
        return label
    }()

    lazy var levelBy2LeftBar: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        self.addSubview(view)
        return view
    }()

    lazy var topBar: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.alpha = 0.3
        self.addSubview(view)
        return view
    }()

    lazy var bottomBar: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        view.alpha = 0.3
        self.addSubview(view)
        return view
    }()

    func set( titleItem: String, active: Bool, other: Int, modAttribute: Int, attribute: String, levelBy2: Int) {
        titleLabel.text = titleItem
        isChecked = !active
        checkmark.isHidden = !isChecked
        self.other = other
        self.modAttribute = modAttribute
        self.levelBy2 = levelBy2
        self.attribute = attribute
        self.total = other + modAttribute + levelBy2 + (isChecked ? 2 : 0)
        otherLabel.text = "\(self.other)"
        modAttributeLabel.text = "\(self.modAttribute)"
        modAttributeDesc.text = "\(self.attribute)"
        levelBy2Label.text = "\(self.levelBy2)"
        totalLabel.text = "\(self.total)"
        checkbox.addTarget(self, action: #selector(didTapCheckbox), for: .touchUpInside)
    }

    @objc func didTapCheckbox () {
        self.isChecked = !isChecked
        checkmark.isHidden = !isChecked
        total = other + modAttribute + levelBy2 + (isChecked ? 2 : 0)
        totalLabel.text = "\(total)"
    }
}

extension CharacterSkillsCell {
    private func configureLayout() {
        NSLayoutConstraint.activate([
            checkbox.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            checkbox.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 12),
            checkbox.widthAnchor.constraint(equalToConstant: 20),
            checkbox.heightAnchor.constraint(equalToConstant: 20),

            checkmark.centerXAnchor.constraint(equalTo: checkbox.centerXAnchor),
            checkmark.centerYAnchor.constraint(equalTo: checkbox.centerYAnchor),

            totalBox.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            totalBox.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            totalBox.widthAnchor.constraint(equalToConstant: 62),
            totalBox.heightAnchor.constraint(equalToConstant: 55),

            diceImage.centerXAnchor.constraint(equalTo: totalBox.centerXAnchor),
            diceImage.centerYAnchor.constraint(equalTo: totalBox.centerYAnchor),
            diceImage.widthAnchor.constraint(equalToConstant: 43),
            diceImage.heightAnchor.constraint(equalToConstant: 43),

            totalLabel.centerXAnchor.constraint(equalTo: totalBox.centerXAnchor),
            totalLabel.centerYAnchor.constraint(equalTo: totalBox.centerYAnchor),

            totalLeftBar.trailingAnchor.constraint(equalTo: totalBox.leadingAnchor),
            totalLeftBar.centerYAnchor.constraint(equalTo: totalBox.centerYAnchor),
            totalLeftBar.heightAnchor.constraint(equalToConstant: 55),
            totalLeftBar.widthAnchor.constraint(equalToConstant: 1),

            otherBox.trailingAnchor.constraint(equalTo: totalLeftBar.leadingAnchor),
            otherBox.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            otherBox.widthAnchor.constraint(equalToConstant: 40),
            otherBox.heightAnchor.constraint(equalToConstant: 55),

            otherLabel.centerXAnchor.constraint(equalTo: otherBox.centerXAnchor),
            otherLabel.centerYAnchor.constraint(equalTo: otherBox.centerYAnchor),

            otherLeftBar.trailingAnchor.constraint(equalTo: otherBox.leadingAnchor),
            otherLeftBar.centerYAnchor.constraint(equalTo: otherBox.centerYAnchor),
            otherLeftBar.heightAnchor.constraint(equalToConstant: 55),
            otherLeftBar.widthAnchor.constraint(equalToConstant: 1),

            modAttributeBox.trailingAnchor.constraint(equalTo: otherLeftBar.leadingAnchor),
            modAttributeBox.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            modAttributeBox.widthAnchor.constraint(equalToConstant: 40),
            modAttributeBox.heightAnchor.constraint(equalToConstant: 55),

            modAttributeLabel.centerXAnchor.constraint(equalTo: modAttributeBox.centerXAnchor),
            modAttributeLabel.centerYAnchor.constraint(equalTo: modAttributeBox.centerYAnchor),
            modAttributeDesc.centerXAnchor.constraint(equalTo: modAttributeBox.centerXAnchor),
            modAttributeDesc.bottomAnchor.constraint(equalTo: modAttributeBox.bottomAnchor, constant: -5),

            modAttributeLeftBar.trailingAnchor.constraint(equalTo: modAttributeBox.leadingAnchor),
            modAttributeLeftBar.centerYAnchor.constraint(equalTo: modAttributeBox.centerYAnchor),
            modAttributeLeftBar.heightAnchor.constraint(equalToConstant: 55),
            modAttributeLeftBar.widthAnchor.constraint(equalToConstant: 1),

            levelBy2Box.trailingAnchor.constraint(equalTo: modAttributeLeftBar.leadingAnchor),
            levelBy2Box.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            levelBy2Box.widthAnchor.constraint(equalToConstant: 40),
            levelBy2Box.heightAnchor.constraint(equalToConstant: 55),

            levelBy2Label.centerXAnchor.constraint(equalTo: levelBy2Box.centerXAnchor),
            levelBy2Label.centerYAnchor.constraint(equalTo: levelBy2Box.centerYAnchor),

            levelBy2LeftBar.trailingAnchor.constraint(equalTo: levelBy2Box.leadingAnchor),
            levelBy2LeftBar.centerYAnchor.constraint(equalTo: levelBy2Box.centerYAnchor),
            levelBy2LeftBar.heightAnchor.constraint(equalToConstant: 55),
            levelBy2LeftBar.widthAnchor.constraint(equalToConstant: 1),

            topBar.topAnchor.constraint(equalTo: self.topAnchor),
            topBar.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            topBar.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            topBar.heightAnchor.constraint(equalToConstant: 1),

            bottomBar.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            bottomBar.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            bottomBar.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            bottomBar.heightAnchor.constraint(equalToConstant: 1),

            titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: checkbox.trailingAnchor, constant: 12)
        ])
    }
}
