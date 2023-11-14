//
//  OnboardingContainerViewController.swift
//  Bankey
//
//  Created by ARDA BUYUKHATIPOGLU on 14.11.2023.
//

import UIKit

class OnboardingContainerViewController: UIViewController {
    
    private lazy var pageViewController: UIPageViewController = {
        let pageVC = UIPageViewController(transitionStyle: .scroll,
                                          navigationOrientation: .horizontal)
        pageVC.dataSource = self
        pageVC.view.translatesAutoresizingMaskIntoConstraints = false
        
        return pageVC
    }()
    
    var pages = [UIViewController]()
    
    var currentVC: UIViewController? {
        didSet {
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemPurple
        
        addChild(pageViewController)
        view.addSubview(pageViewController.view)
        pageViewController.didMove(toParent: self)
        
        configurePageVC()
    }
    
    private func configurePageVC() {
        let page1 = OnboardingViewController(heroImageName: "delorean", titleText: L10n.onboardingFirstDescription)
        let page2 = OnboardingViewController(heroImageName: "thumbs", titleText: L10n.onboardingSecondDescription)
        let page3 = OnboardingViewController(heroImageName: "world", titleText: L10n.onboardingThirdDescription)
        
        pages.append(page1)
        pages.append(page2)
        pages.append(page3)
        
        pageViewController.setViewControllers(
            [pages.first!],
            direction: .forward,
            animated: true)
        
        NSLayoutConstraint.activate([
            pageViewController.view.topAnchor.constraint(equalTo: view.topAnchor),
            pageViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pageViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            pageViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        
        currentVC = pages.first!
        
    }
}

extension OnboardingContainerViewController: UIPageViewControllerDataSource {
    
    
    //MARK: Page view controller methods
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        return getPreviousViewController(from: viewController)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        return getNextViewController(from: viewController)
    }
    
    private func getPreviousViewController(from viewController: UIViewController) -> UIViewController? {
        guard let index = pages.firstIndex(of: viewController),
              index - 1 >= 0 else {
            return nil
        }
        currentVC = pages[index - 1]
        return pages[index - 1]
    }
    
    private func getNextViewController(from viewController: UIViewController) -> UIViewController? {
        guard let index = pages.firstIndex(of: viewController),
              index + 1 < pages.count else {
            return nil
        }
        currentVC = pages[index + 1]
        return pages[index + 1]
    }
    
    
    
    //MARK: Page Indicator methods:
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return pages.count
    }
    
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        guard let currentVC = self.currentVC else {
            return 0
        }
        
        return pages.firstIndex(of: currentVC) ?? 0
    }
}
