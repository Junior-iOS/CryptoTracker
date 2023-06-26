//
//  OutOfOrderView.swift
//  Easy Numbers
//
//  Created by NJ Development on 24/06/23.
//

import UIKit

class OutOfOrderView: UIView {
    
    private lazy var outOfOrderImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        return imageView
    }()

    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Desculpe o incomodo.\nEstaremos de volta em alguns minutos!"
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = ThemeFont.demibold(ofSize: 19)
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addComponents()
        backgroundColor = UIColor(red: 0.24, green: 0.60, blue: 0.92, alpha: 1.00)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        nil
    }
    
    private func addComponents() {
        addSubviews(outOfOrderImage, descriptionLabel)
        
        NSLayoutConstraint.activate([
            outOfOrderImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            outOfOrderImage.centerYAnchor.constraint(equalTo: centerYAnchor),
            outOfOrderImage.widthAnchor.constraint(equalToConstant: 300),
            outOfOrderImage.heightAnchor.constraint(equalToConstant: 300),
            
            descriptionLabel.topAnchor.constraint(equalTo: outOfOrderImage.bottomAnchor, constant: 40),
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
        
        setupImage()
    }
    
    private func setupImage() {
        DispatchQueue.main.async {
            self.outOfOrderImage.image = UIImage(named: "out_of_order")
        }
    }
}
