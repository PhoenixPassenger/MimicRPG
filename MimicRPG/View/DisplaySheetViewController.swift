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
    let divisor: UIView = UIView()
    var sheetView: UIView = UIView()

    var selectedTag: Int = 0 {
        didSet {
            sheetView.removeFromSuperview()
            switch selectedTag {
            case 0:
                let view = CharacterBio()
                sheetView = view
                view.setupTableView()
            case 4:
//                let view = CharacterItems()
//                sheetView = view
//                view.setupTableView()
                break
            case 6:
                let view = CharacterNotes()
                sheetView = view
                view.setupTableView()
            default:
                sheetView = UIView()
            }
            self.setupSheetView()
        }
    }

    fileprivate var widthAnchor: NSLayoutConstraint!
    fileprivate var centerXAnchor: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.view.backgroundColor = UIColor(named: "Background")
        updateButtons()

        setupButtons()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        changeSelectedButton(tag: 0)
    }

    func setupButtons() {
        let bioButton = tabButton(name: "Bio")
        bioButton.tag  = 0
        let pointsButton = tabButton(name: "Pontos")
        pointsButton.tag  = 1
        let attributesButton = tabButton(name: "Atributos")
        attributesButton.tag = 2
        let skillsButton = tabButton(name: "Perícias")
        skillsButton.tag = 3
        let inventoryButton  = tabButton(name: "Inventário")
        inventoryButton.tag = 4
        let attacksButton = tabButton(name: "Ataques")
        attacksButton.tag = 5
        let notesButton = tabButton(name: "Notas")
        notesButton.tag = 6
        updateButtons()
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
        barIndicator.layer.cornerRadius = 2
        barIndicator.backgroundColor = UIColor(named: "Azure")
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.contentSize = CGSize(width: .zero, height: 38)
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.backgroundColor = UIColor(named: "SecondaryBackground")
        scrollView.layer.zPosition = 1
        divisor.translatesAutoresizingMaskIntoConstraints = false
        divisor.backgroundColor = UIColor(named: "FontColor")
        divisor.layer.zPosition = 0

        scrollView.addSubview(stackView)
        scrollView.addSubview(barIndicator)
        scrollView.clipsToBounds = false
        view.addSubview(scrollView)
        view.addSubview(divisor)
        configureConstraints()
    }

    func configureConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.heightAnchor.constraint(equalToConstant: 38),

            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 32),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -32),
            stackView.heightAnchor.constraint(equalToConstant: 40),

            divisor.topAnchor.constraint(equalTo: scrollView.bottomAnchor),
            divisor.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            divisor.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            divisor.heightAnchor.constraint(equalToConstant: 1)
        ])

        barIndicator.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: -4).isActive = true
        centerXAnchor = barIndicator.centerXAnchor.constraint(equalTo: stackView.leadingAnchor, constant: -12)
        centerXAnchor.isActive = true
        barIndicator.heightAnchor.constraint(equalToConstant: 5).isActive = true
        widthAnchor = barIndicator.widthAnchor.constraint(equalToConstant: 30)
        widthAnchor.isActive = true
    }

    func setupSheetView() {
        sheetView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(sheetView)
        NSLayoutConstraint.activate([
        sheetView.topAnchor.constraint(equalTo: divisor.bottomAnchor),
        sheetView.leadingAnchor.constraint(equalTo: divisor.leadingAnchor),
        sheetView.trailingAnchor.constraint(equalTo: divisor.trailingAnchor),
        sheetView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    func updateButtons() {
        for button in buttons {
            if button.tag == selectedTag {
                button.setTitleColor(UIColor(named: "Azure"), for: .normal)
            } else {
                button.setTitleColor(UIColor(named: "FontColor"), for: .normal)
            }
        }
    }

    func tabButton(name: String) -> UIButton {
        let button = UIButton()
        button.setTitle(name, for: .normal)
        button.addTarget(self, action: #selector(tabFunction(sender:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.sizeToFit()
        button.titleLabel?.font = UIFont.josefinSansBold17()
        return button
    }

    func changeSelectedButton(tag: Int) {
        selectedTag = tag
        updateButtons()
        for button in buttons {
            if button.tag == tag {
                widthAnchor.constant = button.frame.width
                centerXAnchor.constant = button.frame.midX
                UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseIn, animations: {
                    self.view.layoutIfNeeded()
                })
            }
        }
    }
    @objc func tabFunction(sender: UIButton) {
        changeSelectedButton(tag: sender.tag)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
