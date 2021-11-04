//
//  BreadcrumbForm.swift
//  MimicRPG
//
//  Created by Eduardo Oliveira on 01/10/21.
//

import Foundation
import UIKit

class BreadcrumbForm: UIView {
    init(numberOfCrumbs: Int = 2) {
        super.init(frame: .zero)
        configureLayout(numberOfCrumbs: numberOfCrumbs)
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

    lazy var firstLine: UIView = {
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

    lazy var secondLine: UIView = {
        let line = UIView()
        line.translatesAutoresizingMaskIntoConstraints = false
        line.backgroundColor = .systemGray
        self.addSubview(line)
        return line
    }()

    lazy var thirdCircle: UIView = {
        let circle = UIView()
        circle.translatesAutoresizingMaskIntoConstraints = false
        circle.layer.cornerRadius = 4.5
        circle.backgroundColor = .systemGray
        self.addSubview(circle)
        return circle
    }()

    lazy var thirdLine: UIView = {
        let line = UIView()
        line.translatesAutoresizingMaskIntoConstraints = false
        line.backgroundColor = .systemGray
        self.addSubview(line)
        return line
    }()

    lazy var fourthCircle: UIView = {
        let circle = UIView()
        circle.translatesAutoresizingMaskIntoConstraints = false
        circle.layer.cornerRadius = 4.5
        circle.backgroundColor = .systemGray
        self.addSubview(circle)
        return circle
    }()

    lazy var fourthLine: UIView = {
        let line = UIView()
        line.translatesAutoresizingMaskIntoConstraints = false
        line.backgroundColor = .systemGray
        self.addSubview(line)
        return line
    }()

    lazy var fifthCircle: UIView = {
        let circle = UIView()
        circle.translatesAutoresizingMaskIntoConstraints = false
        circle.layer.cornerRadius = 4.5
        circle.backgroundColor = .systemGray
        self.addSubview(circle)
        return circle
    }()

    private func configureLayout(numberOfCrumbs: Int) {

        firstCircle.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        firstCircle.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        firstCircle.widthAnchor.constraint(equalToConstant: 9).isActive = true
        firstCircle.heightAnchor.constraint(equalToConstant: 9).isActive = true

        firstLine.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        firstLine.leadingAnchor.constraint(equalTo: firstCircle.trailingAnchor).isActive = true
        firstLine.widthAnchor.constraint(equalToConstant: 14).isActive = true
        firstLine.heightAnchor.constraint(equalToConstant: 1).isActive = true

        secondCircle.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        secondCircle.leadingAnchor.constraint(equalTo: firstLine.trailingAnchor).isActive = true
        secondCircle.widthAnchor.constraint(equalToConstant: 9).isActive = true
        secondCircle.heightAnchor.constraint(equalToConstant: 9).isActive = true

        if numberOfCrumbs > 2 {
            secondLine.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
            secondLine.leadingAnchor.constraint(equalTo: secondCircle.trailingAnchor).isActive = true
            secondLine.widthAnchor.constraint(equalToConstant: 14).isActive = true
            secondLine.heightAnchor.constraint(equalToConstant: 1).isActive = true

            thirdCircle.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
            thirdCircle.leadingAnchor.constraint(equalTo: secondLine.trailingAnchor).isActive = true
            thirdCircle.widthAnchor.constraint(equalToConstant: 9).isActive = true
            thirdCircle.heightAnchor.constraint(equalToConstant: 9).isActive = true

            if numberOfCrumbs == 5 {
                thirdLine.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
                thirdLine.leadingAnchor.constraint(equalTo: thirdCircle.trailingAnchor).isActive = true
                thirdLine.widthAnchor.constraint(equalToConstant: 14).isActive = true
                thirdLine.heightAnchor.constraint(equalToConstant: 1).isActive = true

                fourthCircle.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
                fourthCircle.leadingAnchor.constraint(equalTo: thirdLine.trailingAnchor).isActive = true
                fourthCircle.widthAnchor.constraint(equalToConstant: 9).isActive = true
                fourthCircle.heightAnchor.constraint(equalToConstant: 9).isActive = true

                fourthLine.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
                fourthLine.leadingAnchor.constraint(equalTo: fourthCircle.trailingAnchor).isActive = true
                fourthLine.widthAnchor.constraint(equalToConstant: 14).isActive = true
                fourthLine.heightAnchor.constraint(equalToConstant: 1).isActive = true

                fifthCircle.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
                fifthCircle.leadingAnchor.constraint(equalTo: fourthLine.trailingAnchor).isActive = true
                fifthCircle.widthAnchor.constraint(equalToConstant: 9).isActive = true
                fifthCircle.heightAnchor.constraint(equalToConstant: 9).isActive = true
            }
        }
    }
}
