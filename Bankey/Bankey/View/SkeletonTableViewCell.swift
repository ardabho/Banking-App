//
//  SkeletonTableViewCell.swift
//  Bankey
//
//  Created by ARDA BUYUKHATIPOGLU on 20.11.2023.
//

import UIKit

class SkeletonTableViewCell: UITableViewCell, SkeletonLoadable {
    static let reuseIdentifier = "SkeletonTableViewCell"
    static let cellHeight: CGFloat = 112
    
    private let balanceStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 5
        return stackView
    }()
    
    private let typeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "---------"
        label.font = UIFont.preferredFont(forTextStyle: .caption1)
        return label
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "           "
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private let balanceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = L10n.currentBalance
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.textAlignment = .right
        return label
    }()
    
    private let balanceAmountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private let underlineView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Colors.appColor
        return view
    }()
    
    private let chevronImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "chevron.right")
        imageView.tintColor = Colors.appColor
        return imageView
    }()
    
    // Gradients
    let typeLayer = CAGradientLayer()
    let nameLayer = CAGradientLayer()
    let balanceLayer = CAGradientLayer()
    let balanceAmountLayer = CAGradientLayer()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(typeLabel)
        contentView.addSubview(underlineView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(chevronImageView)
        
        contentView.addSubview(balanceStackView)
        balanceStackView.addArrangedSubview(balanceLabel)
        balanceStackView.addArrangedSubview(balanceAmountLabel)
        
        balanceAmountLabel.attributedText = makeFormattedBalance(dollars: "-XXX,XXX-", cents: "-XX-")
        
        setupLayers()
        setupAnimation()
        layout()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        typeLayer.frame = typeLabel.bounds
        typeLayer.cornerRadius = typeLabel.bounds.height/2
        
        nameLayer.frame = nameLabel.bounds
        nameLayer.cornerRadius = nameLabel.bounds.height/2
        
        balanceLayer.frame = balanceLabel.bounds
        balanceLayer.cornerRadius = balanceLabel.bounds.height/2
        
        balanceAmountLayer.frame = balanceAmountLabel.bounds
        balanceAmountLayer.cornerRadius = balanceAmountLabel.bounds.height/2
        
    }
    
    private func layout() {
        
        underlineView.layer.cornerRadius = 2
        
        NSLayoutConstraint.activate([
            typeLabel.topAnchor.constraint(equalToSystemSpacingBelow: contentView.topAnchor, multiplier: 2),
            typeLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: contentView.leadingAnchor, multiplier: 2),
            
            underlineView.topAnchor.constraint(equalToSystemSpacingBelow: typeLabel.bottomAnchor, multiplier: 1),
            underlineView.leadingAnchor.constraint(equalToSystemSpacingAfter: contentView.leadingAnchor, multiplier: 2),
            underlineView.widthAnchor.constraint(equalToConstant: 60),
            underlineView.heightAnchor.constraint(equalToConstant: 4),
            
            
            nameLabel.topAnchor.constraint(equalToSystemSpacingBelow: underlineView.bottomAnchor, multiplier: 2),
            nameLabel.leadingAnchor.constraint(equalTo: underlineView.leadingAnchor),
            
            balanceStackView.topAnchor.constraint(equalToSystemSpacingBelow: underlineView.bottomAnchor, multiplier: 0),
            contentView.trailingAnchor.constraint(equalToSystemSpacingAfter: balanceStackView.trailingAnchor, multiplier: 4),
            balanceStackView.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 4),
            
            chevronImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            trailingAnchor.constraint(equalToSystemSpacingAfter: chevronImageView.trailingAnchor, multiplier: 1)
            
        ])
    }
    
    private func setupLayers() {
        typeLayer.startPoint = CGPoint(x: 0, y: 0.5)
        typeLayer.endPoint = CGPoint(x: 1, y: 0.5)
        typeLabel.layer.addSublayer(typeLayer)
        
        nameLayer.startPoint = CGPoint(x: 0, y: 0.5)
        nameLayer.endPoint = CGPoint(x: 1, y: 0.5)
        nameLabel.layer.addSublayer(nameLayer)
        
        balanceLayer.startPoint = CGPoint(x: 0, y: 0.5)
        balanceLayer.endPoint = CGPoint(x: 1, y: 0.5)
        balanceLabel.layer.addSublayer(balanceLayer)
        
        balanceAmountLayer.startPoint = CGPoint(x: 0, y: 0.5)
        balanceAmountLayer.endPoint = CGPoint(x: 1, y: 0.5)
        balanceAmountLabel.layer.addSublayer(balanceAmountLayer)
    }
    
    private func setupAnimation() {
        let typeGroup = makeAnimationGroup()
        typeGroup.beginTime = 0.0
        typeLayer.add(typeGroup, forKey: "backgroundColor")
        
        let nameGroup = makeAnimationGroup(previousGroup: typeGroup)
        nameLayer.add(nameGroup, forKey: "backgroundColor")
        
        let balanceGroup = makeAnimationGroup(previousGroup: nameGroup)
        balanceLayer.add(balanceGroup, forKey: "backgroundColor")
        
        let balanceAmountGroup = makeAnimationGroup(previousGroup: balanceGroup)
        balanceAmountLayer.add(balanceAmountGroup, forKey: "backgroundColor")
    }
    
    
    private func makeFormattedBalance(dollars: String, cents: String) -> NSMutableAttributedString {
        let currencySignAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.preferredFont(forTextStyle: .callout), .baselineOffset: 8]
        let currencyAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.preferredFont(forTextStyle: .title1)]
        let pointCurrencyAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.preferredFont(forTextStyle: .footnote)]
        
        let rootString = NSMutableAttributedString(string: "$", attributes: currencySignAttributes)
        let currencyString = NSAttributedString(string: dollars, attributes: currencyAttributes)
        let centString = NSAttributedString(string: cents, attributes: pointCurrencyAttributes)
        
        rootString.append(currencyString)
        rootString.append(centString)
        
        return rootString
    }
    
    func configure(with vm: SummaryCellViewModel) {
        let account = SummaryCellViewModel.makeSkeleton()
        typeLabel.text = "    "
        nameLabel.text = "     "
        balanceLabel.text = "     "
        underlineView.backgroundColor = .systemGray
        balanceAmountLabel.text = "    "
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
