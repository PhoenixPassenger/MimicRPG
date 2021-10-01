//
//  CharacterAttacksCell.swift
//  MimicRPG
//
//  Created by Pedro Henrique on 30/09/21.
//

import UIKit

class CharacterAttacksCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        label.font = UIFont.josefinSansBold17()
        label.text = "Tacape"
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
        label.font = UIFont.josefinSansBold17()
        label.textAlignment = .center
        label.textColor = .black
        label.backgroundColor = .clear
        label.text = "Dano: 1d10 + 4"
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
        label.font = UIFont.josefinSansBold17()
        label.textAlignment = .center
        label.textColor = .black
        label.backgroundColor = .clear
        label.text = "Bônus de Ataque: 6"
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
        label.font = UIFont.josefinSansBold17()
        label.textAlignment = .center
        label.textColor = .black
        label.backgroundColor = .clear
        label.text = "Tipo: Impacto"
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
        label.font = UIFont.josefinSansBold17()
        label.textAlignment = .center
        label.textColor = .black
        label.backgroundColor = .clear
        label.text = "Alcance: Curto"
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
        label.font = UIFont.josefinSansBold17()
        label.textAlignment = .center
        label.textColor = .black
        label.backgroundColor = .clear
        label.text = "Crítico: x2"
        self.addSubview(label)
        return label
    }()

    lazy var deleteButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 25, height: 25))
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "trash.fill"), for: .normal)
        button.tintColor = UIColor.white
        self.addSubview(button)
        return button
    }()

    lazy var editButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 25, height: 25))
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "pencil"), for: .normal)
        button.tintColor = UIColor.white
        self.addSubview(button)
        return button
    }()

    override func draw(_ rect: CGRect) {
        self.layer.borderWidth = 3
        self.layer.cornerRadius = 5
    }

    func set() {
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
            cellBackground.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            cellBackground.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
            cellBackground.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            cellBackground.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5),

            attackNameLabel.leadingAnchor.constraint(equalTo: cellBackground.leadingAnchor, constant: 10),
            attackNameLabel.trailingAnchor.constraint(equalTo: attackNameLabel.leadingAnchor, constant: 250),
            attackNameLabel.topAnchor.constraint(equalTo: cellBackground.topAnchor, constant: 10),
            attackNameLabel.heightAnchor.constraint(equalToConstant: 28),

            damageValueBackground.leadingAnchor.constraint(equalTo: cellBackground.leadingAnchor, constant: 10),
            damageValueBackground.trailingAnchor.constraint(equalTo: damageValueBackground.leadingAnchor, constant: 195),
            damageValueBackground.topAnchor.constraint(equalTo: attackNameLabel.bottomAnchor, constant: 5),
            damageValueBackground.heightAnchor.constraint(equalToConstant: 28),

            damageValueLabel.leadingAnchor.constraint(equalTo: damageValueBackground.leadingAnchor, constant: 5),
            damageValueLabel.topAnchor.constraint(equalTo: damageValueBackground.topAnchor),
            damageValueLabel.heightAnchor.constraint(equalTo: damageValueBackground.heightAnchor),

            damageBonusBackground.leadingAnchor.constraint(equalTo: damageValueBackground.trailingAnchor, constant: 5),
            damageBonusBackground.trailingAnchor.constraint(equalTo: damageBonusBackground.leadingAnchor, constant: 185),
            damageBonusBackground.topAnchor.constraint(equalTo: damageValueBackground.topAnchor),
            damageBonusBackground.heightAnchor.constraint(equalTo: damageValueBackground.heightAnchor),

            damageBonusLabel.leadingAnchor.constraint(equalTo: damageBonusBackground.leadingAnchor, constant: 5),
            damageBonusLabel.topAnchor.constraint(equalTo: damageBonusBackground.topAnchor),
            damageBonusLabel.heightAnchor.constraint(equalTo: damageBonusBackground.heightAnchor),

            editButton.trailingAnchor.constraint(equalTo: damageBonusBackground.trailingAnchor),
            editButton.leadingAnchor.constraint(equalTo: editButton.leadingAnchor, constant: -30),
            editButton.topAnchor.constraint(equalTo: attackNameLabel.topAnchor),
            editButton.bottomAnchor.constraint(equalTo: editButton.topAnchor, constant: 30),

            deleteButton.trailingAnchor.constraint(equalTo: editButton.leadingAnchor, constant: -30),
            deleteButton.leadingAnchor.constraint(equalTo: deleteButton.trailingAnchor, constant: -30),
            deleteButton.topAnchor.constraint(equalTo: attackNameLabel.topAnchor),
            deleteButton.bottomAnchor.constraint(equalTo: deleteButton.topAnchor, constant: 30),

            damageTypeBackground.leadingAnchor.constraint(equalTo: damageValueBackground.leadingAnchor),
            damageTypeBackground.trailingAnchor.constraint(equalTo: damageTypeBackground.leadingAnchor, constant: 130),
            damageTypeBackground.topAnchor.constraint(equalTo: damageValueBackground.bottomAnchor, constant: 5),
            damageTypeBackground.heightAnchor.constraint(equalTo: damageValueBackground.heightAnchor),

            damageTypeLabel.leadingAnchor.constraint(equalTo: damageTypeBackground.leadingAnchor, constant: 5),
            damageTypeLabel.topAnchor.constraint(equalTo: damageTypeBackground.topAnchor),
            damageTypeLabel.heightAnchor.constraint(equalTo: damageTypeBackground.heightAnchor),

            attackReachBackground.leadingAnchor.constraint(equalTo: damageTypeBackground.trailingAnchor, constant: 5),
            attackReachBackground.trailingAnchor.constraint(equalTo: attackReachBackground.leadingAnchor, constant: 140),
            attackReachBackground.topAnchor.constraint(equalTo: damageTypeBackground.topAnchor),
            attackReachBackground.heightAnchor.constraint(equalTo: damageValueBackground.heightAnchor),

            attackReachLabel.leadingAnchor.constraint(equalTo: attackReachBackground.leadingAnchor, constant: 5),
            attackReachLabel.topAnchor.constraint(equalTo: attackReachBackground.topAnchor),
            attackReachLabel.heightAnchor.constraint(equalTo: attackReachBackground.heightAnchor),

            attackCriticalBackground.leadingAnchor.constraint(equalTo: attackReachBackground.trailingAnchor, constant: 5),
            attackCriticalBackground.trailingAnchor.constraint(equalTo: damageBonusBackground.trailingAnchor),
            attackCriticalBackground.topAnchor.constraint(equalTo: damageTypeBackground.topAnchor),
            attackCriticalBackground.heightAnchor.constraint(equalTo: damageValueBackground.heightAnchor),

            attackCriticalLabel.leadingAnchor.constraint(equalTo: attackCriticalBackground.leadingAnchor, constant: 5),
            attackCriticalLabel.topAnchor.constraint(equalTo: attackCriticalBackground.topAnchor),
            attackCriticalLabel.heightAnchor.constraint(equalTo: attackCriticalBackground.heightAnchor)
        ])
    }
}
