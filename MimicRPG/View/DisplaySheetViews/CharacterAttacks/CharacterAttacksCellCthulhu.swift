//
//  CharacterAttacksCellCthulhu.swift
//  MimicRPG
//
//  Created by Eduardo Oliveira on 15/10/21.
//

import UIKit

class CharacterAttacksCellCthulhu: UITableViewCell {

    var attackName: String = ""
    var damageDice: String = ""
    var attackValue: String = ""
    var attackValueBy2: String = ""
    var attackValueBy5: String = ""
    var attackAmmo: String = ""
    var attackRange: String = ""
    var attackMalfunction: String = ""
    var attackAttacks: String = ""

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.backgroundColor = .clear
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    lazy var cellBackground: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        let color = UIImage.imageWithColor(color: .shamrock)
        view.image = color
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        self.addSubview(view)
        return view
    }()

    lazy var attackNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.josefinSansSemiBold16()
        label.text = attackName
        self.addSubview(label)
        return label
    }()

    lazy var damageValueBackground: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        let color = UIImage.imageWithColor(color: .lightShamrock)
        view.image = color
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        self.addSubview(view)
        return view
    }()

    lazy var damageValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.josefinSansDetail()
        label.textAlignment = .center
        label.textColor = .black
        label.backgroundColor = .clear
        label.text = "DamageCell".localized() + damageDice
        label.textAlignment = .left
        self.addSubview(label)
        return label
    }()

    lazy var attackValueBox: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        self.addSubview(view)
        return view
    }()

    lazy var attackValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.josefinSansDetail()
        label.textAlignment = .center
        label.textColor = .black
        label.backgroundColor = .clear
        label.text = attackValue
        label.layer.zPosition = 2
        self.addSubview(label)
        return label
    }()

    lazy var attackValueBy2Box: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        self.addSubview(view)
        return view
    }()

    lazy var attackValueBy2Label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.josefinSansDetail()
        label.textAlignment = .center
        label.textColor = .black
        label.backgroundColor = .clear
        label.text = attackValueBy2
        label.layer.zPosition = 2
        label.layer.opacity = 0.5
        self.addSubview(label)
        return label
    }()

    lazy var attackValueBy2Divisor: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        let color = UIImage.imageWithColor(color: .black)
        view.image = color
        view.layer.masksToBounds = true
        view.layer.zPosition = 2
        self.addSubview(view)
        return view
    }()

    lazy var attackValueBy5Box: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        self.addSubview(view)
        return view
    }()

    lazy var attackValueBy5Label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.josefinSansDetail()
        label.textAlignment = .center
        label.textColor = .black
        label.backgroundColor = .clear
        label.text = attackValueBy5
        label.layer.zPosition = 2
        label.layer.opacity = 0.5
        self.addSubview(label)
        return label
    }()

    lazy var attackValueBy5Divisor: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        let color = UIImage.imageWithColor(color: .black)
        view.image = color
        view.layer.masksToBounds = true
        view.layer.zPosition = 2
        self.addSubview(view)
        return view
    }()

    lazy var attackValueBackground: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        let color = UIImage.imageWithColor(color: .lightShamrock)
        view.image = color
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        view.layer.zPosition = 1
        self.addSubview(view)
        return view
    }()

    lazy var ammoBackground: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        let color = UIImage.imageWithColor(color: .lightShamrock)
        view.image = color
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        self.addSubview(view)
        return view
    }()

    lazy var ammoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.josefinSansDetail()
        label.textAlignment = .center
        label.textColor = .black
        label.backgroundColor = .clear
        label.text = "AmmoCell".localized() + attackAmmo
        self.addSubview(label)
        return label
    }()

    lazy var attackRangeBackground: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        let color = UIImage.imageWithColor(color: .lightShamrock)
        view.image = color
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        self.addSubview(view)
        return view
    }()

    lazy var attackRangeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.josefinSansDetail()
        label.textAlignment = .center
        label.textColor = .black
        label.backgroundColor = .clear
        label.text = "RangeCell".localized() + attackRange
        self.addSubview(label)
        return label
    }()

    lazy var attackMalfunctionBackground: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        let color = UIImage.imageWithColor(color: .lightShamrock)
        view.image = color
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        self.addSubview(view)
        return view
    }()

    lazy var attackMalfunctionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.josefinSansDetail()
        label.textAlignment = .center
        label.textColor = .black
        label.backgroundColor = .clear
        label.text = "Malfunc.: " + attackMalfunction
        self.addSubview(label)
        return label
    }()

    lazy var attackAttacksBackground: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        let color = UIImage.imageWithColor(color: .lightShamrock)
        view.image = color
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        self.addSubview(view)
        return view
    }()

    lazy var attackAttacksLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.josefinSansDetail()
        label.textAlignment = .center
        label.textColor = .black
        label.backgroundColor = .clear
        label.text = "AttacksCell".localized() + attackAttacks
        self.addSubview(label)
        return label
    }()

    override func draw(_ rect: CGRect) {
        self.layer.borderWidth = 3
        self.layer.cornerRadius = 5
    }

    func set(name: String, damage: String, value: Int, ammo: Int, range: String, malfunction: String, attacks: Int) {
        attackName = name
        damageDice = damage
        attackValue = String(value)
        attackValueBy2 = String(value/2)
        attackValueBy5 = String(value/5)
        attackAmmo = String(ammo)
        attackRange = range
        attackMalfunction = malfunction
        attackAttacks = String(attacks)
        configureLayout()
        self.selectionStyle = .none
        self.layer.backgroundColor = UIColor(named: "Background")?.cgColor
        self.layer.borderColor = UIColor(named: "Background")?.cgColor
        attackNameLabel.text = name
        damageValueLabel.text = "DamageCell".localized() + damageDice
        attackValueLabel.text = attackValue
        attackValueBy2Label.text = attackValueBy2
        attackValueBy5Label.text = attackValueBy5
        ammoLabel.text = "AmmoCell".localized() + attackAmmo
        attackRangeLabel.text = "RangeCell".localized() + attackRange
        attackMalfunctionLabel.text = "Malfunc.: " + attackMalfunction
        attackAttacksLabel.text = attackAttacks
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.contentView.layer.cornerRadius = 13
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    private func configureLayout() {
        NSLayoutConstraint.activate([
            cellBackground.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            cellBackground.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15),
            cellBackground.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            cellBackground.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -12),

            attackNameLabel.leadingAnchor.constraint(equalTo: cellBackground.leadingAnchor, constant: 5),
            attackNameLabel.trailingAnchor.constraint(equalTo: cellBackground.trailingAnchor, constant: -5),
            attackNameLabel.topAnchor.constraint(equalTo: cellBackground.topAnchor, constant: 5),
            attackNameLabel.heightAnchor.constraint(equalToConstant: 28),

            attackValueBox.widthAnchor.constraint(equalToConstant: 28),
            attackValueBox.trailingAnchor.constraint(equalTo: cellBackground.trailingAnchor, constant: -5),
            attackValueBox.topAnchor.constraint(equalTo: attackNameLabel.bottomAnchor, constant: 1),
            attackValueBox.heightAnchor.constraint(equalToConstant: 28),

            attackValueLabel.centerXAnchor.constraint(equalTo: attackValueBox.centerXAnchor),
            attackValueLabel.topAnchor.constraint(equalTo: attackValueBox.topAnchor),
            attackValueLabel.heightAnchor.constraint(equalTo: attackValueBox.heightAnchor),

            attackValueBy2Divisor.centerYAnchor.constraint(equalTo: attackValueBox.centerYAnchor),
            attackValueBy2Divisor.trailingAnchor.constraint(equalTo: attackValueBox.leadingAnchor),
            attackValueBy2Divisor.widthAnchor.constraint(equalToConstant: 1),
            attackValueBy2Divisor.heightAnchor.constraint(equalTo: attackValueBox.heightAnchor),

            attackValueBy2Box.widthAnchor.constraint(equalToConstant: 28),
            attackValueBy2Box.trailingAnchor.constraint(equalTo: attackValueBy2Divisor.leadingAnchor),
            attackValueBy2Box.topAnchor.constraint(equalTo: attackNameLabel.bottomAnchor, constant: 1),
            attackValueBy2Box.heightAnchor.constraint(equalToConstant: 28),

            attackValueBy2Label.centerXAnchor.constraint(equalTo: attackValueBy2Box.centerXAnchor),
            attackValueBy2Label.topAnchor.constraint(equalTo: attackValueBy2Box.topAnchor),
            attackValueBy2Label.heightAnchor.constraint(equalTo: attackValueBy2Box.heightAnchor),

            attackValueBy5Divisor.centerYAnchor.constraint(equalTo: attackValueBox.centerYAnchor),
            attackValueBy5Divisor.trailingAnchor.constraint(equalTo: attackValueBy2Box.leadingAnchor),
            attackValueBy5Divisor.widthAnchor.constraint(equalToConstant: 1),
            attackValueBy5Divisor.heightAnchor.constraint(equalTo: attackValueBox.heightAnchor),

            attackValueBy5Box.widthAnchor.constraint(equalToConstant: 28),
            attackValueBy5Box.trailingAnchor.constraint(equalTo: attackValueBy5Divisor.leadingAnchor),
            attackValueBy5Box.topAnchor.constraint(equalTo: attackNameLabel.bottomAnchor, constant: 1),
            attackValueBy5Box.heightAnchor.constraint(equalToConstant: 28),

            attackValueBy5Label.centerXAnchor.constraint(equalTo: attackValueBy5Box.centerXAnchor),
            attackValueBy5Label.topAnchor.constraint(equalTo: attackValueBy5Box.topAnchor),
            attackValueBy5Label.heightAnchor.constraint(equalTo: attackValueBy5Box.heightAnchor),

            attackValueBackground.leadingAnchor.constraint(equalTo: attackValueBy5Box.leadingAnchor),
            attackValueBackground.trailingAnchor.constraint(equalTo: attackValueBox.trailingAnchor),
            attackValueBackground.topAnchor.constraint(equalTo: attackNameLabel.bottomAnchor, constant: 1),
            attackValueBackground.heightAnchor.constraint(equalToConstant: 28),

            damageValueBackground.leadingAnchor.constraint(equalTo: cellBackground.leadingAnchor, constant: 5),
            damageValueBackground.trailingAnchor.constraint(equalTo: attackValueBy5Box.leadingAnchor, constant: -5),
            damageValueBackground.topAnchor.constraint(equalTo: attackNameLabel.bottomAnchor, constant: 1),
            damageValueBackground.heightAnchor.constraint(equalToConstant: 28),

            damageValueLabel.leadingAnchor.constraint(equalTo: damageValueBackground.leadingAnchor, constant: 5),
            damageValueLabel.topAnchor.constraint(equalTo: damageValueBackground.topAnchor),
            damageValueLabel.heightAnchor.constraint(equalTo: damageValueBackground.heightAnchor),

            ammoBackground.leadingAnchor.constraint(equalTo: cellBackground.leadingAnchor, constant: 5),
            ammoBackground.widthAnchor.constraint(equalTo: cellBackground.widthAnchor, multiplier: 0.5),
            ammoBackground.topAnchor.constraint(equalTo: damageValueBackground.bottomAnchor, constant: 5),
            ammoBackground.heightAnchor.constraint(equalTo: damageValueBackground.heightAnchor),

            ammoLabel.leadingAnchor.constraint(equalTo: ammoBackground.leadingAnchor, constant: 5),
            ammoLabel.topAnchor.constraint(equalTo: ammoBackground.topAnchor),
            ammoLabel.heightAnchor.constraint(equalTo: ammoBackground.heightAnchor),

            attackRangeBackground.leadingAnchor.constraint(equalTo: ammoBackground.trailingAnchor, constant: 5),
            attackRangeBackground.trailingAnchor.constraint(equalTo: cellBackground.trailingAnchor, constant: -5),
            attackRangeBackground.topAnchor.constraint(equalTo: damageValueBackground.bottomAnchor, constant: 5),
            attackRangeBackground.heightAnchor.constraint(equalTo: damageValueBackground.heightAnchor),

            attackRangeLabel.leadingAnchor.constraint(equalTo: attackRangeBackground.leadingAnchor, constant: 5),
            attackRangeLabel.topAnchor.constraint(equalTo: attackRangeBackground.topAnchor),
            attackRangeLabel.heightAnchor.constraint(equalTo: attackRangeBackground.heightAnchor),

            attackMalfunctionBackground.leadingAnchor.constraint(equalTo: cellBackground.leadingAnchor, constant: 5),
            attackMalfunctionBackground.widthAnchor.constraint(equalTo: cellBackground.widthAnchor, multiplier: 0.5),
            attackMalfunctionBackground.topAnchor.constraint(equalTo: ammoBackground.bottomAnchor, constant: 5),
            attackMalfunctionBackground.heightAnchor.constraint(equalTo: damageValueBackground.heightAnchor),

            attackMalfunctionLabel.leadingAnchor.constraint(equalTo: attackMalfunctionBackground.leadingAnchor, constant: 5),
            attackMalfunctionLabel.topAnchor.constraint(equalTo: attackMalfunctionBackground.topAnchor),
            attackMalfunctionLabel.heightAnchor.constraint(equalTo: attackMalfunctionBackground.heightAnchor),

            attackAttacksBackground.leadingAnchor.constraint(equalTo: attackMalfunctionBackground.trailingAnchor, constant: 5),
            attackAttacksBackground.trailingAnchor.constraint(equalTo: cellBackground.trailingAnchor, constant: -5),
            attackAttacksBackground.topAnchor.constraint(equalTo: attackRangeBackground.bottomAnchor, constant: 5),
            attackAttacksBackground.heightAnchor.constraint(equalTo: damageValueBackground.heightAnchor),

            attackAttacksLabel.leadingAnchor.constraint(equalTo: attackAttacksBackground.leadingAnchor, constant: 5),
            attackAttacksLabel.topAnchor.constraint(equalTo: attackAttacksBackground.topAnchor),
            attackAttacksLabel.heightAnchor.constraint(equalTo: attackAttacksBackground.heightAnchor)
        ])
    }
}
