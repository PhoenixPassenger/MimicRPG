//
//  UserSheet.swift
//  MimicRPG
//
//  Created by Eduardo Oliveira on 13/09/21.
//

import UIKit

class UserSheet: UICollectionViewCell {

    lazy var sheetImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = false
        imageView.contentMode = .scaleAspectFit
        self.addSubview(imageView)
        return imageView
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
        label.font = UIFont.josefinSansBold14()
        label.textColor = UIColor(named: "FontColor")
        label.textAlignment = .center
        return label
    }()

    lazy var descLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(label)
        label.font = UIFont.josefinSansDetail()
        label.textColor = UIColor(named: "FontColor")
        label.textAlignment = .center
        return label
    }()

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented, because will not be used on IB")
    }

    override init(frame: CGRect) {
        super.init(frame: .zero)
        set(name: "Llanowar", desc: "Elfo - Nvl. 4")
    }

    func set(image: String = "llanowar", name: String = "", desc: String = "", system: String = "T20") {
        configureLayout()
        sheetImage.image = UIImage(named: image)
        nameLabel.text = name
        descLabel.text = desc
        if system == "Tormenta 20" {
            systemIcon.image = UIImage(named: "T20")
        } else if system == "Cthulhu 7th ed." {
            systemIcon.image = UIImage(named: "CT7")
        }
    }

    private func configureLayout() {
        NSLayoutConstraint.activate([
            sheetImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 7),
            sheetImage.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            sheetImage.heightAnchor.constraint(equalToConstant: 98),
            sheetImage.widthAnchor.constraint(equalToConstant: 145),

            systemIcon.topAnchor.constraint(equalTo: self.sheetImage.topAnchor, constant: -15),
            systemIcon.rightAnchor.constraint(equalTo: self.sheetImage.rightAnchor, constant: 11),
            systemIcon.heightAnchor.constraint(equalToConstant: 31),
            systemIcon.widthAnchor.constraint(equalToConstant: 31),

            nameLabel.topAnchor.constraint(equalTo: self.sheetImage.bottomAnchor, constant: 5),
            nameLabel.leftAnchor.constraint(equalTo: self.sheetImage.leftAnchor),
            nameLabel.heightAnchor.constraint(equalToConstant: 18),

            descLabel.topAnchor.constraint(equalTo: self.nameLabel.bottomAnchor, constant: 5),
            descLabel.leftAnchor.constraint(equalTo: self.sheetImage.leftAnchor)
        ])
    }
}
