//
//  Protocols.swift
//  Bankey
//
//  Created by ARDA BUYUKHATIPOGLU on 16.11.2023.
//

import Foundation

protocol LoginViewControllerDelegate: AnyObject {
    func didLogin(_ sender: LoginViewController)
}

protocol OnboardingContainerViewControllerDelegate: AnyObject {
    func didFinishOnboarding(_ sender: OnboardingContainerViewController)
}

protocol LogoutDelegate: AnyObject {
    func didLogout()
}
