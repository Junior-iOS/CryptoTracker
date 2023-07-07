//
//  SavedGamesView.swift
//  Easy Numbers
//
//  Created by NJ Development on 23/05/23.
//

import UIKit

class SavedGamesView: UIView {
    let tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(cellClass: SavedGamesTableViewCell.self)
        tableView.separatorStyle = .none
        tableView.layer.cornerRadius = 5
        tableView.clipsToBounds = true
        tableView.backgroundColor = .clear
        return tableView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupConstraints() {
        addSubviews(tableView)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor, constant: .kTopMargin),
            tableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

fileprivate extension CGFloat {
    static let kTopMargin: CGFloat = 80
}
