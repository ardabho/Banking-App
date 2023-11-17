//
//  AppDelegate.swift
//  Bankey
//
//  Created by ARDA BUYUKHATIPOGLU on 13.11.2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    private let loginVC = LoginViewController()
    private let onboardingVC = OnboardingContainerViewController()
    private let mainTabBarController = MainTabBarController()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .systemBackground
        window?.makeKeyAndVisible()
        
        loginVC.delegate = self
        onboardingVC.delegate = self
        
        registerForNotifications()
        
        displayLogin()
        return true
    }
    
    private func registerForNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(didLogout), name: .Logout, object: nil)
    }
    
    private func displayLogin() {
        setRootViewController(loginVC)
    }
    
    private func displayNextScreen() {
        if LocalState.hasOnboarded {
            prepMainView()
            setRootViewController(mainTabBarController)
        } else {
            setRootViewController(onboardingVC)
        }
    }
    
    private func prepMainView() {
        mainTabBarController.setStatusBar()
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().backgroundColor = Colors.appColor
    }
    
}

extension AppDelegate {
    func setRootViewController(_ vc: UIViewController, animated: Bool = true) {
        guard animated, let window = self.window else {
            self.window?.rootViewController = vc
            self.window?.makeKeyAndVisible()
            return
        }
        
        window.rootViewController = vc
        window.makeKeyAndVisible()
        UIView.transition(with: window,
                          duration: 0.3,
                          options: .transitionCrossDissolve,
                          animations: nil,
                          completion: nil)
    }
}

extension AppDelegate: LoginViewControllerDelegate {
    func didLogin(_ sender: LoginViewController) {
        displayNextScreen()
    }
}

extension AppDelegate: OnboardingContainerViewControllerDelegate {
    func didFinishOnboarding(_ sender: OnboardingContainerViewController) {
        LocalState.hasOnboarded = true
        prepMainView()
        setRootViewController(mainTabBarController)
    }
}
extension AppDelegate {
    @objc func didLogout() {
        setRootViewController(loginVC)
        
    }
}


