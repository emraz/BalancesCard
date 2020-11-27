//
//  SummaryViewController.swift
//  BalancesCard
//
//  Created by Mahmudul Hasan on 11/27/20.
//

import UIKit

class SummaryViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var totalAmountLabel: UILabel!
    private let viewModel = SummaryViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "SummaryTableViewCell",
                                 bundle: nil),
                           forCellReuseIdentifier: SummaryTableViewCell.reuseIdentifier)
        
        viewModel.getAccounts {[weak self] in
            DispatchQueue.main.async {
                self?.updateConfig()
            }
        }
    }
    
    private func updateConfig() {
        tableView.reloadData()
        totalAmountLabel.text = viewModel.totalAmount
    }
}

extension SummaryViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.sections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getRowsCount(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SummaryTableViewCell.reuseIdentifier,
                                                       for: indexPath) as? SummaryTableViewCell else {
            return UITableViewCell()
        }
        let cellViewModel = viewModel.cellViewModel(indexPath: indexPath)
        cell.viewModel = cellViewModel
        return cell
    }
}

extension SummaryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 32
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let clsHeader: SummaryHeaderView = UIView.fromNib()
        clsHeader.name = viewModel.getSecionName(section: section)
        return clsHeader
    }
}
