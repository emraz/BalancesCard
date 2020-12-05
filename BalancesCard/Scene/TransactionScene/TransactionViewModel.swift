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
    private var totalInAmountCurrentMonth: Int = 0
    private var totalOutAmountCurrentMonth: Int = 0

    private var currentCurrency: String = ""
    
    
    func getTransactions(transactionID: Int, completion: (() -> Void)?) {
        var end: BalanceAPI?
        switch transactionID {
        case 1:
            end = .transaction_ID_1
            
        case 2:
            end = .transaction_ID_2
            
        case 3:
            end = .transaction_ID_3

        default: break

        }
        networking.requestNetworkTask(endpoint: end!, type: TransactionTopLevel.self) {[weak self] response in
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
                    let date = transaction.date
                    let trnscnDesc = transaction.transactionDescription ?? ""
                    
                    let transactionInfo = TransactionInfo(transactionDate: date, transactionDescription: trnscnDesc, amount: amnt)
                    
                    
                    let dateValue = transaction.date.toDate
                    
                    let monthInt = Calendar.current.component(.month, from: dateValue)
                    let monthStr = Calendar.current.monthSymbols[monthInt-1]
                    
                    if let index = this.transactions.firstIndex(where: { $0.month == monthStr }) {
                        var transcn = this.transactions[index]
                        transcn.transactionInfo.append(transactionInfo)
                        this.transactions[index] = transcn
                    } else {
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
                this.totalInAmountCurrentMonth = totalIn
                this.totalOutAmountCurrentMonth = totalOut
                
                // SORT
                this.transactions = this.transactions.sorted { $0.month > $1.month }
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
    
    func setCurrency(crncy: String) {
        currentCurrency = crncy
    }
    
    func getSecionName(section: Int) -> String {
        if (section > transactions.count) { return ""}
        let transaction = transactions[section]
        return transaction.month
    }
    
    func getInAmout(section: Int) -> String {
        if (section > transactions.count) { return ""}
        let transaction = transactions[section]
        let infoArray = transaction.transactionInfo
        var amount = 0
        for info in infoArray {
            let amnt = info.amount
            
            if amnt > 0 {
                amount += amnt
            }
        }
        
        return "\(amount)"
    }
    
    func getOutAmout(section: Int) -> String {
        if (section > transactions.count) { return ""}
        let transaction = transactions[section]
        let infoArray = transaction.transactionInfo
        var amount = 0
        for info in infoArray {
            let amnt = info.amount
            
            if amnt < 0 {
                amount += amnt
            }
        }
        
        return "\(amount)"
    }
    
    var totalAmount: String {
        "\(currentCurrency)\(totalAmountInAccounts)"
    }
    
    var totalInAmount: String {
        "\(currentCurrency)\(totalInAmountCurrentMonth)"
    }
    
    var totalOutAmount: String {
        "\(currentCurrency)\(totalOutAmountCurrentMonth)"
    }
    
    private func showAlert(with msg: String) {
        guard let top = UIApplication.getTopViewController() else { return }
        let alert = Alert.create(message: msg)
        DispatchQueue.main.async {
            top.present(alert, animated: true, completion: nil)
        }
    }
}
