//
//  SummaryViewController.swift
//  Bankey
//
//  Created by ARDA BUYUKHATIPOGLU on 16.11.2023.
//

import UIKit

class SummaryViewController: UIViewController {
    
    var accounts: [SummaryCellViewModel] = []
    
    private lazy var logoutBarButtonItem: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(didTapLogout))
        barButtonItem.tintColor = .black
        return barButtonItem
    }()
    
    private let tableview: UITableView = {
        let tableview = UITableView()
        tableview.translatesAutoresizingMaskIntoConstraints = false
        tableview.register(SummaryHeaderView.self, forHeaderFooterViewReuseIdentifier: SummaryHeaderView.reuseIdentifier)
        tableview.register(SummaryTableViewCell.self, forCellReuseIdentifier: SummaryTableViewCell.reuseIdentifier)
        return tableview
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpNavigationBar()
        setUpTableView()
        fetchData()
    }
    
    private func setUpNavigationBar() {
        navigationItem.rightBarButtonItem = logoutBarButtonItem
    }
    
    private func setUpTableView() {
        
        view.addSubview(tableview)
        
        tableview.delegate = self
        tableview.dataSource = self
        
        tableview.rowHeight = SummaryTableViewCell.cellHeight
        tableview.backgroundColor = Colors.appColor
        
        if #available(iOS 15.0, *) {
            tableview.sectionHeaderTopPadding = 0
        }
        
        NSLayoutConstraint.activate([
            tableview.topAnchor.constraint(equalTo: view.topAnchor),
            tableview.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableview.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableview.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    private func fetchData() {
        let savings = SummaryCellViewModel(accountType: .Banking,
                                           accountName: "Basic Savings",
                                           balance: 929466.23)
        let chequing = SummaryCellViewModel(accountType: .Banking,
                                            accountName: "No-Fee All-In Chequing",
                                            balance: 17562.44)
        let visa = SummaryCellViewModel(accountType: .CreditCard,
                                        accountName: "Visa Avion Card",
                                        balance: 412.83)
        let masterCard = SummaryCellViewModel(accountType: .CreditCard,
                                              accountName: "Student Mastercard",
                                              balance: 50.83)
        let investment1 = SummaryCellViewModel(accountType: .Investment,
                                               accountName: "Tax-Free Saver",
                                               balance: 2000.00)
        let investment2 = SummaryCellViewModel(accountType: .Investment,
                                               accountName: "Growth Fund",
                                               balance: 15000.00)
        
        accounts.append(savings)
        accounts.append(chequing)
        accounts.append(visa)
        accounts.append(masterCard)
        accounts.append(investment1)
        accounts.append(investment2)
        
    }
    
    @objc private func didTapLogout() {
        NotificationCenter.default.post(name: .Logout, object: nil)
    }
    
}

//MARK: DATA SOURCE
extension SummaryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        accounts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SummaryTableViewCell.reuseIdentifier, for: indexPath) as? SummaryTableViewCell else {
            return UITableViewCell()
        }
        
        let account = accounts[indexPath.row]
        cell.configure(with: account)
        
        
        return cell
        
    }
    
}

//MARK: Delegate
extension SummaryViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier:
                                                                SummaryHeaderView.reuseIdentifier) as! SummaryHeaderView
        
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return SummaryHeaderView.headerHeight
    }
}


