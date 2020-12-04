//
//  Account.swift
//  BalancesCard
//
//  Created by Mahmudul Hasan on 11/27/20.
//

import Foundation

// MARK: - TopLevel
struct AccountTopLevel: Codable {
    var accounts: [Account]?
}

// MARK: - Account
struct Account: Codable {
    var id: Int
    var name: String?
    var institution: String?
    var currency: String?
    var currentBalance: Double?
    var currentBalanceInBase: Int?

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case institution
        case currency
        case currentBalance = "current_balance"
        case currentBalanceInBase = "current_balance_in_base"
    }
}

struct AccountInfo {
    let acountName: String
    let amountDescription: String
}

struct SectionedAccountModel {
    var institution: String
    var accountInfo: [AccountInfo]
}
