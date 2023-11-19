//
//  Accounts.swift
//  Bankey
//
//  Created by ARDA BUYUKHATIPOGLU on 19.11.2023.
//

import Foundation

enum AccountType: String, Codable {
    case Banking
    case CreditCard
    case Investment

    var localizedString: String {
        return NSLocalizedString(self.rawValue, comment: "")
    }
}

struct Account: Codable {
    let id: String
    let type: AccountType
    let name: String
    let amount: Decimal
    let createdDateTime: Date
    
    enum CodingKeys: String, CodingKey {
        case id
        case type
        case name
        case amount
        case createdDateTime
    }
}
