//
//  DisplaySheetViewController.swift
//  MimicRPG
//
//  Created by Pedro Henrique on 13/09/21.
//

import UIKit

class DisplaySheetViewController: UIViewController, UIScrollViewDelegate {
    
    weak var coordinator: MainCoordinator?
 
    var buttons: [UIButton]?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.view.backgroundColor = UIColor(named: "Background")

        self.scrollView = UIScrollView()
        self.scrollView.delegate = self

        setupButtons()
        view.addSubview(scrollView)
    }

    func tabButton(name: String) -> UIButton {
        var button = UIButton()
        button.setTitle(name, for: .normal)
        button.addTarget(self, action: #selector(tabFunction(sender:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.sizeToFit()
        button.setTitleColor(UIColor(named: "FontColor"), for: .normal)
        return button
    }

    @objc func tabFunction(sender: UIButton) {
        print(sender.currentTitle)
    }

    func setupButtons() {
        let bioButton = tabButton(name: "Bio")
        let pointsButton = tabButton(name: "Pontos")
        let attributesButton = tabButton(name: "Atributos")
        let skillsButton = tabButton(name: "Pericias")
        let inventoryButton  = tabButton(name: "Inventário")
        let attacksButton = tabButton(name: "Ataques")
        let notesButton = tabButton(name: "Notas")

        let stackView = UIStackView(frame: CGRect(x: 0, y: 0, width: 700, height: 40))
        stackView.axis = NSLayoutConstraint.Axis.horizontal
        stackView.alignment = .leading
        stackView.distribution = .equalSpacing
        stackView.spacing = 15.0

        stackView.addArrangedSubview(bioButton)
        stackView.addArrangedSubview(pointsButton)
        stackView.addArrangedSubview(attributesButton)
        stackView.addArrangedSubview(skillsButton)
        stackView.addArrangedSubview(inventoryButton)
        stackView.addArrangedSubview(attacksButton)
        stackView.addArrangedSubview(notesButton)

        self.scrollView.contentSize = CGSize(width: 700, height: 40)
        scrollView.backgroundColor = .red
        
        scrollView.addSubview(stackView)
    }

    var scrollView: UIScrollView!

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        scrollView.frame = view.bounds
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
