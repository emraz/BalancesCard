//
//  TransactionModel.swift
//  BalancesCard
//
//  Created by Mahmudul Hasan on 11/27/20.
//

import Foundation

// MARK: - TopLevel
struct TransactionTopLevel: Codable {
    var transactions: [Transaction]?
}

// MARK: - Transaction
struct Transaction: Codable {
    var accountID: Int
    var amount: Int
    var categoryID: Int?
    var date: String
    var transactionDescription: String?
    var id: Int?

    enum CodingKeys: String, CodingKey {
        case accountID = "account_id"
        case amount
        case categoryID = "category_id"
        case date
        case transactionDescription = "description"
        case id
    }
}

struct TransactionInfo {
    let transactionDate: String
    let transactionDescription: String
    let amount: Int
}

struct SectionedTransactionModel {
    var month: String
    var transactionInfo: [TransactionInfo]
}
