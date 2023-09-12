//
//  GameViewCell.swift
//  Easy Numbers
//
//  Created by NJ Development on 01/07/23.
//

import Foundation
import UIKit

class GameViewCell: UICollectionViewCell {
    private lazy var lblNumber: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = NJFont.demibold(ofSize: 25)
        label.textAlignment = .center
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addComponents()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        nil
    }

    private func addComponents() {
        addSubview(lblNumber)

        NSLayoutConstraint.activate([
            lblNumber.topAnchor.constraint(equalTo: topAnchor),
            lblNumber.leadingAnchor.constraint(equalTo: leadingAnchor),
            lblNumber.trailingAnchor.constraint(equalTo: trailingAnchor),
            lblNumber.bottomAnchor.constraint(equalTo: bottomAnchor),

            lblNumber.heightAnchor.constraint(equalToConstant: 50),
            lblNumber.widthAnchor.constraint(equalToConstant: 50)
        ])
    }

    func configure(number: Int) {
        DispatchQueue.main.async {
            self.lblNumber.text = number < 10 ? "0\(number)" : "\(number)"
        }
    }
}
