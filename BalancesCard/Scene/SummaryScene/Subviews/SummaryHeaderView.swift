//
//  SummaryHeaderView.swift
//  BalancesCard
//
//  Created by Mahmudul Hasan on 11/27/20.
//

import UIKit

class SummaryHeaderView: UIView {
    @IBOutlet private weak var nameLabel: UILabel!

    var name: String = "" {
        didSet {
            nameLabel.text = name
        }
    }
}
