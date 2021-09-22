//
//  DisplaySheetViewController.swift
//  MimicRPG
//
//  Created by Pedro Henrique on 13/09/21.
//

import UIKit

class DisplaySheetViewController: UIViewController {

    var buttons: [UIButton] = []

    var coordinator: Coordinator?

    let stackView: UIStackView = UIStackView()
    let scrollView: UIScrollView = UIScrollView()
    let barIndicator: UIView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.view.backgroundColor = UIColor(named: "Background")

        setupButtons()
    }

    func setupButtons() {
        let bioButton = tabButton(name: "Bio")
        let pointsButton = tabButton(name: "Pontos")
        let attributesButton = tabButton(name: "Atributos")
        let skillsButton = tabButton(name: "Perícias")
        let inventoryButton  = tabButton(name: "Inventário")
        let attacksButton = tabButton(name: "Ataques")
        let notesButton = tabButton(name: "Notas")

        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing

        buttons.append(bioButton)
        buttons.append(pointsButton)
        buttons.append(attributesButton)
        buttons.append(skillsButton)
        buttons.append(inventoryButton)
        buttons.append(attacksButton)
        buttons.append(notesButton)

        for button in buttons {
            stackView.addArrangedSubview(button)
        }

        stackView.spacing = 32

        barIndicator.translatesAutoresizingMaskIntoConstraints = false
        barIndicator.backgroundColor = UIColor(named: "Azure")
        barIndicator.layer.cornerRadius = 2
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = UIColor(named: "SecondaryBackground")
        scrollView.contentSize = CGSize(width: .zero, height: 50)
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.addSubview(stackView)
        scrollView.addSubview(barIndicator)
        scrollView.clipsToBounds = false
        view.addSubview(scrollView)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.heightAnchor.constraint(equalToConstant: 38),

            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 32),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -32),
            stackView.heightAnchor.constraint(equalToConstant: 40),

            barIndicator.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: -5),
            barIndicator.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            barIndicator.heightAnchor.constraint(equalToConstant: 5),
            barIndicator.widthAnchor.constraint(equalToConstant: 80),
            barIndicator.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ])

        changeSelectedButton(name: "Bio")
    }

    func tabButton(name: String) -> UIButton {
        let button = UIButton()
        button.setTitle(name, for: .normal)
        button.addTarget(self, action: #selector(tabFunction(sender:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.sizeToFit()
        button.titleLabel?.font =  UIFont.josefinSansButton()
        button.setTitleColor(UIColor(named: "FontColor"), for: .normal)
        return button
    }

    func changeSelectedButton(name: String) {
        for button in buttons {
            if button.titleLabel?.text == name {
                button.setTitleColor(UIColor(named: "Azure"), for: .normal)
                button.titleLabel?.font = UIFont.josefinSansBold17()
            } else {
                button.setTitleColor(UIColor(named: "FontColor"), for: .normal)
                button.titleLabel?.font =  UIFont.josefinSansButton()
            }
        }
    }
    
    @objc func tabFunction(sender: UIButton) {
        print(sender.currentTitle!)
        changeSelectedButton(name: sender.currentTitle!)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
