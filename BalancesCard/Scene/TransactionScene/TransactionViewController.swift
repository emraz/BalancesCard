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
    
    private let viewModel = TransactionViewModel()
    

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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
