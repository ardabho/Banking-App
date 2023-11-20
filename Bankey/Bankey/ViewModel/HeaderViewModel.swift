//
//  HeaderViewModel.swift
//  Bankey
//
//  Created by ARDA BUYUKHATIPOGLU on 19.11.2023.
//

import Foundation

struct HeaderViewModel {
    let name: String
    let date: Date
    
    var dateFormatted: String {
        return date.monthDayYearString
    }
}
