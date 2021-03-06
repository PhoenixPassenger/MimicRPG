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

    lazy var chainButton = UIBarButtonItem(image: UIImage(named: "Chain"), style: .plain, target: self, action: #selector(copyIdentifierToClipboard))

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
            case 1:
                switch viewModel.getSystem() {
                case "Tormenta 20":
                    let view = CharacterPointsT20()
                    sheetView = view
                    view.viewModel = self.viewModel
                    view.setupView()
                case "Cthulhu 7th ed.":
                    let view = CharacterPointsCthulhu()
                    sheetView = view
                    view.viewModel = self.viewModel
                    view.setupView()
                default:
                    break
                }
            case 2:
                switch viewModel.getSystem() {
                case "Tormenta 20":
                    let view = CharacterAttributesT20()
                    view.viewModel = self.viewModel
                    sheetView = view
                    view.setupView()
                case "Cthulhu 7th ed.":
                    let view = CharacterAttributesCthulhu()
                    view.viewModel = self.viewModel
                    sheetView = view
                    view.setupView()
                default:
                    break
                }
            case 3:
                switch viewModel.getSystem() {
                case "Tormenta 20":
                    let view = CharacterSkillsT20()
                    view.viewModel = self.viewModel
                    sheetView = view
                    view.setupTableView()
                case "Cthulhu 7th ed.":
                    let view = CharacterSkillsCthulhu()
                    view.viewModel = self.viewModel
                    sheetView = view
                    view.setupTableView()
                default:
                    break
                }
            case 4:
                let view = CharacterItems()
                view.viewModel = self.viewModel
                sheetView = view
                view.setupTableView()
            case 5:
                switch viewModel.getSystem() {
                case "Tormenta 20":
                    let view = CharacterAttacksT20()
                    view.viewModel = self.viewModel
                    sheetView = view
                    view.setupTableView()
                case "Cthulhu 7th ed.":
                    let view = CharacterAttacksCthulhu()
                    view.viewModel = self.viewModel
                    sheetView = view
                    view.setupTableView()
                default:
                    break
                }
            case 6:
                let view = CharacterNotes()
                view.viewModel = self.viewModel
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
                                          .foregroundColor: UIColor(named: "FontColor") as Any]
        navigationController?.navigationBar.tintColor = UIColor(named: "FontColor")
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.prefersLargeTitles = true

        chainButton.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.josefinSansButton()], for: .normal)
