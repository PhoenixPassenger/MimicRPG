//
//  DisplaySheetViewController.swift
//  MimicRPG
//
//  Created by Pedro Henrique on 13/09/21.
//
// swiftlint:disable force_cast

import UIKit

class DisplaySheetViewController: UIViewController {

    var buttons: [UIButton] = []
    var viewModel: DisplaySheetViewModelType!
    var coordinator: Coordinator?

    var bannerView: UIImageView = UIImageView()
    var sheetHeader: SheetHeader = SheetHeader()
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
                view.viewModel = self.viewModel
                sheetView = view
                view.setupTableView()
            case 2:
                let view = CharacterAttributesT20()
                view.viewModel = self.viewModel
                sheetView = view
                view.setupView()
            case 1:
                let view = CharacterPoints()
                sheetView = view
                view.viewModel = self.viewModel
                view.setupView()
            case 3:
                let view = CharacterSkillsT20()
                view.viewModel = self.viewModel
                sheetView = view
                view.setupTableView()
            case 4:
                let view = CharacterItems()
                sheetView = view
                view.setupTableView()
            case 5:
                let view = CharacterAttacks()
                sheetView = view
                view.setupTableView()
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
        self.view.backgroundColor = UIColor(named: "SecondaryBackground")

        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.titleTextAttributes = [.font:
        UIFont.boldSystemFont(ofSize: 20.0),
                                      .foregroundColor: UIColor.white]
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.prefersLargeTitles = true

        updateButtons()
        setupButtons()
        setupElements()
        changeSelectedButton(tag: 0)
    }

    func setupButtons() {
        let bioButton = tabButton(name: "Bio")
        bioButton.tag  = 0
        let pointsButton = tabButton(name: "Points".localized())
        pointsButton.tag  = 1
        let attributesButton = tabButton(name: "Attributes".localized())
        attributesButton.tag = 2
        let skillsButton = tabButton(name: "Skills".localized())
        skillsButton.tag = 3
        let inventoryButton  = tabButton(name: "Inventory".localized())
        inventoryButton.tag = 4
        let attacksButton = tabButton(name: "Attacks".localized())
        attacksButton.tag = 5
        let notesButton = tabButton(name: "Notes".localized())
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
    }

    func setupElements() {
        stackView.spacing = 32

        bannerView.translatesAutoresizingMaskIntoConstraints = false
        bannerView.image = UIImage(named: "banner")
        bannerView.layer.opacity = 0.5
        bannerView.layer.zPosition = 1

        sheetHeader.translatesAutoresizingMaskIntoConstraints = false
        sheetHeader.layer.zPosition = 1
        sheetHeader.backgroundColor = UIColor(named: "SecondaryBackground")

        barIndicator.translatesAutoresizingMaskIntoConstraints = false
        barIndicator.layer.cornerRadius = 2
        barIndicator.backgroundColor = UIColor(named: "Azure")
        barIndicator.layer.zPosition = 1

        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.contentSize = CGSize(width: .zero, height: 38)
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.backgroundColor = UIColor(named: "SecondaryBackground")
        scrollView.layer.zPosition = 1

        divisor.translatesAutoresizingMaskIntoConstraints = false
        divisor.backgroundColor = UIColor(named: "FontColor")
        divisor.layer.zPosition = 0

        view.addSubview(bannerView)
        view.addSubview(sheetHeader)
        scrollView.addSubview(stackView)
        scrollView.addSubview(barIndicator)
        scrollView.clipsToBounds = false
        view.addSubview(scrollView)
        view.addSubview(divisor)
        configureConstraints()
    }

    func configureConstraints() {
        NSLayoutConstraint.activate([
            bannerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -(navigationController?.navigationBar.frame.height)!),
            bannerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bannerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bannerView.heightAnchor.constraint(equalToConstant: 139),

            sheetHeader.topAnchor.constraint(equalTo: bannerView.bottomAnchor),
            sheetHeader.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            sheetHeader.trailingAnchor.constraint(equalTo: view.leadingAnchor),

            scrollView.topAnchor.constraint(equalTo: sheetHeader.bottomAnchor),
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

        for button in buttons {
            if button.tag == tag {
                widthAnchor.constant = button.frame.width
                centerXAnchor.constant = button.frame.midX
                UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseIn, animations: {
                    self.view.layoutIfNeeded()
                }, completion: { _ in
                    self.selectedTag = tag
                    self.updateButtons()
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
    }

}

extension DisplaySheetViewController: DisplaySheetViewModelOutput {
    func saveSheetPoints(newSTR: Int, newDEX: Int, newCON: Int, newINT: Int, newWIS: Int, newCHA: Int) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

        for attribute in viewModel.getAttributes() {
            switch (attribute.name) {
            case SkillT20Attributes.getAttribute(.STR)().name:
                attribute.value = Int64(newSTR)
            case SkillT20Attributes.getAttribute(.DEX)().name:
                attribute.value = Int64(newDEX)
            case SkillT20Attributes.getAttribute(.CON)().name:
                attribute.value = Int64(newCON)
            case SkillT20Attributes.getAttribute(.INT)().name:
                attribute.value = Int64(newINT)
            case SkillT20Attributes.getAttribute(.WIS)().name:
                attribute.value = Int64(newWIS)
            case SkillT20Attributes.getAttribute(.CHA)().name:
                attribute.value = Int64(newCHA)
            default:
                attribute.value = Int64(newSTR)
            }
        }

        do {
            try context.save()
        } catch {
            fatalError("Unable to save data in coredata model")
        }
    }

    func reloadAttributes() {
        let attributesView = sheetView as? CharacterAttributesT20
        attributesView?.setupView()
    }

    func displayEditAttributesModal() {
        let editPointsT20Modal = EditAttributesT20Modal(with: viewModel)
        present(editPointsT20Modal, animated: true, completion: nil)
    }
    
    func displayEditPointsModal() {
        let editPointsT20Modal = EditPointsT20Modal(with: viewModel)
        present(editPointsT20Modal, animated: true, completion: nil)
    }

    func displayEditModal() {
        let modal = EditFieldModal()
        self.present(modal, animated: true, completion: nil)
    }
}
