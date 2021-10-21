//
//  DisplayTableViewController.swift
//  MimicRPG
//
//  Created by Eduardo Oliveira on 20/10/21.
//
// swiftlint:disable force_cast

import UIKit

class DisplayTableViewController: UIViewController {

    var buttons: [UIButton] = []
    var viewModel: DisplayTableViewModelType!
    var coordinator: Coordinator?

    lazy var bannerView: UIImageView = {
        let bannerView = UIImageView()
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        bannerView.layer.opacity = 0.5
        bannerView.layer.zPosition = 1
        let color = UIImage.imageWithColor(color: .brandy)
        bannerView.image = color
        view.addSubview(bannerView)
        return bannerView
    }()

    lazy var titleView: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Guerra da Centelha"
        label.font = UIFont.josefinSansBold30()
        label.tintColor = UIColor(named: "FontColor")
        view.addSubview(label)
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(named: "Background")

        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.titleTextAttributes = [.font:
        UIFont.boldSystemFont(ofSize: 20.0),
                                      .foregroundColor: UIColor.white]
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.prefersLargeTitles = true

        setupElements()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func setupElements() {
        configureConstraints()
    }

    func configureConstraints() {
        NSLayoutConstraint.activate([
            bannerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -(navigationController?.navigationBar.frame.height)!),
            bannerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bannerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bannerView.heightAnchor.constraint(equalToConstant: 139),
            titleView.topAnchor.constraint(equalTo: bannerView.bottomAnchor, constant: 15),
            titleView.leadingAnchor.constraint(equalTo: bannerView.leadingAnchor, constant: 16)
        ])
    }
}

extension DisplayTableViewController: DisplayTableViewModelOutput {

}
