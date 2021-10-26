//
//  TableCell.swift
//  MimicRPG
//
//  Created by Eduardo Oliveira on 20/10/21.
//

import UIKit

class TableCell: UICollectionViewCell {

    lazy var sheetImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.backgroundColor = .systemGray
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 5
        self.addSubview(imageView)
        return imageView
    }()

    lazy var overlay: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.backgroundColor = .black
        view.layer.opacity = 0.4
        view.contentMode = .scaleAspectFit
        view.layer.cornerRadius = 5
        self.addSubview(view)
        return view
    }()

    lazy var systemIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = false
        imageView.contentMode = .scaleAspectFit
        self.addSubview(imageView)
        return imageView
    }()

    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(label)
        label.font = UIFont.josefinSansBold17()
        label.textColor = .ivory
        label.textAlignment = .center
        return label
    }()

    lazy var numberOfPlayersLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(label)
        label.font = UIFont.josefinSansDetail()
        label.textColor = .ivory
        label.textAlignment = .center
        return label
    }()

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented, because will not be used on IB")
    }

    override init(frame: CGRect) {
        super.init(frame: .zero)
        set(name: "Mesa vazia", numberOfPlayers: "0 jogadores")
    }

    func set(image: String = "placeholder-profile", name: String = "", numberOfPlayers: String = "", system: String = "T20") {
        configureLayout()
        sheetImage.image = UIImage(named: image)
        nameLabel.text = name
        numberOfPlayersLabel.text = numberOfPlayers
        if system == "Tormenta 20" {
            systemIcon.image = UIImage(named: "T20")
        } else if system == "Cthulhu 7th ed." {
            systemIcon.image = UIImage(named: "CT7")
        }
    }

    private func configureLayout() {
        NSLayoutConstraint.activate([
            sheetImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 15),
            sheetImage.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            sheetImage.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.8),
            sheetImage.widthAnchor.constraint(equalTo: self.widthAnchor),

            overlay.topAnchor.constraint(equalTo: sheetImage.topAnchor),
            overlay.centerXAnchor.constraint(equalTo: sheetImage.centerXAnchor),
            overlay.heightAnchor.constraint(equalTo: sheetImage.heightAnchor),
            overlay.widthAnchor.constraint(equalTo: sheetImage.widthAnchor),

            systemIcon.topAnchor.constraint(equalTo: self.sheetImage.topAnchor, constant: -15),
            systemIcon.rightAnchor.constraint(equalTo: self.sheetImage.rightAnchor, constant: 11),
            systemIcon.heightAnchor.constraint(equalToConstant: 31),
            systemIcon.widthAnchor.constraint(equalTo: systemIcon.heightAnchor),

            numberOfPlayersLabel.bottomAnchor.constraint(equalTo: self.sheetImage.bottomAnchor, constant: -5),
            numberOfPlayersLabel.leftAnchor.constraint(equalTo: self.sheetImage.leftAnchor, constant: 7),

            nameLabel.bottomAnchor.constraint(equalTo: self.numberOfPlayersLabel.topAnchor, constant: -5),
            nameLabel.leftAnchor.constraint(equalTo: self.sheetImage.leftAnchor, constant: 7),
            nameLabel.heightAnchor.constraint(equalToConstant: 18)
        ])
    }
}
