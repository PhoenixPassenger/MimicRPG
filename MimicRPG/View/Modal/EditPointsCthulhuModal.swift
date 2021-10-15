//
//  EditPointsCthulhuModal.swift
//  MimicRPG
//
//  Created by Eduardo Oliveira on 04/10/21.
//
// swiftlint:disable force_cast

import UIKit

class EditPointsCthulhuModal: UIViewController {

    var viewModel: DisplaySheetViewModelType!

    init(with viewModel: DisplaySheetViewModelType) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
        setStartingPointsValues(with: self.viewModel)
    }

    var selectedRow: Int = 0
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
      }

    // MARK: - NavBar
    lazy var navigationBar: UIView = {
        let bar = UIView()
        bar.translatesAutoresizingMaskIntoConstraints = false
        bar.backgroundColor = UIColor(named: "SecondaryBackground")
        self.view.addSubview(bar)
        return bar
    }()

    lazy var titleModal: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(named: "FontColor")
        label.text = "EditPoints".localized()
        label.font = UIFont.josefinSansButton()
        self.view.addSubview(label)
        return label
    }()

    lazy var leftButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Cancel".localized(), for: .normal)
        button.setTitleColor(UIColor(named: "Azure"), for: .normal)
        button.titleLabel?.font = UIFont.josefinSansButton()
        self.view.addSubview(button)
        return button
    }()

    lazy var rightButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Confirm".localized(), for: .normal)
        button.setTitleColor(UIColor(named: "Azure"), for: .normal)
        button.titleLabel?.font = UIFont.josefinSansButton()
        self.view.addSubview(button)
        return button
    }()

    // MARK: - First Group

    lazy var maxLuckView: EditModalComponent = {
        let view = EditModalComponent(titleText: "MaxLuck".localized(), type: .stepper)
        return view
    }()

    lazy var maxMagicView: EditModalComponent = {
        let view = EditModalComponent(titleText: "MaxMagic".localized(), type: .stepper)
        return view
    }()

    lazy var maxSanityView: EditModalComponent = {
        let view = EditModalComponent(titleText: "MaxSanity".localized(), type: .stepper)
        return view
    }()

    lazy var maxLifeView: EditModalComponent = {
        let view = EditModalComponent(titleText: "MaxLife".localized(), type: .stepper)
        return view
    }()

    lazy var stack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [maxLifeView, maxMagicView, maxSanityView, maxLuckView])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.alignment = .fill
        stack.spacing = 22
        self.view.addSubview(stack)
        return stack
    }()

    // MARK: - Functions

    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        additionalConfigurations()
        leftButton.addTarget(self, action: #selector(leftButtonBehavior), for: .touchUpInside)
        rightButton.addTarget(self, action: #selector(rightButtonBehavior), for: .touchUpInside)
    }

    @objc func leftButtonBehavior() {
        dismiss(animated: true, completion: nil)
    }

    @objc func rightButtonBehavior() {
        editPoints()
        dismiss(animated: true, completion: viewModel.callReloadPointsCthulhu)
    }

    private func additionalConfigurations() {
        configureLayout()
        view.backgroundColor = UIColor(named: "Background")
    }

    func setStartingPointsValues(with viewModel: DisplaySheetViewModelType) {
        for point in viewModel.getPoints() {
            switch (point.name) {
            case PointsCthulhu.getPoints(.life)().name:
                maxLifeView.setValue(with: Int(point.maxValue))
            case PointsCthulhu.getPoints(.magic)().name:
                maxMagicView.setValue(with: Int(point.maxValue))
            case PointsCthulhu.getPoints(.sanity)().name:
                maxSanityView.setValue(with: Int(point.maxValue))
            case PointsCthulhu.getPoints(.luck)().name:
                maxLuckView.setValue(with: Int(point.maxValue))
            default:
                break
            }
        }
    }
    
    // MARK: - CoreData
    func editPoints() {
        let editMaxLife = maxLifeView.getValue()
        let editMaxMagic = maxMagicView.getValue()
        let editMaxSanity = maxSanityView.getValue()
        let editMaxLuck = maxLuckView.getValue()
        viewModel.setPointsCthulhu(setMaxLife: editMaxLife, setMaxMagic: editMaxMagic, setMaxSanity: editMaxSanity, setMaxLuck: editMaxLuck)
    }

    private func configureLayout() {
        NSLayoutConstraint.activate([
            navigationBar.topAnchor.constraint(equalTo: self.view.topAnchor),
            navigationBar.heightAnchor.constraint(equalToConstant: 55),
            navigationBar.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            navigationBar.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),

            titleModal.centerXAnchor.constraint(equalTo: navigationBar.centerXAnchor),
            titleModal.centerYAnchor.constraint(equalTo: navigationBar.centerYAnchor),

            leftButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            leftButton.centerYAnchor.constraint(equalTo: navigationBar.centerYAnchor),

            rightButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16),
            rightButton.centerYAnchor.constraint(equalTo: navigationBar.centerYAnchor),

            stack.topAnchor.constraint(equalTo: navigationBar.bottomAnchor, constant: 30),
            stack.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            stack.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16)
        ])
    }
}
