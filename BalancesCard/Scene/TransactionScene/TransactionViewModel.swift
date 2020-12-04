//
//  TransactionViewModel.swift
//  BalancesCard
//
//  Created by Mahmudul Hasan on 11/28/20.
//

import Foundation
import UIKit

class TransactionViewModel {
    //For dummy data from local json
    private let networking = NetworkingStab()
    
    //For real api calling
    //private let networking = Networking()
    
    private var transactions: [SectionedTransactionModel] = []
    private var totalAmountInAccounts: Int = 0
    private var totalInAmount: Int = 0
    private var totalOutAmount: Int = 0

    private var currentCurrency: String = ""
    
    func getAccounts(completion: (() -> Void)?) {
        networking.requestNetworkTask(endpoint: .transaction, type: TransactionTopLevel.self) {[weak self] response in
            guard let this = self else { return}
            switch response {
            case.success(let transactionTopLevel):
                guard let allTransactions = transactionTopLevel.transactions else { return }
                var totalSum: Int = 0
                var totalIn: Int = 0
                var totalOut: Int = 0
                
                // MAP
                for transaction in allTransactions {
                    
                    let amnt = transaction.amount
                    let date = transaction.date ?? Date()
                    let trnscnDesc = transaction.transactionDescription ?? ""
                    
                    let dt = date.toString(dateFormat: "")

                    let transactionInfo = TransactionInfo(transactionDate: dt, transactionDescription: trnscnDesc, amountDescription: "\(amnt)")
                    
                    let monthInt = Calendar.current.component(.month, from: date) // 4
                    let monthStr = Calendar.current.monthSymbols[monthInt-1] // April

                    if let index = this.transactions.firstIndex(where: { $0.month == monthStr }) {
                        var transcn = this.transactions[index]
                        transcn.transactionInfo.append(transactionInfo)
                        this.transactions[index] = transcn
                    }else {
                        this.transactions.append(SectionedTransactionModel.init(month: monthStr, transactionInfo: [transactionInfo]))
                    }
                    totalSum += transaction.amount
                    if transaction.amount < 0 {
                        totalOut += transaction.amount
                    }
                    else {
                        totalIn += transaction.amount
                    }
                }
                this.totalAmountInAccounts = totalSum
                this.totalInAmount = totalIn
                this.totalOutAmount = totalOut

                // SORT
                this.transactions = this.transactions.sorted { $0.month < $1.month }
            case .failure(let error):
                this.showAlert(with: error.localizedDescription)
            }
            completion?()
        }
    }
    
    var sections: Int {
        return transactions.count
    }
    
    func getRowsCount(section: Int) -> Int {
        if (section > sections) { return 0}
        let account = transactions[section]
        return account.transactionInfo.count
    }
    
    func cellViewModel(indexPath: IndexPath) -> TransactionCellViewModel? {
        if (indexPath.section > transactions.count) { return nil}
        let transaction = transactions[indexPath.section]
        let transactionCellModel = TransactionCellViewModel.init(transaction: transaction.transactionInfo[indexPath.row])
        return transactionCellModel
    }
    
    func getSecionName(section: Int) -> String {
        if (section > transactions.count) { return ""}
        let transaction = transactions[section]
        return transaction.month
    }
    
    var totalAmount: String {
        "\(currentCurrency)\(totalAmountInAccounts)"
    }
    
    private func showAlert(with msg: String) {
        guard let top = UIApplication.getTopViewController() else { return }
        let alert = Alert.create(message: msg)
        DispatchQueue.main.async {
            top.present(alert, animated: true, completion: nil)
        }
    }
}
