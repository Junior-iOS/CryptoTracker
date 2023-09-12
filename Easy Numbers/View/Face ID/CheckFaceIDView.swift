//
//  CheckFaceIDView.swift
//  Easy Numbers
//
//  Created by NJ Development on 02/08/23.
//

import UIKit

protocol CheckFaceIDViewDelegate: AnyObject {
    func didTapFaceID()
}

final class CheckFaceIDView: UIView {
    private lazy var padlock: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = SFSymbol.lock.image
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = LocalizableStrings.faceIDLockedTitle.localized
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = NJFont.bold(ofSize: 23)
        return label
    }()

    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = LocalizableStrings.faceIDLockedMessage.localized
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = NJFont.regular(ofSize: 18)
        return label
    }()

    private lazy var vStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [padlock, titleLabel, descriptionLabel])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 0
        stack.distribution = .fill
        stack.alignment = .center
        return stack
    }()

    private lazy var faceIdButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(didTapUseFaceID), for: .touchUpInside)
        button.backgroundColor = .systemBlue
        button.setTitle(LocalizableStrings.faceIDLockedButton.localized, for: .normal)
        button.layer.cornerRadius = 20
        button.clipsToBounds = true
        return button
    }()

    weak var delegate: CheckFaceIDViewDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        addComponents()
        backgroundColor = .white
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        nil
    }

    private func addComponents() {
        addSubviews(vStack, faceIdButton)

        NSLayoutConstraint.activate([
            vStack.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            vStack.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            vStack.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
            vStack.heightAnchor.constraint(equalToConstant: 300),

            padlock.heightAnchor.constraint(equalToConstant: 70),

            faceIdButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            faceIdButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            faceIdButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -60),
            faceIdButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }

    @objc
    private func didTapUseFaceID() {
        delegate?.didTapFaceID()
    }
}
