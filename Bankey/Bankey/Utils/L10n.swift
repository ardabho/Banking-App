//
//  L10n.swift
//  Bankey
//
//  Created by ARDA BUYUKHATIPOGLU on 14.11.2023.
//

import Foundation

class L10n {
    static let loginTitle = NSLocalizedString("login.title", comment: "title for login screen")
    static let loginDescription = NSLocalizedString("login.description", comment: "description for login screen")
    static let loginUsername = NSLocalizedString("login.username", comment: "username label for login screen")
    static let loginPassword = NSLocalizedString("login.password", comment: "password label for login screen")
    static let loginButtonTitle = NSLocalizedString("login.button.title", comment: "title for login button")
    static let emptyUsernameError = NSLocalizedString("login.error.empty.username", comment: "error message for empty username")
    static let emptyPasswordError = NSLocalizedString("login.error.empty.password", comment: "error message for empty password")
    static let emptyUsernameAndPasswordError = NSLocalizedString("login.error.empty.username.and.password", comment: "error message for empty username and password")
    static let incorrectUsernameOrPassword = NSLocalizedString("login.error.incorrect.username.or.password", comment: "error message for incorrent username or password")
    
    static let onboardingFirstDescription = NSLocalizedString("onboarding.first.description", comment: "description for first onboarding screen")
    static let onboardingSecondDescription = NSLocalizedString("onboarding.second.description", comment: "description for second onboarding screen")
    static let onboardingThirdDescription = NSLocalizedString("onboarding.third.description", comment: "description for third onboarding screen")
    
    static let buttonClose = NSLocalizedString("button.close", comment: "text for close button")
    static let buttonPrevious = NSLocalizedString("button.previous", comment: "text for previous button")
    static let buttonNext = NSLocalizedString("button.next", comment: "text for next button")
    static let buttonLogout = NSLocalizedString("button.logout", comment: "text for logout button")
    
    static let summary = NSLocalizedString("tabbar.summary", comment: "tab bar text: summary")
    static let moveMoney = NSLocalizedString("tabbar.move", comment: "tab bar text: move")
    static let more = NSLocalizedString("tabbar.more", comment: "tab bar text: more")
    
    static let goodMorning = NSLocalizedString("greeting.goodmorning", comment: "greeting")
    static let goodAfternoon = NSLocalizedString("greeting.goodafternoon", comment: "greeting")
    static let goodEvening = NSLocalizedString("greeting.goodevening", comment: "greeting")
    static let goodNight = NSLocalizedString("greeting.goodnight", comment: "greeting")
    
    static let banking = NSLocalizedString("Banking", comment: "Banking category")
    static let creditCard = NSLocalizedString("CreditCard", comment: "Credit Card category")
    static let investment = NSLocalizedString("Investment", comment: "Investment category")
    
    static let currentBalance = NSLocalizedString("currentbalance", comment: "Current balance label")
    static let value = NSLocalizedString("value", comment: "Value label")
}

