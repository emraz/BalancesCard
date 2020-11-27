//
//  Response.swift
//  BalancesCard
//
//  Created by Mahmudul Hasan on 11/27/20.
//

import Foundation
import UIKit

struct Response {
    fileprivate var data: Data
    init(data: Data) {
        self.data = data
    }
}

extension Response {
    public func decode<T: Codable>(_ type: T.Type) -> T? {
        let jsonDecoder = JSONDecoder()
        do {
            let response = try jsonDecoder.decode(T.self, from: data)
            return response
        } catch let error {
            DispatchQueue.main.async {
                let alert = Alert.create(message: error.localizedDescription)
                UIApplication.getTopViewController()?.present(alert, animated: true, completion: nil)
            }
            return nil
        }
    }
}
