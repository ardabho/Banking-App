//
//  SummaryViewController.swift
//  Bankey
//
//  Created by ARDA BUYUKHATIPOGLU on 16.11.2023.
//

import UIKit

class SummaryViewController: UIViewController {

    private let tableview: UITableView = {
       let tableview = UITableView()
        tableview.translatesAutoresizingMaskIntoConstraints = false
        tableview.register(SummaryHeaderView.self, forHeaderFooterViewReuseIdentifier: SummaryHeaderView.reuseIdentifier)
        tableview.register(SummaryTableViewCell.self, forCellReuseIdentifier: SummaryTableViewCell.reuseIdentifier)
        return tableview
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpTableView()
    }
    
    private func setUpTableView() {
        
        view.addSubview(tableview)
        
        tableview.delegate = self
        tableview.dataSource = self
        
        tableview.rowHeight = SummaryTableViewCell.cellHeight
        
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
    
}

//MARK: DATA SOURCE
extension SummaryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SummaryTableViewCell.reuseIdentifier, for: indexPath) as! SummaryTableViewCell
        
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


