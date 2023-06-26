//
//  SavedGamesTableViewCell.swift
//  Easy Numbers
//
//  Created by NJ Development on 23/05/23.
//

import UIKit

class SavedGamesTableViewCell: UITableViewCell {
    private lazy var cellBackgroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.96, alpha: 1.00)
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        return view
    }()

    private lazy var gameImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = kGameImageSize / 2
        imageView.clipsToBounds = true
        return imageView
    }()

    private lazy var gameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()

    private let kCellBackgroundMargin: CGFloat = 10
    private let kGameMargin: CGFloat = 8
    private let kLabelMargin: CGFloat = 16
    private let kGameImageSize: CGFloat = 30

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        addComponents()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        nil
    }

    private func addComponents() {
        contentView.addSubview(cellBackgroundView)
        cellBackgroundView.addSubviews(gameImage, gameLabel)

        NSLayoutConstraint.activate([
            cellBackgroundView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 3),
            cellBackgroundView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: kLabelMargin),
            cellBackgroundView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -kLabelMargin),
            cellBackgroundView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -3),

            gameImage.leadingAnchor.constraint(equalTo: cellBackgroundView.leadingAnchor, constant: kCellBackgroundMargin),
            gameImage.centerYAnchor.constraint(equalTo: centerYAnchor),
            gameImage.widthAnchor.constraint(equalToConstant: kGameImageSize),
            gameImage.heightAnchor.constraint(equalToConstant: kGameImageSize),

            gameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: kLabelMargin),
            gameLabel.leadingAnchor.constraint(equalTo: gameImage.trailingAnchor, constant: kGameMargin),
            gameLabel.trailingAnchor.constraint(equalTo: cellBackgroundView.trailingAnchor, constant: -kLabelMargin),
            gameLabel.bottomAnchor.constraint(equalTo: cellBackgroundView.bottomAnchor, constant: -kLabelMargin)
        ])
    }

    func configure(_ savedGames: String) {
        self.gameLabel.text = savedGames.removeBrackets()
        self.gameLabel.textAlignment = savedGames.count == 15 || savedGames.count == 50 ? .justified : .left

        if savedGames.count <= 20 {
            gameImage.image = UIImage(named: "quina")
        } else if savedGames.count > 20 && savedGames.count <= 24 {
            gameImage.image = UIImage(named: "megasena")
        } else if savedGames.count > 24 && savedGames.count <= 60 {
            gameImage.image = UIImage(named: "lotofacil")
        } else {
            gameImage.image = UIImage(named: "lotomania")
        }
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        self.cellBackgroundView.frame = .zero
        self.gameImage.image = nil
        self.gameLabel.text = nil
    }
}
