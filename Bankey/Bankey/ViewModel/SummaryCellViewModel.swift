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
    
    static func makeSkeleton() -> Account {
        return Account(id: "1", type: .Banking, name: "Account name", amount: 0.0, createdDateTime: Date())
    }
}