//        navigationItem.rightBarButtonItem = chainButton

        chainButton.tintColor = UIColor(named: "Ivory")

        updateButtons()
        setupButtons()
        setupElements()
        updateHeader()
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
        if viewModel.getSystem() == "Tormenta 20" {
            let color = UIImage.imageWithColor(color: .brandy)
            bannerView.image = color
        } else {
            if viewModel.getSystem() == "Cthulhu 7th ed." {
                let color = UIImage.imageWithColor(color: .shamrock)
                bannerView.image = color
            }
        }
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
            bannerView.bottomAnchor.constraint(equalTo: bannerView.topAnchor,
                                               constant: max(self.view.bounds.height/4.5, sheetHeader.nameLabel.font.lineHeight * 4)),

            sheetHeader.topAnchor.constraint(equalTo: bannerView.bottomAnchor, constant: sheetHeader.nameLabel.font.lineHeight * 0.8),
            sheetHeader.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            sheetHeader.trailingAnchor.constraint(equalTo: view.leadingAnchor),

            scrollView.topAnchor.constraint(equalTo: sheetHeader.bottomAnchor, constant: (buttons[0].titleLabel?.font.lineHeight)!),
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
        button.titleLabel?.font = UIFontMetrics(forTextStyle: .subheadline).scaledFont(for: .josefinSansBold17())
        return button
    }

    func changeSelectedButton(tag: Int) {

        for button in buttons where button.tag == tag {
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

    @objc func tabFunction(sender: UIButton) {
        changeSelectedButton(tag: sender.tag)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @objc func copyIdentifierToClipboard() {
        UIPasteboard.general.string = viewModel.sheet?.identifier?.uuidString
    }

}

extension DisplaySheetViewController: DisplaySheetViewModelOutput {
    func alertDeleteAttack(receivedAttack: Attack) {
        let alert = UIAlertController(title: "DeleteAttackTitle".localized(), message: "DeleteAttackMessage".localized(), preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "DeleteAttackConfirm".localized(), style: .destructive, handler: { _ in
            self.viewModel.removeAttack(attack: receivedAttack)
        }))
        alert.addAction(UIAlertAction(title: "Cancel".localized(), style: .cancel, handler: { _ in
        }))

        self.present(alert, animated: true, completion: nil)
    }

    func alertDeleteSkill(receivedSkill: Skill) {
        let alert = UIAlertController(title: "DeleteSkillTitle".localized(), message: "DeleteSkillMessage".localized(), preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "DeleteSkillConfirm".localized(), style: .destructive, handler: { _ in
            self.viewModel.removeSkill(skill: receivedSkill)
        }))
        alert.addAction(UIAlertAction(title: "Cancel".localized(), style: .cancel, handler: { _ in
        }))

        self.present(alert, animated: true, completion: nil)
    }

    func alertDeleteItem(receivedItem: Item) {
        let alert = UIAlertController(title: "DeleteItemTitle".localized(), message: "DeleteItemMessage".localized(), preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "DeleteItemConfirm".localized(), style: .destructive, handler: { _ in
            self.viewModel.removeItem(item: receivedItem)
        }))
        alert.addAction(UIAlertAction(title: "Cancel".localized(), style: .cancel, handler: { _ in
        }))

        self.present(alert, animated: true, completion: nil)
    }

    func alertDeleteNote(receivedNote: Notes) {
        let alert = UIAlertController(title: "DeleteNoteTitle".localized(), message: "DeleteNoteMessage".localized(), preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "DeleteNoteConfirm".localized(), style: .destructive, handler: { _ in
            self.viewModel.removeNote(note: receivedNote)
        }))
        alert.addAction(UIAlertAction(title: "Cancel".localized(), style: .cancel, handler: { _ in
        }))

        self.present(alert, animated: true, completion: nil)
    }

    func reloadAttacksT20() {
        let view = self.sheetView as? CharacterAttacksT20
        view?.reloadData()
    }

    func reloadAttacksCthulhu() {
        let view = self.sheetView as? CharacterAttacksCthulhu
        view?.reloadData()
    }

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

    func displayEditNoteModal(name: String, desc: String, note: Notes) {
        let modal = CreateNoteModal()
        modal.sheetViewModel = self.viewModel
        modal.fillForm(name: name, desc: desc, note: note)
        self.present(modal, animated: true, completion: nil)
    }

    func displayEditBioModal(name: String, desc: String, value: Int, characteristic: Characteristics) {
        let modal = EditFieldModal()
        modal.viewModel = self.viewModel
        modal.fillForm(name: name, desc: desc, value: value, characteristic: characteristic)
        self.present(modal, animated: true, completion: nil)
    }

    func displayCreateSkillsCthulhuModal() {
        let modal = CreateSkillCthulhuModal()
        modal.viewModel = self.viewModel
        self.present(modal, animated: true, completion: nil)
    }
    func displayEditSkillsT20Modal(name: String, skill: Skill) {
        let modal = EditSkillT20Modal()
        modal.viewModel = self.viewModel
        modal.fillForm(name: name, skill: skill)
        self.present(modal, animated: true, completion: nil)
    }
    func displayEditSkillsCthulhuModal(name: String, skill: Skill) {
        let modal = EditSkillCthulhuModal()
        modal.viewModel = self.viewModel
        modal.fillForm(name: name, skill: skill)
        self.present(modal, animated: true, completion: nil)
    }
    func updateNotes() {
        let view = self.sheetView as? CharacterNotes
        view?.reloadData()
    }

    func updateHeader() {
        if (viewModel.getSystem() == "Tormenta 20") {
            let level = Int(viewModel.getProfile().first(where: {$0.name == "Level"})!.numberValue)
            let race = (viewModel.getProfile().first(where: {$0.name == "Race"})?.stringValue)

            sheetHeader.set(
                name: (viewModel.getProfile().first(where: {$0.name == "CharacterName"})?.stringValue) ?? "Unknown Name",
                desc: race! + " - " + "Nvl".localized() + ". \(level)"
            )
        } else {
            let occupation = (viewModel.getProfile().first(where: {$0.name == "02_Occupation"})?.stringValue)
            sheetHeader.set(
                name: (viewModel.getProfile().first(where: {$0.name == "01_NameInvestigator"})?.stringValue) ?? "Unknown Name",
                desc: occupation!
            )
        }
    }

    func updateProfile() {
        let view = self.sheetView as? CharacterBio
        updateHeader()
        view?.reloadData()
    }

    func displayNewNoteModal() {
        let modal = CreateNoteModal()
        modal.sheetViewModel = self.viewModel
        self.present(modal, animated: true, completion: nil)
    }

    func displayAddAttackT20Modal() {
        let addAttackT20Modal = CreateAttackT20Modal(with: viewModel)
        present(addAttackT20Modal, animated: true, completion: nil)
    }

    func displayAddAttackCthulhuModal() {
        let addAttackT20Modal = CreateAttackCthulhuModal(with: viewModel)
        present(addAttackT20Modal, animated: true, completion: nil)
    }

    func displayEditAttackT20Modal(editAttack: Attack) {
        let editAttackT20Modal = CreateAttackT20Modal(with: viewModel)
        editAttackT20Modal.fillForm(currentAttack: editAttack)
        present(editAttackT20Modal, animated: true, completion: nil)
    }

    func displayEditAttackCthulhuModal(editAttack: Attack) {
        let editAttackCthulhuModal = CreateAttackCthulhuModal(with: viewModel)
        editAttackCthulhuModal.fillForm(currentAttack: editAttack)
        present(editAttackCthulhuModal, animated: true, completion: nil)
    }

    func reloadAttributesT20() {
        let attributesView = sheetView as? CharacterAttributesT20
        attributesView?.setupView()
    }

    func reloadAttributesCthulhu() {
        let attributesView = sheetView as? CharacterAttributesCthulhu
        attributesView?.setupView()
    }

    func reloadPointsT20() {
        let pointsView = sheetView as? CharacterPointsT20
        pointsView?.setupView()
    }

    func reloadPointsCthulhu() {
        let pointsView = sheetView as? CharacterPointsCthulhu
        pointsView?.setupView()
    }

    func updateItems() {
        let itemsView = sheetView as? CharacterItems
        itemsView?.reloadData()
    }

    func updateSkillsT20() {
        let skillsView = sheetView as? CharacterSkillsT20
        skillsView?.reloadData()
    }

    func updateSkillsCthulhu() {
        let skillsView = sheetView as? CharacterSkillsCthulhu
        skillsView?.filteredSkills = viewModel.getSkills()
        skillsView?.reloadData()
    }

    func displayEditAttributesModal() { }

    func displayEditAttributesT20Modal() {
        let editPointsT20Modal = EditAttributesT20Modal(with: viewModel)
        present(editPointsT20Modal, animated: true, completion: nil)
    }

    func displayEditAttributesCthulhuModal() {
        let editPointsCthulhuModal = EditAttributesCthulhuModal(with: viewModel)
        present(editPointsCthulhuModal, animated: true, completion: nil)
    }

    func displayEditPointsT20Modal() {
        let editPointsT20Modal = EditPointsT20Modal(with: viewModel)
        present(editPointsT20Modal, animated: true, completion: nil)
    }

    func displayEditPointsCthulhuModal() {
        let editPointsT20Modal = EditPointsCthulhuModal(with: viewModel)
        present(editPointsT20Modal, animated: true, completion: nil)
    }

    func displayEditModal() {
        let modal = EditFieldModal()
        self.present(modal, animated: true, completion: nil)
    }

    func displayEditItemModal(name: String, desc: String, uses: Int, item: Item) {
        let modal = CreateItemModal()
        modal.viewModel = self.viewModel
        modal.fillForm(name: name, desc: desc, uses: uses, item: item)
        self.present(modal, animated: true, completion: nil)
    }

    func displayNewItem() {
        let modal = CreateItemModal()
        modal.viewModel = self.viewModel
        self.present(modal, animated: true, completion: nil)
    }
}
