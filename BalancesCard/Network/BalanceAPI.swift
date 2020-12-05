//
//  PetsAPI.swift
//  BalancesCard
//
//  Created by Mahmudul Hasan on 11/27/20.
//

import Foundation

enum BalanceAPI {
    case accounts
    case transaction_ID_1
    case transaction_ID_2
    case transaction_ID_3

}

extension BalanceAPI: EndPointType {
    var baseURL: URL {
        return URL(string: "")!
    }

    var path: String {
        switch self {
        case .accounts:
            return "accounts"
        case .transaction_ID_1:
            return "transactions_1"
        case .transaction_ID_2:
            return "transactions_2"
        case .transaction_ID_3:
            return "transactions_3"
        }
    }
}

