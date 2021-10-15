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

    lazy var attackValueBackground: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        let color = UIImage.imageWithColor(color: .lightShamrock)
        view.image = color
        view.layer.cornerRadius = 5
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
        label.text = "AttackBonusCell".localized() + attackValue
        self.addSubview(label)
        return label
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
        label.text = "DamageTypeCell".localized() + attackAmmo
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
        label.text = "ReachCell".localized() + attackRange
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
        label.text = "CriticalCell".localized() + attackMalfunction
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
        label.text = "CriticalCell".localized() + attackAttacks
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
        attackAmmo = String(ammo)
        attackRange = range
        attackMalfunction = malfunction
        attackAttacks = String(attacks)
        configureLayout()
        self.selectionStyle = .none
        self.layer.backgroundColor = UIColor(named: "Background")?.cgColor
        self.layer.borderColor = UIColor(named: "Background")?.cgColor
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

            damageValueBackground.leadingAnchor.constraint(equalTo: cellBackground.leadingAnchor, constant: 5),
            damageValueBackground.widthAnchor.constraint(equalTo: cellBackground.widthAnchor, multiplier: 0.5),
            damageValueBackground.topAnchor.constraint(equalTo: attackNameLabel.bottomAnchor, constant: 1),
            damageValueBackground.heightAnchor.constraint(equalToConstant: 28),

            damageValueLabel.leadingAnchor.constraint(equalTo: damageValueBackground.leadingAnchor, constant: 5),
            damageValueLabel.topAnchor.constraint(equalTo: damageValueBackground.topAnchor),
            damageValueLabel.heightAnchor.constraint(equalTo: damageValueBackground.heightAnchor),
            
            attackValueBackground.leadingAnchor.constraint(equalTo: damageValueBackground.trailingAnchor, constant: 5),
            attackValueBackground.trailingAnchor.constraint(equalTo: cellBackground.trailingAnchor, constant: -5),
            attackValueBackground.topAnchor.constraint(equalTo: attackNameLabel.bottomAnchor, constant: 1),
            attackValueBackground.heightAnchor.constraint(equalToConstant: 28),

            attackValueLabel.leadingAnchor.constraint(equalTo: attackValueBackground.leadingAnchor, constant: 5),
            attackValueLabel.topAnchor.constraint(equalTo: attackValueBackground.topAnchor),
            attackValueLabel.heightAnchor.constraint(equalTo: attackValueBackground.heightAnchor),

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

