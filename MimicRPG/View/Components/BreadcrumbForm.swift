//
//  BreadcrumbForm.swift
//  MimicRPG
//
//  Created by Eduardo Oliveira on 01/10/21.
//

import Foundation
import UIKit

class BreadcrumbForm: UIView {
    init() {
        super.init(frame: .zero)
        configureLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    lazy var firstCircle: UIView = {
        let circle = UIView()
        circle.translatesAutoresizingMaskIntoConstraints = false
        circle.layer.cornerRadius = 4.5
        circle.backgroundColor = UIColor(named: "Azure")
        self.addSubview(circle)
        return circle
    }()

    lazy var line: UIView = {
        let line = UIView()
        line.translatesAutoresizingMaskIntoConstraints = false
        line.backgroundColor = .systemGray
        self.addSubview(line)
        return line
    }()

    lazy var secondCircle: UIView = {
        let circle = UIView()
        circle.translatesAutoresizingMaskIntoConstraints = false
        circle.layer.cornerRadius = 4.5
        circle.backgroundColor = .systemGray
        self.addSubview(circle)
        return circle
    }()

    private func configureLayout() {
        NSLayoutConstraint.activate([
            firstCircle.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            firstCircle.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            firstCircle.widthAnchor.constraint(equalToConstant: 9),
            firstCircle.heightAnchor.constraint(equalToConstant: 9),

            line.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            line.leadingAnchor.constraint(equalTo: firstCircle.trailingAnchor),
            line.widthAnchor.constraint(equalToConstant: 14),
            line.heightAnchor.constraint(equalToConstant: 1),

            secondCircle.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            secondCircle.leadingAnchor.constraint(equalTo: line.trailingAnchor),
            secondCircle.widthAnchor.constraint(equalToConstant: 9),
            secondCircle.heightAnchor.constraint(equalToConstant: 9)
        ])
    }
}
