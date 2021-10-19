//
//  CharacterPointsCthulhu.swift
//  MimicRPG
//
//  Created by Eduardo Oliveira on 15/10/21.
//
// swiftlint:disable all

import Foundation
import UIKit

class CharacterPointsCthulhu: UIView {
    var viewModel: DisplaySheetViewModelType!
    
    var actualLife: Int = 0
    var maxLife: Int = 0
    var actualMagic: Int = 0
    var maxMagic: Int = 0
    var actualSanity: Int = 0
    var maxSanity: Int = 0
    var actualLuck: Int = 0
    var maxLuck: Int = 0
    
    init() {
        super.init(frame: .zero)
        self.backgroundColor = UIColor(named: "Background")
        configureLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        for point in viewModel.getPoints() {
            switch (point.name) {
            case PointsCthulhu.getPoints(.life)().name:
                self.actualLife = Int(point.actualValue)
                self.maxLife = Int(point.maxValue)
                self.lifeStepper.maximumValue = Double(self.maxLife)
                self.lifeStepper.value = Double(self.actualLife)
                self.lifeValue.text = "\(self.actualLife)/\(self.maxLife)"
            case PointsCthulhu.getPoints(.magic)().name:
                self.actualMagic = Int(point.actualValue)
                self.maxMagic = Int(point.maxValue)
                self.magicStepper.maximumValue = Double(maxMagic)
                self.magicStepper.value = Double(self.actualMagic)
                self.magicValue.text = "\(self.actualMagic)/\(self.maxMagic)"
            case PointsCthulhu.getPoints(.sanity)().name:
                self.actualSanity = Int(point.actualValue)
                self.maxSanity = Int(point.maxValue)
                self.sanityStepper.maximumValue = Double(self.maxSanity)
                self.sanityStepper.value = Double(self.actualSanity)
                self.sanityValue.text = "\(self.actualSanity)/\(self.maxSanity)"
            case PointsCthulhu.getPoints(.luck)().name:
                self.actualLuck = Int(point.actualValue)
                self.maxLuck = Int(point.maxValue)
                self.luckStepper.maximumValue = Double(maxLuck)
                self.luckStepper.value = Double(self.actualLuck)
                self.luckValue.text = "\(self.actualLuck)/\(self.maxLuck)"
            default:
                break
            }
        }
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
        viewModel.callEditPointsCthulhu()
    }
    
    // MARK: - LifeBox
     lazy var lifeBox: UIImageView = {
         let imageView = UIImageView()
         imageView.translatesAutoresizingMaskIntoConstraints = false
         imageView.image = UIImage(named: "cthulhu_point")
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
         stepper.backgroundColor = UIColor(named: "LightShamrock")
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
         viewModel.changePointValue(type: "Life", value: Int(sender.value))
     }
     // MARK: - MagicBox
     lazy var magicBox: UIImageView = {
         let imageView = UIImageView()
         imageView.translatesAutoresizingMaskIntoConstraints = false
         imageView.image = UIImage(named: "cthulhu_point")
         imageView.layer.zPosition = 1
         return imageView
     }()

     lazy var magicText: UILabel = {
         let label = UILabel()
         label.translatesAutoresizingMaskIntoConstraints = false
         label.text = "Magic".localized()
         label.font = UIFont.josefinSansBold14()
         label.textColor = .ivory
         self.addSubview(label)
         return label
     }()

     lazy var magicValue: UILabel = {
         let label = UILabel()
         label.translatesAutoresizingMaskIntoConstraints = false
         label.text = "\(actualMagic)/\(maxMagic)"
         label.font = UIFont.josefinSansBold30()
         label.textColor = .ivory
         self.addSubview(label)
         label.layer.zPosition = 2
         return label
     }()

