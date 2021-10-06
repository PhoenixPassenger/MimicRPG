//
//  CharacterPoints.swift
//  MimicRPG
//
//  Created by Eduardo Oliveira on 28/09/21.
//
// swiftlint:disable all

import Foundation
import UIKit

class CharacterPoints: UIView {

    var nameAttribute: String = "DES"
    var valueAttribute: Int = 0
    var valueTemporary: Int = 0
    var valueArmorBonus: Int = 0
    var valueShieldBonus: Int = 0
    var valueOthers: Int = 0
    var valueTotal: Int = 0
    var actualLife: Int = 0
    var maxLife: Int = 0
    var actualMana: Int = 0
    var maxMana: Int = 0

    init() {
        super.init(frame: .zero)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupView(attribute: Int, temporary: Int, armorBonus: Int, shieldBonus: Int, others: Int, lifeActual: Int, lifeMax: Int, manaActual: Int, manaMax: Int) {
        self.backgroundColor = UIColor(named: "Background")
        self.attributeText.text = self.nameAttribute
        self.valueAttribute = attribute
        self.attributeValue.text = "\(self.valueAttribute)"
        self.valueTemporary = temporary
        self.temporaryValue.text = "\(self.valueTemporary)"
        self.valueArmorBonus = armorBonus
        self.armorBonusValue.text = "\(self.valueArmorBonus)"
        self.valueShieldBonus = shieldBonus
        self.shieldBonusValue.text = "\(self.valueShieldBonus)"
        self.valueOthers = others
        self.othersValue.text = "\(self.valueOthers)"
        self.valueTotal = 10 + self.valueAttribute + self.valueTemporary + self.valueArmorBonus + self.valueShieldBonus + self.valueOthers
        self.totalValue.text = "\(self.valueTotal)"
        
        
        configureLayout()

        self.actualLife = lifeActual
        self.maxLife = lifeMax
        self.lifeStepper.maximumValue = Double(self.maxLife)
        self.lifeStepper.value = Double(self.actualLife)
        self.lifeValue.text = "\(self.actualLife)/\(self.maxLife)"
        self.actualMana = manaActual
        self.maxMana = manaMax
        self.manaStepper.maximumValue = Double(maxMana)
        self.manaStepper.value = Double(self.actualMana)
        self.manaValue.text = "\(self.actualMana)/\(self.maxMana)"
    }

    lazy var defenseBox: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "t20_defense")
        self.addSubview(imageView)
        return imageView
    }()

    // MARK: - Base
    lazy var baseBox: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: "LightBrandy")
        self.addSubview(view)
        return view
    }()

    lazy var baseText: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Base"
        label.font = UIFont.josefinSansClassArmorDesc()
        label.textColor = .black
        self.addSubview(label)
        return label
    }()

    lazy var baseValue: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "10"
        label.font = UIFont.josefinSansBold17()
        label.textColor = .black
        self.addSubview(label)
        return label
    }()
    // MARK: - Attribute
    lazy var attributeBox: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: "LightBrandy")
        self.addSubview(view)
        return view
    }()

    lazy var attributeText: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "DEX".localized()
        label.font = UIFont.josefinSansClassArmorDesc()
        label.textColor = .black
        label.layer.zPosition = 2
        self.addSubview(label)
        return label
    }()

    lazy var attributeValue: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "\(valueAttribute)"
        label.font = UIFont.josefinSansBold17()
        label.textColor = .black
        label.layer.zPosition = 2
        self.addSubview(label)
        return label
    }()
    // MARK: - Temporary
    lazy var temporaryBox: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: "LightBrandy")
        self.addSubview(view)
        return view
    }()

    lazy var temporaryText: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Temporary".localized()
        label.font = UIFont.josefinSansClassArmorDesc()
        label.textColor = .black
        self.addSubview(label)
        return label
    }()

    lazy var temporaryValue: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "\(valueTemporary)"
        label.font = UIFont.josefinSansBold17()
        label.textColor = .black
        label.layer.zPosition = 2
        self.addSubview(label)
        return label
    }()
    // MARK: - Armor Bonus
    lazy var armorBonusBox: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: "LightBrandy")
        self.addSubview(view)
        return view
    }()

    lazy var armorBonusText: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "ArmorBonus".localized()
        label.font = UIFont.josefinSansClassArmorDesc()
        label.textColor = .black
        self.addSubview(label)
        return label
    }()

    lazy var armorBonusValue: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "\(valueArmorBonus)"
        label.font = UIFont.josefinSansBold17()
        label.textColor = .black
        label.layer.zPosition = 2
        self.addSubview(label)
        return label
    }()
    // MARK: - Shield Bonus
    lazy var shieldBonusBox: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: "LightBrandy")
        self.addSubview(view)
        return view
    }()

    lazy var shieldBonusText: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "ShieldBonus".localized()
        label.font = UIFont.josefinSansClassArmorDesc()
        label.textColor = .black
        self.addSubview(label)
        return label
    }()

    lazy var shieldBonusValue: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "\(valueShieldBonus)"
        label.font = UIFont.josefinSansBold17()
        label.textColor = .black
        label.layer.zPosition = 2
        self.addSubview(label)
        return label
    }()
    // MARK: - Others
    lazy var othersBox: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: "LightBrandy")
        self.addSubview(view)
        return view
    }()

    lazy var othersText: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Others".localized()
        label.font = UIFont.josefinSansClassArmorDesc()
        label.textColor = .black
        self.addSubview(label)
        return label
    }()

    lazy var othersValue: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "\(valueOthers)"
        label.font = UIFont.josefinSansBold17()
        label.textColor = .black
        label.layer.zPosition = 2
        self.addSubview(label)
        return label
    }()
    // MARK: - LifeBox
     lazy var lifeBox: UIImageView = {
         let imageView = UIImageView()
         imageView.translatesAutoresizingMaskIntoConstraints = false
         imageView.image = UIImage(named: "t20_point")
         imageView.layer.zPosition = 1
         return imageView
     }()

     lazy var lifeText: UILabel = {
         let label = UILabel()
         label.translatesAutoresizingMaskIntoConstraints = false
         label.text = "Life".localized()
         label.font = UIFont.josefinSansBold14()
         label.textColor = .ivory
         self.addSubview(label)
         return label
     }()

     lazy var lifeValue: UILabel = {
         let label = UILabel()
         label.translatesAutoresizingMaskIntoConstraints = false
         label.text = "\(actualLife)/\(maxLife)"
         label.font = UIFont.josefinSansBold30()
         label.textColor = .ivory
         self.addSubview(label)
         label.layer.zPosition = 2
         return label
     }()

     lazy var lifeStepper: UIStepper = {
         let stepper = UIStepper()
         stepper.translatesAutoresizingMaskIntoConstraints = false
         stepper.backgroundColor = UIColor(named: "LightBrandy")
         stepper.addTarget(self, action: #selector(lifeChanged(sender:)), for: .valueChanged)
         stepper.layer.borderWidth = 1
         stepper.layer.zPosition = 2
         stepper.setDecrementImage(stepper.decrementImage(for: .normal), for: .normal)
         stepper.setIncrementImage(stepper.incrementImage(for: .normal), for: .normal)
         stepper.tintColor = .black
         self.addSubview(stepper)
         return stepper
     }()

     @objc func lifeChanged(sender: UIStepper) {
         actualLife = Int(sender.value)
         lifeValue.text = ("\(Int(sender.value))/\(Int(sender.maximumValue))")
     }
     // MARK: - ManaBox
     lazy var manaBox: UIImageView = {
         let imageView = UIImageView()
         imageView.translatesAutoresizingMaskIntoConstraints = false
         imageView.image = UIImage(named: "t20_point")
         imageView.layer.zPosition = 1
         return imageView
     }()

     lazy var manaText: UILabel = {
         let label = UILabel()
         label.translatesAutoresizingMaskIntoConstraints = false
         label.text = "Mana"
         label.font = UIFont.josefinSansBold14()
         label.textColor = .ivory
         self.addSubview(label)
         return label
     }()

     lazy var manaValue: UILabel = {
         let label = UILabel()
         label.translatesAutoresizingMaskIntoConstraints = false
         label.text = "\(actualMana)/\(maxMana)"
         label.font = UIFont.josefinSansBold30()
         label.textColor = .ivory
         self.addSubview(label)
         label.layer.zPosition = 2
         return label
     }()

     lazy var manaStepper: UIStepper = {
         let stepper = UIStepper()
         stepper.translatesAutoresizingMaskIntoConstraints = false
         stepper.backgroundColor = UIColor(named: "LightBrandy")
         stepper.addTarget(self, action: #selector(manaChanged(sender:)), for: .valueChanged)
         stepper.layer.borderWidth = 1
         stepper.layer.zPosition = 2
         stepper.setDecrementImage(stepper.decrementImage(for: .normal), for: .normal)
         stepper.setIncrementImage(stepper.incrementImage(for: .normal), for: .normal)
         stepper.tintColor = .black
         self.addSubview(stepper)
         return stepper
     }()

     @objc func manaChanged(sender: UIStepper) {
         actualMana = Int(sender.value)
         manaValue.text = ("\(Int(sender.value))/\(Int(sender.maximumValue))")
     }

     lazy var stackPoints: UIStackView = {
         let stack = UIStackView(arrangedSubviews: [lifeBox, manaBox])
         stack.translatesAutoresizingMaskIntoConstraints = false
         stack.axis = .horizontal
         stack.alignment = .fill
         stack.distribution = .fillEqually
         stack.spacing = 15
         self.addSubview(stack)
         return stack
     }()
    // MARK: - Total
    lazy var totalBox: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.alpha = 0.2
        self.addSubview(view)
        return view
    }()

    lazy var totalValue: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "\(valueTotal)"
        label.font = UIFont.josefinSansBold30()
        label.textColor = .ivory
        self.addSubview(label)
        label.layer.zPosition = 2
        return label
    }()

    lazy var defenseText: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Defense".localized()
        label.font = UIFont.josefinSansBold14()
        label.textColor = .ivory
        self.addSubview(label)
        return label
    }()

    private func configureLayout() {
        NSLayoutConstraint.activate([
            defenseBox.topAnchor.constraint(equalTo: self.topAnchor, constant: 15),
            defenseBox.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            defenseBox.heightAnchor.constraint(equalToConstant: 109),

            baseBox.topAnchor.constraint(equalTo: defenseBox.topAnchor, constant: 21),
            baseBox.leadingAnchor.constraint(equalTo: defenseBox.leadingAnchor, constant: 7),
            baseBox.widthAnchor.constraint(equalToConstant: 76),
            baseBox.heightAnchor.constraint(equalToConstant: 36),

            baseValue.centerXAnchor.constraint(equalTo: baseBox.centerXAnchor),
            baseValue.centerYAnchor.constraint(equalTo: baseBox.centerYAnchor, constant: -5),
            baseText.centerXAnchor.constraint(equalTo: baseBox.centerXAnchor),
            baseText.centerYAnchor.constraint(equalTo: baseBox.centerYAnchor, constant: 10),

            attributeBox.topAnchor.constraint(equalTo: defenseBox.topAnchor, constant: 21),
            attributeBox.leadingAnchor.constraint(equalTo: baseBox.trailingAnchor, constant: 1),
            attributeBox.widthAnchor.constraint(equalToConstant: 76),
            attributeBox.heightAnchor.constraint(equalToConstant: 36),

            attributeValue.centerXAnchor.constraint(equalTo: attributeBox.centerXAnchor),
            attributeValue.centerYAnchor.constraint(equalTo: attributeBox.centerYAnchor, constant: -5),
            attributeText.centerXAnchor.constraint(equalTo: attributeBox.centerXAnchor),
            attributeText.centerYAnchor.constraint(equalTo: attributeBox.centerYAnchor, constant: 10),

            temporaryBox.topAnchor.constraint(equalTo: defenseBox.topAnchor, constant: 21),
            temporaryBox.leadingAnchor.constraint(equalTo: attributeBox.trailingAnchor, constant: 1),
            temporaryBox.widthAnchor.constraint(equalToConstant: 76),
            temporaryBox.heightAnchor.constraint(equalToConstant: 36),

            temporaryValue.centerXAnchor.constraint(equalTo: temporaryBox.centerXAnchor),
            temporaryValue.centerYAnchor.constraint(equalTo: temporaryBox.centerYAnchor, constant: -5),
            temporaryText.centerXAnchor.constraint(equalTo: temporaryBox.centerXAnchor),
            temporaryText.centerYAnchor.constraint(equalTo: temporaryBox.centerYAnchor, constant: 10),

            armorBonusBox.topAnchor.constraint(equalTo: baseBox.bottomAnchor, constant: 1),
            armorBonusBox.leadingAnchor.constraint(equalTo: defenseBox.leadingAnchor, constant: 7),
            armorBonusBox.widthAnchor.constraint(equalToConstant: 76),
            armorBonusBox.heightAnchor.constraint(equalToConstant: 36),

            armorBonusValue.centerXAnchor.constraint(equalTo: armorBonusBox.centerXAnchor),
            armorBonusValue.centerYAnchor.constraint(equalTo: armorBonusBox.centerYAnchor, constant: -5),
            armorBonusText.centerXAnchor.constraint(equalTo: armorBonusBox.centerXAnchor),
            armorBonusText.centerYAnchor.constraint(equalTo: armorBonusBox.centerYAnchor, constant: 10),

            shieldBonusBox.topAnchor.constraint(equalTo: baseBox.bottomAnchor, constant: 1),
            shieldBonusBox.leadingAnchor.constraint(equalTo: armorBonusBox.trailingAnchor, constant: 1),
            shieldBonusBox.widthAnchor.constraint(equalToConstant: 76),
            shieldBonusBox.heightAnchor.constraint(equalToConstant: 36),

            shieldBonusValue.centerXAnchor.constraint(equalTo: shieldBonusBox.centerXAnchor),
            shieldBonusValue.centerYAnchor.constraint(equalTo: shieldBonusBox.centerYAnchor, constant: -5),
            shieldBonusText.centerXAnchor.constraint(equalTo: shieldBonusBox.centerXAnchor),
            shieldBonusText.centerYAnchor.constraint(equalTo: shieldBonusBox.centerYAnchor, constant: 10),

            othersBox.topAnchor.constraint(equalTo: baseBox.bottomAnchor, constant: 1),
            othersBox.leadingAnchor.constraint(equalTo: shieldBonusBox.trailingAnchor, constant: 1),
            othersBox.widthAnchor.constraint(equalToConstant: 76),
            othersBox.heightAnchor.constraint(equalToConstant: 36),

            othersValue.centerXAnchor.constraint(equalTo: othersBox.centerXAnchor),
            othersValue.centerYAnchor.constraint(equalTo: othersBox.centerYAnchor, constant: -5),
            othersText.centerXAnchor.constraint(equalTo: othersBox.centerXAnchor),
            othersText.centerYAnchor.constraint(equalTo: othersBox.centerYAnchor, constant: 10),

            defenseText.centerXAnchor.constraint(equalTo: attributeBox.centerXAnchor),
            defenseText.centerYAnchor.constraint(equalTo: attributeBox.topAnchor, constant: -10),

            totalBox.bottomAnchor.constraint(equalTo: defenseBox.bottomAnchor),
            totalBox.trailingAnchor.constraint(equalTo: defenseBox.trailingAnchor, constant: -5),
            totalBox.widthAnchor.constraint(equalToConstant: 73),
            totalBox.heightAnchor.constraint(equalToConstant: 91),

            totalValue.centerXAnchor.constraint(equalTo: totalBox.centerXAnchor),
            totalValue.centerYAnchor.constraint(equalTo: totalBox.centerYAnchor, constant: -5),

            stackPoints.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            stackPoints.topAnchor.constraint(equalTo: defenseBox.bottomAnchor, constant: 15),
            stackPoints.leadingAnchor.constraint(equalTo: defenseBox.leadingAnchor),
            stackPoints.trailingAnchor.constraint(equalTo: defenseBox.trailingAnchor),

            lifeText.centerXAnchor.constraint(equalTo: lifeBox.centerXAnchor),
            lifeText.topAnchor.constraint(equalTo: lifeBox.topAnchor, constant: 5),
            lifeValue.centerXAnchor.constraint(equalTo: lifeBox.centerXAnchor),
            lifeValue.centerYAnchor.constraint(equalTo: lifeBox.centerYAnchor),
            lifeStepper.centerXAnchor.constraint(equalTo: lifeBox.centerXAnchor),
            lifeStepper.centerYAnchor.constraint(equalTo: lifeBox.bottomAnchor, constant: -10),

            manaText.centerXAnchor.constraint(equalTo: manaBox.centerXAnchor),
            manaText.topAnchor.constraint(equalTo: manaBox.topAnchor, constant: 5),
            manaValue.centerXAnchor.constraint(equalTo: manaBox.centerXAnchor),
            manaValue.centerYAnchor.constraint(equalTo: manaBox.centerYAnchor),
            manaStepper.centerXAnchor.constraint(equalTo: manaBox.centerXAnchor),
            manaStepper.centerYAnchor.constraint(equalTo: manaBox.bottomAnchor, constant: -10),
        ])
    }
}