//
//  CharacterAttacksCell.swift
//  MimicRPG
//
//  Created by Pedro Henrique on 30/09/21.
//

import UIKit

class CharacterAttacksCellT20: UITableViewCell {

    var attackName: String = ""
    var damageDice: String = ""
    var attackBonus: String = ""
    var damageType: String = ""
    var attackReach: String = ""
    var attackCritical: String = ""

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.backgroundColor = .clear
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        print("aaa")
    }

    lazy var cellBackground: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        let color = UIImage.imageWithColor(color: .auburnT20)
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
        let color = UIImage.imageWithColor(color: .pinkT20)
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

    lazy var damageBonusBackground: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        let color = UIImage.imageWithColor(color: .pinkT20)
        view.image = color
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        self.addSubview(view)
        return view
    }()

    lazy var damageBonusLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.josefinSansDetail()
        label.textAlignment = .center
        label.textColor = .black
        label.backgroundColor = .clear
        label.text = "AttackBonusCell".localized() + attackBonus
        self.addSubview(label)
        return label
    }()

    lazy var damageTypeBackground: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        let color = UIImage.imageWithColor(color: .pinkT20)
        view.image = color
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        self.addSubview(view)
        return view
    }()

    lazy var damageTypeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.josefinSansDetail()
        label.textAlignment = .center
        label.textColor = .black
        label.backgroundColor = .clear
        label.text = "DamageTypeCell".localized() + damageType
        self.addSubview(label)
        return label
    }()

    lazy var attackReachBackground: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        let color = UIImage.imageWithColor(color: .pinkT20)
        view.image = color
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        self.addSubview(view)
        return view
    }()

    lazy var attackReachLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.josefinSansDetail()
        label.textAlignment = .center
        label.textColor = .black
        label.backgroundColor = .clear
        label.text = "ReachCell".localized() + attackReach
        self.addSubview(label)
        return label
    }()

    lazy var attackCriticalBackground: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        let color = UIImage.imageWithColor(color: .pinkT20)
        view.image = color
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        self.addSubview(view)
        return view
    }()

    lazy var attackCriticalLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.josefinSansDetail()
        label.textAlignment = .center
        label.textColor = .black
        label.backgroundColor = .clear
        label.text = "CriticalCell".localized() + attackCritical
        self.addSubview(label)
        return label
    }()

    override func draw(_ rect: CGRect) {
        self.layer.borderWidth = 3
        self.layer.cornerRadius = 5
    }

    func set(name: String, damage: String, bonus: Int, type: String, reach: String, critical: String) {
        attackName = name
        damageDice = damage
        attackBonus = String(bonus)
        damageType = type
        attackReach = reach
        attackCritical = critical
        configureLayout()
        self.selectionStyle = .none
        self.layer.backgroundColor = UIColor(named: "Background")?.cgColor
        self.layer.borderColor = UIColor(named: "Background")?.cgColor
        attackNameLabel.text = name
        damageValueLabel.text = "DamageCell".localized() + damage
        damageBonusLabel.text = "AttackBonusCell".localized() + String(bonus)
        damageTypeLabel.text = "DamageTypeCell".localized() + type
        attackReachLabel.text = "ReachCell".localized() + reach
        attackCriticalLabel.text = "CriticalCell".localized() + critical
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
            damageValueBackground.trailingAnchor.constraint(equalTo: cellBackground.trailingAnchor, constant: -5),
            damageValueBackground.topAnchor.constraint(equalTo: attackNameLabel.bottomAnchor, constant: 1),
            damageValueBackground.heightAnchor.constraint(equalToConstant: 28),

            damageValueLabel.leadingAnchor.constraint(equalTo: damageValueBackground.leadingAnchor, constant: 5),
            damageValueLabel.trailingAnchor.constraint(equalTo: damageValueBackground.trailingAnchor, constant: -5),
            damageValueLabel.topAnchor.constraint(equalTo: damageValueBackground.topAnchor),
            damageValueLabel.heightAnchor.constraint(equalTo: damageValueBackground.heightAnchor),

            damageBonusBackground.leadingAnchor.constraint(equalTo: cellBackground.leadingAnchor, constant: 5),
            damageBonusBackground.widthAnchor.constraint(equalTo: cellBackground.widthAnchor, multiplier: 0.5),
            damageBonusBackground.topAnchor.constraint(equalTo: damageValueBackground.bottomAnchor, constant: 5),
            damageBonusBackground.heightAnchor.constraint(equalTo: damageValueBackground.heightAnchor),

            damageBonusLabel.leadingAnchor.constraint(equalTo: damageBonusBackground.leadingAnchor, constant: 5),
            damageBonusLabel.topAnchor.constraint(equalTo: damageBonusBackground.topAnchor),
            damageBonusLabel.heightAnchor.constraint(equalTo: damageBonusBackground.heightAnchor),

            damageTypeBackground.leadingAnchor.constraint(equalTo: damageBonusBackground.trailingAnchor, constant: 5),
            damageTypeBackground.trailingAnchor.constraint(equalTo: cellBackground.trailingAnchor, constant: -5),
            damageTypeBackground.topAnchor.constraint(equalTo: damageValueBackground.bottomAnchor, constant: 5),
            damageTypeBackground.heightAnchor.constraint(equalTo: damageValueBackground.heightAnchor),

            damageTypeLabel.leadingAnchor.constraint(equalTo: damageTypeBackground.leadingAnchor, constant: 5),
            damageTypeLabel.topAnchor.constraint(equalTo: damageTypeBackground.topAnchor),
            damageTypeLabel.heightAnchor.constraint(equalTo: damageTypeBackground.heightAnchor),

            attackReachBackground.leadingAnchor.constraint(equalTo: cellBackground.leadingAnchor, constant: 5),
            attackReachBackground.widthAnchor.constraint(equalTo: cellBackground.widthAnchor, multiplier: 0.5),
            attackReachBackground.topAnchor.constraint(equalTo: damageBonusBackground.bottomAnchor, constant: 5),
            attackReachBackground.heightAnchor.constraint(equalTo: damageValueBackground.heightAnchor),

            attackReachLabel.leadingAnchor.constraint(equalTo: attackReachBackground.leadingAnchor, constant: 5),
            attackReachLabel.topAnchor.constraint(equalTo: attackReachBackground.topAnchor),
            attackReachLabel.heightAnchor.constraint(equalTo: attackReachBackground.heightAnchor),

            attackCriticalBackground.leadingAnchor.constraint(equalTo: attackReachBackground.trailingAnchor, constant: 5),
            attackCriticalBackground.trailingAnchor.constraint(equalTo: cellBackground.trailingAnchor, constant: -5),
            attackCriticalBackground.topAnchor.constraint(equalTo: damageTypeBackground.bottomAnchor, constant: 5),
            attackCriticalBackground.heightAnchor.constraint(equalTo: damageValueBackground.heightAnchor),

            attackCriticalLabel.leadingAnchor.constraint(equalTo: attackCriticalBackground.leadingAnchor, constant: 5),
            attackCriticalLabel.topAnchor.constraint(equalTo: attackCriticalBackground.topAnchor),
            attackCriticalLabel.heightAnchor.constraint(equalTo: attackCriticalBackground.heightAnchor)
        ])
    }
}
