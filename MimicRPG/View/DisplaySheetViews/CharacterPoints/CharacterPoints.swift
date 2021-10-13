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
    var viewModel: DisplaySheetViewModelType!

    var nameAttribute: String = "DEX".localized()
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

    func setupView() {
        self.backgroundColor = UIColor(named: "Background")
        self.attributeText.text = self.nameAttribute
        
        let attribute = viewModel.getAttributes().filter{ $0.abbreviation == "DEX" }.first
        self.valueAttribute = Int((attribute!.value - 10)/2)
        self.attributeValue.text = "\(self.valueAttribute)"
        
        let temporary = viewModel.getPoints().filter{ $0.name == "ClassArmorTemporary" }.first
        self.valueTemporary = Int(temporary!.actualValue)
        self.temporaryValue.text = "\(self.valueTemporary)"
        
        let armorBonus = viewModel.getPoints().filter{ $0.name == "ArmorBonus" }.first
        self.valueArmorBonus = Int(armorBonus!.actualValue)
        self.armorBonusValue.text = "\(self.valueArmorBonus)"

        let shieldBonus = viewModel.getPoints().filter{ $0.name == "ShieldBonus" }.first
        self.valueShieldBonus = Int(shieldBonus!.actualValue)
        self.shieldBonusValue.text = "\(self.valueShieldBonus)"

        let others = viewModel.getPoints().filter{ $0.name == "ClassArmorOthers" }.first
        self.valueOthers = Int(others!.actualValue)
        self.othersValue.text = "\(self.valueOthers)"

        self.valueTotal = 10 + self.valueAttribute + self.valueTemporary + self.valueArmorBonus + self.valueShieldBonus + self.valueOthers
        self.totalValue.text = "\(self.valueTotal)"

        configureLayout()

        let life = viewModel.getPoints().filter{ $0.name == "Life" }.first
        self.actualLife = Int(life!.actualValue)
        self.maxLife = Int(life!.maxValue)
        self.lifeStepper.maximumValue = Double(self.maxLife)
        self.lifeStepper.value = Double(self.actualLife)
        self.lifeValue.text = "\(self.actualLife)/\(self.maxLife)"

        let mana = viewModel.getPoints().filter{ $0.name == "Mana" }.first
        self.actualMana = Int(mana!.actualValue)
        self.maxMana = Int(mana!.maxValue)
        self.manaStepper.maximumValue = Double(maxMana)
        self.manaStepper.value = Double(self.actualMana)
        self.manaValue.text = "\(self.actualMana)/\(self.maxMana)"
    }
    
    lazy var editButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.frame = CGRect(x: UIScreen.main.bounds.width * 0.9, y: 0, width: 30, height: 30)
        button.setTitle("Edit".localized(), for: .normal)
        button.setTitleColor(UIColor(named: "Azure"), for: .normal)
        button.addTarget(self, action: #selector(self.editPoints), for: .touchUpInside)
        self.addSubview(button)
        return button
    }()

    @objc func editPoints() {
        viewModel.callEditPoints()
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
            editButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 15),
            editButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            editButton.heightAnchor.constraint(equalToConstant: 34),
            
            defenseBox.topAnchor.constraint(equalTo: editButton.bottomAnchor, constant: 15),
            defenseBox.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            defenseBox.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            defenseBox.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            defenseBox.heightAnchor.constraint(equalToConstant: 109),

            baseBox.topAnchor.constraint(equalTo: defenseBox.topAnchor, constant: 21),
            baseBox.leadingAnchor.constraint(equalTo: defenseBox.leadingAnchor, constant: UIScreen.main.bounds.width * 0.022),
            baseBox.widthAnchor.constraint(equalTo: defenseBox.widthAnchor, multiplier: 0.23),
            baseBox.heightAnchor.constraint(equalToConstant: 36),

            baseValue.centerXAnchor.constraint(equalTo: baseBox.centerXAnchor),
            baseValue.centerYAnchor.constraint(equalTo: baseBox.centerYAnchor, constant: -5),
            baseText.centerXAnchor.constraint(equalTo: baseBox.centerXAnchor),
            baseText.centerYAnchor.constraint(equalTo: baseBox.centerYAnchor, constant: 10),

            attributeBox.topAnchor.constraint(equalTo: defenseBox.topAnchor, constant: 21),
            attributeBox.leadingAnchor.constraint(equalTo: baseBox.trailingAnchor, constant: 1),
            attributeBox.widthAnchor.constraint(equalTo: defenseBox.widthAnchor, multiplier: 0.23),
            attributeBox.heightAnchor.constraint(equalToConstant: 36),

            attributeValue.centerXAnchor.constraint(equalTo: attributeBox.centerXAnchor),
            attributeValue.centerYAnchor.constraint(equalTo: attributeBox.centerYAnchor, constant: -5),
            attributeText.centerXAnchor.constraint(equalTo: attributeBox.centerXAnchor),
            attributeText.centerYAnchor.constraint(equalTo: attributeBox.centerYAnchor, constant: 10),

            temporaryBox.topAnchor.constraint(equalTo: defenseBox.topAnchor, constant: 21),
            temporaryBox.leadingAnchor.constraint(equalTo: attributeBox.trailingAnchor, constant: 1),
            temporaryBox.widthAnchor.constraint(equalTo: defenseBox.widthAnchor, multiplier: 0.23),
            temporaryBox.heightAnchor.constraint(equalToConstant: 36),

            temporaryValue.centerXAnchor.constraint(equalTo: temporaryBox.centerXAnchor),
            temporaryValue.centerYAnchor.constraint(equalTo: temporaryBox.centerYAnchor, constant: -5),
            temporaryText.centerXAnchor.constraint(equalTo: temporaryBox.centerXAnchor),
            temporaryText.centerYAnchor.constraint(equalTo: temporaryBox.centerYAnchor, constant: 10),

            armorBonusBox.topAnchor.constraint(equalTo: baseBox.bottomAnchor, constant: 1),
            armorBonusBox.leadingAnchor.constraint(equalTo: baseBox.leadingAnchor),
            armorBonusBox.widthAnchor.constraint(equalTo: baseBox.widthAnchor),
            armorBonusBox.heightAnchor.constraint(equalToConstant: 36),

            armorBonusValue.centerXAnchor.constraint(equalTo: armorBonusBox.centerXAnchor),
            armorBonusValue.centerYAnchor.constraint(equalTo: armorBonusBox.centerYAnchor, constant: -5),
            armorBonusText.centerXAnchor.constraint(equalTo: armorBonusBox.centerXAnchor),
            armorBonusText.centerYAnchor.constraint(equalTo: armorBonusBox.centerYAnchor, constant: 10),

            shieldBonusBox.topAnchor.constraint(equalTo: baseBox.bottomAnchor, constant: 1),
            shieldBonusBox.leadingAnchor.constraint(equalTo: armorBonusBox.trailingAnchor, constant: 1),
            shieldBonusBox.widthAnchor.constraint(equalTo: attributeBox.widthAnchor),
            shieldBonusBox.heightAnchor.constraint(equalToConstant: 36),

            shieldBonusValue.centerXAnchor.constraint(equalTo: shieldBonusBox.centerXAnchor),
            shieldBonusValue.centerYAnchor.constraint(equalTo: shieldBonusBox.centerYAnchor, constant: -5),
            shieldBonusText.centerXAnchor.constraint(equalTo: shieldBonusBox.centerXAnchor),
            shieldBonusText.centerYAnchor.constraint(equalTo: shieldBonusBox.centerYAnchor, constant: 10),

            othersBox.topAnchor.constraint(equalTo: baseBox.bottomAnchor, constant: 1),
            othersBox.leadingAnchor.constraint(equalTo: shieldBonusBox.trailingAnchor, constant: 1),
            othersBox.widthAnchor.constraint(equalTo: temporaryBox.widthAnchor),
            othersBox.heightAnchor.constraint(equalToConstant: 36),

            othersValue.centerXAnchor.constraint(equalTo: othersBox.centerXAnchor),
            othersValue.centerYAnchor.constraint(equalTo: othersBox.centerYAnchor, constant: -5),
            othersText.centerXAnchor.constraint(equalTo: othersBox.centerXAnchor),
            othersText.centerYAnchor.constraint(equalTo: othersBox.centerYAnchor, constant: 10),

            defenseText.centerXAnchor.constraint(equalTo: attributeBox.centerXAnchor),
            defenseText.centerYAnchor.constraint(equalTo: attributeBox.topAnchor, constant: -10),

            totalBox.centerYAnchor.constraint(equalTo: defenseBox.centerYAnchor),
            totalBox.leadingAnchor.constraint(equalTo: othersBox.trailingAnchor, constant: 15),
            totalBox.trailingAnchor.constraint(equalTo: defenseBox.trailingAnchor, constant: -5),
            totalBox.heightAnchor.constraint(equalToConstant: 80),

            totalValue.centerXAnchor.constraint(equalTo: totalBox.centerXAnchor),
            totalValue.centerYAnchor.constraint(equalTo: totalBox.centerYAnchor, constant: 5),

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
