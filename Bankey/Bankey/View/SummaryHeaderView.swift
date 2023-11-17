//
//  SummaryHeaderView.swift
//  Bankey
//
//  Created by ARDA BUYUKHATIPOGLU on 16.11.2023.
//

import UIKit

class SummaryHeaderView: UITableViewHeaderFooterView {
    
    static let reuseIdentifier = "SummaryHeaderView"
    static let headerHeight: CGFloat = 144
    
    private let horizontalStack: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        
        return stackView
    }()
    
    private let imageview: UIImageView = {
        let imageview = UIImageView()
        imageview.contentMode = .scaleAspectFit
        imageview.translatesAutoresizingMaskIntoConstraints = false
        imageview.image = UIImage(systemName: "sun.max.fill")
        imageview.tintColor = .systemYellow
        return imageview
    }()
    
    private let verticalStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .title1)
        label.text = "Bankey"
        label.textColor = .black
        return label
    }()
    
    private let greetingsLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .callout)
        label.text = "Good Morning"
        label.textColor = .black
        return label
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .callout)
        label.text = "Jonathan"
        label.textColor = .black
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .callout)
        label.text = "Oct 29, 2021"
        label.textColor = .black
        return label
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = Colors.appColor
        self.backgroundView = backgroundView
        
        configureContents()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureContents() {
        
        contentView.addSubview(horizontalStack)
        
        horizontalStack.addArrangedSubview(verticalStack)
        horizontalStack.addArrangedSubview(imageview)
        
        verticalStack.addArrangedSubview(titleLabel)
        verticalStack.addArrangedSubview(greetingsLabel)
        verticalStack.addArrangedSubview(nameLabel)
        verticalStack.addArrangedSubview(dateLabel)
        
        NSLayoutConstraint.activate([
            horizontalStack.topAnchor.constraint(equalToSystemSpacingBelow: contentView.topAnchor, multiplier: 2),
            horizontalStack.leadingAnchor.constraint(equalToSystemSpacingAfter: contentView.leadingAnchor, multiplier: 2),
            contentView.trailingAnchor.constraint(equalToSystemSpacingAfter: horizontalStack.trailingAnchor, multiplier: 2).withPriority(.defaultHigh),
            contentView.bottomAnchor.constraint(equalToSystemSpacingBelow: horizontalStack.bottomAnchor, multiplier: 2).withPriority(.defaultHigh),
            
            imageview.widthAnchor.constraint(equalTo: horizontalStack.heightAnchor, constant: -20),
            
        ])
        
    }
}
