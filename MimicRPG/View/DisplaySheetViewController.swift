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

        let textLable = UILabel(frame: CGRect(x: 0, y: 0, width: 1000, height: 100))
        textLable.text = textData

        self.scrollView = UIScrollView()
        self.scrollView.delegate = self
        self.scrollView.contentSize = CGSize(width: textLable.frame.width, height: textLable.frame.height)

        setupButtons()
        view.addSubview(scrollView)
    }

    func setupButtons() {
        let bioButton = UIButton()
        bioButton.setTitle("Bio", for: .normal)
        bioButton.translatesAutoresizingMaskIntoConstraints = false

        let pointsButton = UIButton()
        pointsButton.setTitle("Pontos", for: .normal)
        pointsButton.translatesAutoresizingMaskIntoConstraints = false
        
        let attributesButton = UIButton()
        attributesButton.setTitle("Atributos", for: .normal)
        attributesButton.translatesAutoresizingMaskIntoConstraints = false

        let stackView = UIStackView(frame: CGRect(x: 40, y: 100, width: 1000, height: 100))
        stackView.axis = NSLayoutConstraint.Axis.horizontal
        stackView.alignment = .leading
        stackView.distribution = .fillEqually
        stackView.spacing = 8.0

        stackView.addArrangedSubview(bioButton)
        stackView.addArrangedSubview(pointsButton)
        stackView.addArrangedSubview(attributesButton)

        scrollView.addSubview(stackView)
    }

    var scrollView: UIScrollView!

    var textData: String = "Just to add onto the already great answers, you might want to add multiple labels in your project"

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        scrollView.frame = view.bounds
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
