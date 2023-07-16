//
//  SettingsView.swift
//  Easy Numbers
//
//  Created by NJ Development on 14/07/23.
//

import UIKit

class SettingsView: UIView {
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(cellClass: SettingsTableViewCell.self)
        tableView.separatorStyle = .none
        tableView.layer.cornerRadius = 5
        tableView.clipsToBounds = true
        tableView.indicatorStyle = .white
        tableView.showsVerticalScrollIndicator = false
        tableView.tableFooterView = createFooter()
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createFooter() -> UIView {
        let footer = UIView(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: 100))
        footer.backgroundColor = .secondarySystemGroupedBackground
        return footer
    }
    
    func setupConstraints() {
        addSubviews(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

fileprivate extension CGFloat {
    static let kTopMargin: CGFloat = 80
}
