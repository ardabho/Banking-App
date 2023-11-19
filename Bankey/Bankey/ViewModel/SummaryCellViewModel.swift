//
//  AccountCellViewModel.swift
//  Bankey
//
//  Created by ARDA BUYUKHATIPOGLU on 17.11.2023.
//

import Foundation

struct SummaryCellViewModel {
    let accountType: AccountType
    let accountName: String
    let balance: Decimal
    
    var balanceAsAttributedString: NSAttributedString {
        return CurrencyFormatter().makeAttributedCurrency(balance)
    }
}

