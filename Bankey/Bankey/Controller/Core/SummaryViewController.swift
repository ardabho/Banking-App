//
//  SummaryViewController.swift
//  Bankey
//
//  Created by ARDA BUYUKHATIPOGLU on 16.11.2023.
//

import UIKit

class SummaryViewController: UIViewController {
    
    var profile: Profile?
    var accounts: [Account] = []
    
    private lazy var logoutBarButtonItem: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(title: L10n.buttonLogout, style: .plain, target: self, action: #selector(didTapLogout))
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
    
    private let headerView = SummaryHeaderView(frame: .zero)
    
    private let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpNavigationBar()
        setUpTableView()
        setupRefreshControl()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        fetchData()
    }
    
    private func setUpNavigationBar() {
        navigationItem.rightBarButtonItem = logoutBarButtonItem
    }
    
    private func setUpTableView() {
        
        view.addSubview(tableview)
        
        tableview.delegate = self
        tableview.dataSource = self
        
        NSLayoutConstraint.activate([
            tableview.topAnchor.constraint(equalTo: view.topAnchor),
            tableview.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableview.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableview.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
        
        tableview.rowHeight = SummaryTableViewCell.cellHeight
        tableview.backgroundColor = Colors.appColor
        if #available(iOS 15.0, *) {
            tableview.sectionHeaderTopPadding = 0
        }
    }
    
    private func setupRefreshControl() {
        refreshControl.tintColor = Colors.appColor
        refreshControl.addTarget(self, action: #selector(refreshContent), for: .valueChanged)
        tableview.refreshControl = refreshControl
    }
    
    private func fetchData() {
        let dispatchGroup = DispatchGroup()
        
        //Random user for sake of testing
        let userId = String(Int.random(in: 1..<4))
        
        dispatchGroup.enter()
        APICaller.shared.fetchProfileData(id: userId) { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success(let profile):
                self.profile = profile
            case .failure(let error):
                print(error)
            }
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        
        APICaller.shared.fetchAccountsData(id: userId) { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success(let accounts):
                self.accounts = accounts

            case .failure(let error):
                print(error)
            }
            dispatchGroup.leave()
        }
        
        dispatchGroup.notify(queue: .main) { [weak self] in
            print("All url tasks are completed")
            self?.tableview.reloadData()
            self?.tableview.refreshControl?.endRefreshing()
        }
    }
    
    @objc private func didTapLogout() {
        NotificationCenter.default.post(name: .Logout, object: nil)
    }
    
    @objc private func refreshContent() {
        fetchData()
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
        
        cell.configure(with: SummaryCellViewModel(accountType: account.type, accountName: account.name, balance: account.amount))
        
        
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
        
        view.configureHeader(with: HeaderViewModel(
            name: "\(profile?.firstName ?? "") \(profile?.lastName ?? "")",
                                                   date: Date()))
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return SummaryHeaderView.headerHeight
    }
}