     lazy var magicStepper: UIStepper = {
         let stepper = UIStepper()
         stepper.translatesAutoresizingMaskIntoConstraints = false
         stepper.backgroundColor = UIColor(named: "LightShamrock")
         stepper.addTarget(self, action: #selector(magicChanged(sender:)), for: .valueChanged)
         stepper.layer.borderWidth = 1
         stepper.layer.zPosition = 2
         stepper.setDecrementImage(stepper.decrementImage(for: .normal), for: .normal)
         stepper.setIncrementImage(stepper.incrementImage(for: .normal), for: .normal)
         stepper.tintColor = .black
         self.addSubview(stepper)
         return stepper
     }()

     @objc func magicChanged(sender: UIStepper) {
         actualMagic = Int(sender.value)
         magicValue.text = ("\(Int(sender.value))/\(Int(sender.maximumValue))")
         viewModel.changePointValue(type: "Magic", value: Int(sender.value))
     }
    // MARK: - First Stack
     lazy var firstStackPoints: UIStackView = {
         let stack = UIStackView(arrangedSubviews: [lifeBox, magicBox])
         stack.translatesAutoresizingMaskIntoConstraints = false
         stack.axis = .horizontal
         stack.alignment = .fill
         stack.distribution = .fillEqually
         stack.spacing = 15
         self.addSubview(stack)
         return stack
     }()
    // MARK: - SanityBox
     lazy var sanityBox: UIImageView = {
         let imageView = UIImageView()
         imageView.translatesAutoresizingMaskIntoConstraints = false
         imageView.image = UIImage(named: "cthulhu_point")
         imageView.layer.zPosition = 1
         return imageView
     }()

     lazy var sanityText: UILabel = {
         let label = UILabel()
         label.translatesAutoresizingMaskIntoConstraints = false
         label.text = "Sanity".localized()
         label.font = UIFont.josefinSansBold14()
         label.textColor = .ivory
         self.addSubview(label)
         return label
     }()

     lazy var sanityValue: UILabel = {
         let label = UILabel()
         label.translatesAutoresizingMaskIntoConstraints = false
         label.text = "\(actualSanity)/\(maxSanity)"
         label.font = UIFont.josefinSansBold30()
         label.textColor = .ivory
         self.addSubview(label)
         label.layer.zPosition = 2
         return label
     }()

     lazy var sanityStepper: UIStepper = {
         let stepper = UIStepper()
         stepper.translatesAutoresizingMaskIntoConstraints = false
         stepper.backgroundColor = UIColor(named: "LightShamrock")
         stepper.addTarget(self, action: #selector(sanityChanged(sender:)), for: .valueChanged)
         stepper.layer.borderWidth = 1
         stepper.layer.zPosition = 2
         stepper.setDecrementImage(stepper.decrementImage(for: .normal), for: .normal)
         stepper.setIncrementImage(stepper.incrementImage(for: .normal), for: .normal)
         stepper.tintColor = .black
         self.addSubview(stepper)
         return stepper
     }()

     @objc func sanityChanged(sender: UIStepper) {
         actualSanity = Int(sender.value)
         sanityValue.text = ("\(Int(sender.value))/\(Int(sender.maximumValue))")
         viewModel.changePointValue(type: "Sanity", value: Int(sender.value))
     }
     // MARK: - LuckBox
     lazy var luckBox: UIImageView = {
         let imageView = UIImageView()
         imageView.translatesAutoresizingMaskIntoConstraints = false
         imageView.image = UIImage(named: "cthulhu_point")
         imageView.layer.zPosition = 1
         return imageView
     }()

     lazy var luckText: UILabel = {
         let label = UILabel()
         label.translatesAutoresizingMaskIntoConstraints = false
         label.text = "Luck".localized()
         label.font = UIFont.josefinSansBold14()
         label.textColor = .ivory
         self.addSubview(label)
         return label
     }()

     lazy var luckValue: UILabel = {
         let label = UILabel()
         label.translatesAutoresizingMaskIntoConstraints = false
         label.text = "\(actualLuck)/\(maxLuck)"
         label.font = UIFont.josefinSansBold30()
         label.textColor = .ivory
         self.addSubview(label)
         label.layer.zPosition = 2
         return label
     }()

     lazy var luckStepper: UIStepper = {
         let stepper = UIStepper()
         stepper.translatesAutoresizingMaskIntoConstraints = false
         stepper.backgroundColor = UIColor(named: "LightShamrock")
         stepper.addTarget(self, action: #selector(luckChanged(sender:)), for: .valueChanged)
         stepper.layer.borderWidth = 1
         stepper.layer.zPosition = 2
         stepper.setDecrementImage(stepper.decrementImage(for: .normal), for: .normal)
         stepper.setIncrementImage(stepper.incrementImage(for: .normal), for: .normal)
         stepper.tintColor = .black
         self.addSubview(stepper)
         return stepper
     }()

     @objc func luckChanged(sender: UIStepper) {
         actualLuck = Int(sender.value)
         luckValue.text = ("\(Int(sender.value))/\(Int(sender.maximumValue))")
         viewModel.changePointValue(type: "Luck", value: Int(sender.value))
     }
    // MARK: - Second Stack
     lazy var secondStackPoints: UIStackView = {
         let stack = UIStackView(arrangedSubviews: [sanityBox, luckBox])
         stack.translatesAutoresizingMaskIntoConstraints = false
         stack.axis = .horizontal
         stack.alignment = .fill
         stack.distribution = .fillEqually
         stack.spacing = 15
         self.addSubview(stack)
         return stack
     }()
    
    private func configureLayout() {
        NSLayoutConstraint.activate([
            editButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 15),
            editButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            editButton.heightAnchor.constraint(equalToConstant: 34),
            
            firstStackPoints.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            firstStackPoints.topAnchor.constraint(equalTo: editButton.bottomAnchor, constant: 15),
            firstStackPoints.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: UIScreen.main.bounds.width * 0.03),
            firstStackPoints.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: UIScreen.main.bounds.width * -0.03),
            firstStackPoints.heightAnchor.constraint(equalToConstant: 100),
            
            lifeText.centerXAnchor.constraint(equalTo: lifeBox.centerXAnchor),
            lifeText.topAnchor.constraint(equalTo: lifeBox.topAnchor, constant: 5),
            lifeValue.centerXAnchor.constraint(equalTo: lifeBox.centerXAnchor),
            lifeValue.centerYAnchor.constraint(equalTo: lifeBox.centerYAnchor),
            lifeStepper.centerXAnchor.constraint(equalTo: lifeBox.centerXAnchor),
            lifeStepper.centerYAnchor.constraint(equalTo: lifeBox.bottomAnchor, constant: -10),

            magicText.centerXAnchor.constraint(equalTo: magicBox.centerXAnchor),
            magicText.topAnchor.constraint(equalTo: magicBox.topAnchor, constant: 5),
            magicValue.centerXAnchor.constraint(equalTo: magicBox.centerXAnchor),
            magicValue.centerYAnchor.constraint(equalTo: magicBox.centerYAnchor),
            magicStepper.centerXAnchor.constraint(equalTo: magicBox.centerXAnchor),
            magicStepper.centerYAnchor.constraint(equalTo: magicBox.bottomAnchor, constant: -10),
            
            secondStackPoints.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            secondStackPoints.topAnchor.constraint(equalTo: firstStackPoints.bottomAnchor, constant: 30),
            secondStackPoints.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: UIScreen.main.bounds.width * 0.03),
            secondStackPoints.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: UIScreen.main.bounds.width * -0.03),
            secondStackPoints.heightAnchor.constraint(equalToConstant: 100),

            sanityText.centerXAnchor.constraint(equalTo: sanityBox.centerXAnchor),
            sanityText.topAnchor.constraint(equalTo: sanityBox.topAnchor, constant: 5),
            sanityValue.centerXAnchor.constraint(equalTo: sanityBox.centerXAnchor),
            sanityValue.centerYAnchor.constraint(equalTo: sanityBox.centerYAnchor),
            sanityStepper.centerXAnchor.constraint(equalTo: sanityBox.centerXAnchor),
            sanityStepper.centerYAnchor.constraint(equalTo: sanityBox.bottomAnchor, constant: -10),

            luckText.centerXAnchor.constraint(equalTo: luckBox.centerXAnchor),
            luckText.topAnchor.constraint(equalTo: luckBox.topAnchor, constant: 5),
            luckValue.centerXAnchor.constraint(equalTo: luckBox.centerXAnchor),
            luckValue.centerYAnchor.constraint(equalTo: luckBox.centerYAnchor),
            luckStepper.centerXAnchor.constraint(equalTo: luckBox.centerXAnchor),
            luckStepper.centerYAnchor.constraint(equalTo: luckBox.bottomAnchor, constant: -10),
        ])
    }
}
