//
//  PetsAPI.swift
//  BalancesCard
//
//  Created by Mahmudul Hasan on 11/27/20.
//

import Foundation

enum BalanceAPI {
    case accounts
    case transaction
}

extension BalanceAPI: EndPointType {
    var baseURL: URL {
        return URL(string: "https://i-savvy.com/pets")!
    }

    var path: String {
        switch self {
        case .accounts:
            return "/accounts.json"
        case .transaction:
            return "/transactions_2.json"
        }
    }
}

