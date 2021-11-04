//
//  OnboardingModal.swift
//  MimicRPG
//
//  Created by Eduardo Oliveira on 03/11/21.
//
// swiftlint:disable force_cast

import UIKit

class OnboardingModal: UIViewController {

    var paginator: Int = 0
    let lastPage: Int = 4

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    var selectedRow: Int = 0
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - First Group

    lazy var onboard1Image: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "onboard1")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var onboard1Text: UILabel = {
        let label = UILabel()
        label.text = "Onboard1Text".localized()
        label.font = UIFont.josefinSansButton()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        label.frame.size.width = 300
        return label
    }()

    lazy var firstStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [onboard1Image, onboard1Text])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.alignment = .fill
        stack.spacing = 22
        self.view.addSubview(stack)
        return stack
    }()

    // MARK: - Second Group

    lazy var onboard2Image: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "onboard2")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    lazy var onboard2Text: UILabel = {
        let label = UILabel()
        label.text = "Onboard2Text".localized()
        label.font = UIFont.josefinSansButton()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        label.frame.size.width = 300
        return label
    }()

    lazy var secondStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [onboard2Image, onboard2Text])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.alignment = .fill
        stack.spacing = 22
        self.view.addSubview(stack)
        return stack
    }()

    // MARK: - Third Group

    lazy var onboard3Image: UIImageView = {
        let image = UIImage.gifImageWithName("onboard3")
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    lazy var onboard3Text: UILabel = {
        let label = UILabel()
        label.text = "Onboard3Text".localized()
        label.font = UIFont.josefinSansButton()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        label.frame.size.width = 300
        return label
    }()

    lazy var thirdStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [onboard3Image, onboard3Text])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = 22
        self.view.addSubview(stack)
        return stack
    }()

    // MARK: - Fourth Group

    lazy var onboard4Image: UIImageView = {
        let image = UIImage.gifImageWithName("onboard4")
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    lazy var onboard4Text: UILabel = {
        let label = UILabel()
        label.text = "Onboard4Text".localized()
        label.font = UIFont.josefinSansButton()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        label.frame.size.width = 300
        return label
    }()

    lazy var fourthStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [onboard4Image, onboard4Text])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = 22
        self.view.addSubview(stack)
        return stack
    }()

    // MARK: - Fifth Group

    lazy var onboard5Image: UIImageView = {
        let image = UIImage.gifImageWithName("onboard5")
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    lazy var onboard5Text: UILabel = {
        let label = UILabel()
        label.text = "Onboard5Text".localized()
        label.font = UIFont.josefinSansButton()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        label.frame.size.width = 300
        return label
    }()

    lazy var fifthStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [onboard5Image, onboard5Text])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = 22
        self.view.addSubview(stack)
        return stack
    }()

    // MARK: - Breadcrumb

    lazy var breadcrumb: BreadcrumbForm = {
        let breadcrumb = BreadcrumbForm(numberOfCrumbs: 5)
        breadcrumb.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(breadcrumb)
        return breadcrumb
    }()

    // MARK: - Next Button

    lazy var nextButton: UIButton = {
       let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(nextButtonBehavior), for: .touchUpInside)
        button.backgroundColor = UIColor(named: "Azure")
        button.titleLabel?.font = UIFont.josefinSansButton()
        button.tintColor = .white
        button.setTitle("Next".localized(), for: .normal)
        button.layer.cornerRadius = 5
        self.view.addSubview(button)
        return button
    }()

    // MARK: - Functions

    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        additionalConfigurations()
    }

    @objc func nextButtonBehavior() {
        if paginator == lastPage {
            dismiss(animated: true, completion: nil)
        } else {
            paginator += 1
            updateUI()
        }
    }

    func updateUI() {
        switch paginator {
        case 0:
            firstStack.isHidden = false
            secondStack.isHidden = true
            thirdStack.isHidden = true
            fourthStack.isHidden = true
            fifthStack.isHidden = true
        case 1:
            firstStack.isHidden = true
            secondStack.isHidden = false
            thirdStack.isHidden = true
            fourthStack.isHidden = true
            fifthStack.isHidden = true
        case 2:
            firstStack.isHidden = true
            secondStack.isHidden = true
            thirdStack.isHidden = false
            fourthStack.isHidden = true
            fifthStack.isHidden = true
        case 3:
            firstStack.isHidden = true
            secondStack.isHidden = true
            thirdStack.isHidden = true
            fourthStack.isHidden = false
            fifthStack.isHidden = true
        case 4:
            firstStack.isHidden = true
            secondStack.isHidden = true
            thirdStack.isHidden = true
            fourthStack.isHidden = true
            fifthStack.isHidden = false
        default:
            break
        }
        updateBreadcrumb()
    }

    func updateBreadcrumb() {
        UIView.animate(withDuration: 0.3, animations: { [self] in
            switch paginator {
            case 0:
                breadcrumb.firstCircle.transform = CGAffineTransform(scaleX: 1.4, y: 1.4)
                breadcrumb.firstLine.backgroundColor = .systemGray
                breadcrumb.secondCircle.transform = CGAffineTransform.identity
                breadcrumb.secondCircle.backgroundColor = .systemGray
                breadcrumb.secondLine.backgroundColor = .systemGray
                breadcrumb.thirdCircle.transform = CGAffineTransform.identity
                breadcrumb.thirdCircle.backgroundColor = .systemGray
                breadcrumb.thirdLine.backgroundColor = .systemGray
                breadcrumb.fourthCircle.transform = CGAffineTransform.identity
                breadcrumb.fourthCircle.backgroundColor = .systemGray
                breadcrumb.fourthLine.backgroundColor = .systemGray
                breadcrumb.fifthCircle.transform = CGAffineTransform.identity
                breadcrumb.fifthCircle.backgroundColor = .systemGray
            case 1:
                breadcrumb.firstCircle.transform = CGAffineTransform.identity
                breadcrumb.firstLine.backgroundColor = UIColor(named: "Azure")
                breadcrumb.secondCircle.transform = CGAffineTransform(scaleX: 1.4, y: 1.4)
                breadcrumb.secondCircle.backgroundColor = UIColor(named: "Azure")
                breadcrumb.secondLine.backgroundColor = .systemGray
                breadcrumb.thirdCircle.transform = CGAffineTransform.identity
                breadcrumb.thirdCircle.backgroundColor = .systemGray
                breadcrumb.thirdLine.backgroundColor = .systemGray
                breadcrumb.fourthCircle.transform = CGAffineTransform.identity
                breadcrumb.fourthCircle.backgroundColor = .systemGray
                breadcrumb.fourthLine.backgroundColor = .systemGray
                breadcrumb.fifthCircle.transform = CGAffineTransform.identity
                breadcrumb.fifthCircle.backgroundColor = .systemGray
            case 2:
                breadcrumb.firstCircle.transform = CGAffineTransform.identity
                breadcrumb.firstLine.backgroundColor = UIColor(named: "Azure")
                breadcrumb.secondCircle.transform = CGAffineTransform.identity
                breadcrumb.secondCircle.backgroundColor = UIColor(named: "Azure")
                breadcrumb.secondLine.backgroundColor = UIColor(named: "Azure")
                breadcrumb.thirdCircle.transform = CGAffineTransform(scaleX: 1.4, y: 1.4)
                breadcrumb.thirdCircle.backgroundColor = UIColor(named: "Azure")
                breadcrumb.thirdLine.backgroundColor = .systemGray
                breadcrumb.fourthCircle.transform = CGAffineTransform.identity
                breadcrumb.fourthCircle.backgroundColor = .systemGray
                breadcrumb.fourthLine.backgroundColor = .systemGray
                breadcrumb.fifthCircle.transform = CGAffineTransform.identity
                breadcrumb.fifthCircle.backgroundColor = .systemGray
            case 3:
                breadcrumb.firstCircle.transform = CGAffineTransform.identity
                breadcrumb.firstLine.backgroundColor = UIColor(named: "Azure")
                breadcrumb.secondCircle.transform = CGAffineTransform.identity
                breadcrumb.secondCircle.backgroundColor = UIColor(named: "Azure")
                breadcrumb.secondLine.backgroundColor = UIColor(named: "Azure")
                breadcrumb.thirdCircle.transform = CGAffineTransform.identity
                breadcrumb.thirdCircle.backgroundColor = UIColor(named: "Azure")
                breadcrumb.thirdLine.backgroundColor = UIColor(named: "Azure")
                breadcrumb.fourthCircle.transform = CGAffineTransform(scaleX: 1.4, y: 1.4)
                breadcrumb.fourthCircle.backgroundColor = UIColor(named: "Azure")
                breadcrumb.fourthLine.backgroundColor = .systemGray
                breadcrumb.fifthCircle.transform = CGAffineTransform.identity
                breadcrumb.fifthCircle.backgroundColor = .systemGray
            case 4:
                breadcrumb.firstCircle.transform = CGAffineTransform.identity
                breadcrumb.firstLine.backgroundColor = UIColor(named: "Azure")
                breadcrumb.secondCircle.transform = CGAffineTransform.identity
                breadcrumb.secondCircle.backgroundColor = UIColor(named: "Azure")
                breadcrumb.secondLine.backgroundColor = UIColor(named: "Azure")
                breadcrumb.thirdCircle.transform = CGAffineTransform.identity
                breadcrumb.thirdCircle.backgroundColor = UIColor(named: "Azure")
                breadcrumb.thirdLine.backgroundColor = UIColor(named: "Azure")
                breadcrumb.fourthCircle.transform = CGAffineTransform.identity
                breadcrumb.fourthCircle.backgroundColor = UIColor(named: "Azure")
                breadcrumb.fourthLine.backgroundColor = UIColor(named: "Azure")
                breadcrumb.fifthCircle.transform = CGAffineTransform(scaleX: 1.4, y: 1.4)
                breadcrumb.fifthCircle.backgroundColor = UIColor(named: "Azure")
            default:
                break
            }
        })
    }

    private func additionalConfigurations() {
        configureLayout()
        view.backgroundColor = UIColor(named: "Background")
        updateUI()
    }

    private func configureLayout() {
        NSLayoutConstraint.activate([
            firstStack.topAnchor.constraint(equalTo: self.view.topAnchor, constant: UIScreen.main.bounds.height/5),
            firstStack.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            firstStack.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16),

            secondStack.topAnchor.constraint(equalTo: self.view.topAnchor, constant: UIScreen.main.bounds.height/5),
            secondStack.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            secondStack.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16),

            thirdStack.topAnchor.constraint(equalTo: self.view.topAnchor, constant: UIScreen.main.bounds.height/5),
            thirdStack.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            thirdStack.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16),

            onboard3Image.widthAnchor.constraint(equalToConstant: 328),
            onboard3Image.heightAnchor.constraint(equalToConstant: 160),

            fourthStack.topAnchor.constraint(equalTo: self.view.topAnchor, constant: UIScreen.main.bounds.height/5),
            fourthStack.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            fourthStack.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16),

            onboard4Image.widthAnchor.constraint(equalToConstant: 328),
            onboard4Image.heightAnchor.constraint(equalToConstant: 160),

            fifthStack.topAnchor.constraint(equalTo: self.view.topAnchor, constant: UIScreen.main.bounds.height/5),
            fifthStack.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            fifthStack.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16),

            onboard5Image.widthAnchor.constraint(equalToConstant: 328),
            onboard5Image.heightAnchor.constraint(equalToConstant: 160),

            nextButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -50),
            nextButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            nextButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8),
            nextButton.heightAnchor.constraint(equalToConstant: 45),

            breadcrumb.bottomAnchor.constraint(equalTo: nextButton.topAnchor, constant: -15),
            breadcrumb.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            breadcrumb.heightAnchor.constraint(equalToConstant: 9),
            breadcrumb.widthAnchor.constraint(equalToConstant: 106)
        ])
    }
}
