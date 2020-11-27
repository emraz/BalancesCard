//
//  SummaryViewModel.swift
//  BalancesCard
//
//  Created by Mahmudul Hasan on 11/27/20.
//

import Foundation
import UIKit

class SummaryViewModel {
    //For dummy data from local json
    private let networking = NetworkingStab()
    
    //For real api calling
    //private let networking = Networking()
    
    private var accounts: [SectionedAccountModel] = []
    private var totalAmountInAccounts: Int = 0
    private var currentCurrency: String = ""
    
    func getAccounts(completion: (() -> Void)?) {
        networking.requestNetworkTask(endpoint: .accounts, type: AccountTopLevel.self) {[weak self] response in
            guard let this = self else { return}
            switch response {
            case.success(let accountTopLevel):
                guard let allAccounts = accountTopLevel.accounts else { return }
                var totalSum: Int = 0
                // MAP
                for account in allAccounts {
                    let name = account.name ?? ""
                    let balance = account.currentBalance
                    let amoundDesc = "\(account.currency ?? "")\(balance ?? 0)"
                    
                    this.currentCurrency = account.currency ?? ""
                    let accountInfo = AccountInfo(acountName: name, amountDescription: amoundDesc)
                    
                    if let index = this.accounts.firstIndex(where: { $0.institution == account.institution }) {
                        var account = this.accounts[index]
                        account.accountInfo.append(accountInfo)
                        this.accounts[index] = account
                    }else {
                        this.accounts.append(SectionedAccountModel(institution: account.institution ?? "",
                                                                   accountInfo: [accountInfo]))
                    }
                    totalSum += account.currentBalanceInBase ?? 0
                }
                this.totalAmountInAccounts = totalSum
                // SORT
                this.accounts = this.accounts.sorted { $0.institution < $1.institution }
            case .failure(let error):
                this.showAlert(with: error.localizedDescription)
            }
            completion?()
        }
    }
    
    var sections: Int {
        return accounts.count
    }
    
    func getRowsCount(section: Int) -> Int {
        if (section > sections) { return 0}
        let account = accounts[section]
        return account.accountInfo.count
    }
    
    func cellViewModel(indexPath: IndexPath) -> SummaryCellViewModel? {
        if (indexPath.section > accounts.count) { return nil}
        let account = accounts[indexPath.section]
        let summaryCellModel = SummaryCellViewModel(account: account.accountInfo[indexPath.row])
        return summaryCellModel
    }
    
    func getSecionName(section: Int) -> String {
        if (section > accounts.count) { return ""}
        let account = accounts[section]
        return account.institution
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
