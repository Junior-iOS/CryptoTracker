//
//  InfoViewController.swift
//  Easy Numbers
//
//  Created by NJ Development on 13/05/23.
//

import UIKit

class InfoViewController: UIViewController {
    private lazy var njImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(named: "Gradient Logo")
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .darkGray
        addComponents()
    }

    private func addComponents() {
        view.addSubview(njImageView)

        NSLayoutConstraint.activate([
            njImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            njImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            njImageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            njImageView.heightAnchor.constraint(equalToConstant: 150)
        ])
    }
}
