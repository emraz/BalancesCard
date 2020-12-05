//
//  TransactionViewController.swift
//  BalancesCard
//
//  Created by Mahmudul Hasan on 11/28/20.
//

import UIKit

class TransactionViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    
    @IBOutlet weak var accountNameLabel: UILabel!
    @IBOutlet private weak var totalAmountLabel: UILabel!
    @IBOutlet weak var localCurrencyTotalAmountLabel: UILabel!
    @IBOutlet weak var inAmountLabel: UILabel!
    @IBOutlet weak var outAmountLabel: UILabel!
    
    var sModel: SummaryCellViewModel?
    
    private let viewModel = TransactionViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "TransactionTableViewCell",
                                 bundle: nil),
                           forCellReuseIdentifier: TransactionTableViewCell.reuseIdentifier)
        
        viewModel.getTransactions(transactionID: sModel?.id ?? 0) {[weak self] in
            DispatchQueue.main.async {
                self?.viewModel.setCurrency(crncy: self?.sModel?.currency ?? "")
                self?.updateConfig()
            }
        }
    }
    
    private func updateConfig() {
        tableView.reloadData()
        
        totalAmountLabel.text = viewModel.totalAmount
        accountNameLabel.text = sModel?.name
        inAmountLabel.text = viewModel.totalInAmount
        outAmountLabel.text = viewModel.totalOutAmount
    }
}

extension TransactionViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.sections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getRowsCount(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TransactionTableViewCell.reuseIdentifier,
                                                       for: indexPath) as? TransactionTableViewCell else {
            return UITableViewCell()
        }
        let cellViewModel = viewModel.cellViewModel(indexPath: indexPath)
        cell.viewModel = cellViewModel
        return cell
    }
}

extension TransactionViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 32
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let clsHeader: TransactionHeaderView = UIView.fromNib()
        clsHeader.name = viewModel.getSecionName(section: section)
        clsHeader.inAmnt = viewModel.getInAmout(section: section)
        clsHeader.outAmnt = viewModel.getOutAmout(section: section)

        return clsHeader
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

