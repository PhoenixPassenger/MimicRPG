//
//  SheetHeader.swift
//  MimicRPG
//
//  Created by Eduardo Oliveira on 26/09/21.
//

import Foundation
import UIKit

class SheetHeader: UIView {

    init() {
        super.init(frame: .zero)
        self.backgroundColor = UIColor(named: "SecondaryBackground")
        configureLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    lazy var bannerImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        let color = UIImage.imageWithColor(color: .shamrock)
        imageView.image = color
        self.addSubview(imageView)
        return imageView
    }()

    lazy var perfilImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.borderWidth = 1
        imageView.layer.masksToBounds = false
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.layer.cornerRadius = 50
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "placeholder-profile")
        self.addSubview(imageView)
        return imageView
    }()

    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(label)
        label.font = UIFontMetrics(forTextStyle: .body).scaledFont(for: .josefinSansBold17())
        label.text = "Llanowar"
        label.textColor = UIColor(named: "FontColor")
        label.textAlignment = .center
        return label
    }()

    lazy var descLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(label)
        label.font = UIFontMetrics(forTextStyle: .footnote).scaledFont(for: .josefinSansDetail())
        label.text = "Elfo - Nvl. 4"
        label.textColor = UIColor(named: "FontColor")
        label.textAlignment = .center
        return label
    }()

    func set(name: String, desc: String) {
        nameLabel.text = name
        descLabel.text = desc
    }

    private func configureLayout() {
        NSLayoutConstraint.activate([
            perfilImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            perfilImage.centerYAnchor.constraint(equalTo: self.topAnchor),
            perfilImage.heightAnchor.constraint(equalToConstant: 100),
            perfilImage.widthAnchor.constraint(equalToConstant: 100),
            perfilImage.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -12),

            nameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: nameLabel.font.lineHeight * -0.5),
            nameLabel.leadingAnchor.constraint(equalTo: self.perfilImage.trailingAnchor, constant: 12),

            descLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 6),
            descLabel.leadingAnchor.constraint(equalTo: self.perfilImage.trailingAnchor, constant: 12)
        ])

        self.clipsToBounds = false
    }
}
