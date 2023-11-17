//
//  SummaryTableViewCell.swift
//  Bankey
//
//  Created by ARDA BUYUKHATIPOGLU on 16.11.2023.
//

import UIKit

class SummaryTableViewCell: UITableViewCell {
    static let reuseIdentifier = "SummaryTableViewCell"
    static let cellHeight: CGFloat = 112
    
    private let balanceStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        return stackView
    }()
    
    private let typeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Banking"
        label.font = UIFont.preferredFont(forTextStyle: .caption1)
        return label
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "No-Fee All- In Chequing"
        label.font = UIFont.preferredFont(forTextStyle: .body)
        return label
    }()
    
    private let balanceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Current balance"
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.textAlignment = .right
        return label
    }()
    
    private let balanceAmountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(typeLabel)
        contentView.addSubview(underlineView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(chevronImageView)
        
        contentView.addSubview(balanceStackView)
        balanceStackView.addArrangedSubview(balanceLabel)
        balanceStackView.addArrangedSubview(balanceAmountLabel)
        
        balanceAmountLabel.attributedText = makeFormattedBalance(dollars: "XXX,XXX", cents: "XX")
        
        layout()
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
        
        typeLabel.text = vm.accountType.localizedString
        nameLabel.text = vm.accountName
        balanceAmountLabel.attributedText = vm.balanceAsAttributedString
        switch vm.accountType {
        case .Banking:
            balanceLabel.text = "Current balance"
            underlineView.backgroundColor = Colors.appColor
        case .CreditCard:
            balanceLabel.text = "Current balance"
            underlineView.backgroundColor = Colors.orange
        case .Investment:
            balanceLabel.text = "Value"
            underlineView.backgroundColor = Colors.purple
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
