//
//  CharacterSkillsCellCthulhu.swift
//  MimicRPG
//
//  Created by Eduardo Oliveira on 05/10/21.
//

import Foundation
import UIKit
class CharacterSkillsCellCthulhu: UITableViewCell {

    var isChecked: Bool = false
    var value: Int = 0

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor(named: "Shamrock")
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
        view.backgroundColor = UIColor(named: "Shamrock")
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
        label.text = "+\(value)"
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

    lazy var totalBy5Box: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: "LightShamrock")
        self.addSubview(view)
        return view
    }()

    lazy var totalBy5Label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.josefinSansSemiBold24()
        label.text = "\(Int(self.value/5))"
        label.sizeToFit()
        self.addSubview(label)
        return label
    }()

    lazy var totalBy5LeftBar: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        self.addSubview(view)
        return view
    }()

    lazy var totalBy2Box: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: "LightShamrock")
        self.addSubview(view)
        return view
    }()

    lazy var totalBy2Label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.josefinSansSemiBold24()
        label.text = "\(Int(self.value/2))"
        label.sizeToFit()
        self.addSubview(label)
        return label
    }()

    lazy var totalBy2LeftBar: UIView = {
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

    func set( titleItem: String, active: Bool, value: Int) {
        titleLabel.text = titleItem
        isChecked = !active
        checkmark.isHidden = !isChecked
        self.value = value
        totalBy5Label.text = "\(Int(self.value/5))"
        totalBy2Label.text = "\(Int(self.value/2))"
        totalLabel.text = "\(self.value)"
        checkbox.addTarget(self, action: #selector(didTapCheckbox), for: .touchUpInside)
    }

    @objc func didTapCheckbox () {
        self.isChecked = !isChecked
        checkmark.isHidden = !isChecked
    }
}

extension CharacterSkillsCellCthulhu {
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

            totalBy5Box.trailingAnchor.constraint(equalTo: totalLeftBar.leadingAnchor),
            totalBy5Box.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            totalBy5Box.widthAnchor.constraint(equalToConstant: 40),
            totalBy5Box.heightAnchor.constraint(equalToConstant: 55),

            totalBy5Label.centerXAnchor.constraint(equalTo: totalBy5Box.centerXAnchor),
            totalBy5Label.centerYAnchor.constraint(equalTo: totalBy5Box.centerYAnchor),

            totalBy5LeftBar.trailingAnchor.constraint(equalTo: totalBy5Box.leadingAnchor),
            totalBy5LeftBar.centerYAnchor.constraint(equalTo: totalBy5Box.centerYAnchor),
            totalBy5LeftBar.heightAnchor.constraint(equalToConstant: 55),
            totalBy5LeftBar.widthAnchor.constraint(equalToConstant: 1),

            totalBy2Box.trailingAnchor.constraint(equalTo: totalBy5LeftBar.leadingAnchor),
            totalBy2Box.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            totalBy2Box.widthAnchor.constraint(equalToConstant: 40),
            totalBy2Box.heightAnchor.constraint(equalToConstant: 55),

            totalBy2Label.centerXAnchor.constraint(equalTo: totalBy2Box.centerXAnchor),
            totalBy2Label.centerYAnchor.constraint(equalTo: totalBy2Box.centerYAnchor),

            totalBy2LeftBar.trailingAnchor.constraint(equalTo: totalBy2Box.leadingAnchor),
            totalBy2LeftBar.centerYAnchor.constraint(equalTo: totalBy2Box.centerYAnchor),
            totalBy2LeftBar.heightAnchor.constraint(equalToConstant: 55),
            totalBy2LeftBar.widthAnchor.constraint(equalToConstant: 1),

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

