//
//  AccountCellViewModel.swift
//  Bankey
//
//  Created by ARDA BUYUKHATIPOGLU on 17.11.2023.
//

import Foundation

enum AccountType: String {
    case Banking
    case CreditCard
    case Investment

    var localizedString: String {
        return NSLocalizedString(self.rawValue, comment: "")
    }
}

struct SummaryCellViewModel {
    let accountType: AccountType
    let accountName: String
    let balance: Decimal
    
    var balanceAsAttributedString: NSAttributedString {
        return CurrencyFormatter().makeAttributedCurrency(balance)
    }
}

