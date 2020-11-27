//
//  Alert.swift
//  BalancesCard
//
//  Created by Mahmudul Hasan on 11/27/20.
//

import UIKit

enum Alert {

    static func create(title: String? = nil, message: String,
                       okActionTitle: String = "OK",
                       okActionHandler: (() -> Void)? = nil) -> UIAlertController {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: okActionTitle, style: .default, handler: { _ in
            okActionHandler?()
        })
        alertController.addAction(okAction)
        return alertController
    }
}
