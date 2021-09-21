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

        let stackView = UIStackView()
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

        let scrollView = UIScrollView()
        scrollView.contentSize = CGSize(width: .zero, height: 50)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.addSubview(stackView)
        view.addSubview(scrollView)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.heightAnchor.constraint(equalToConstant: 50),
   
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 32),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -32),
            stackView.heightAnchor.constraint(equalToConstant: 40)
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
    var scrollView: UIScrollView!

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
