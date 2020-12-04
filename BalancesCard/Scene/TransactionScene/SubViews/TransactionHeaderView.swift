//
//  SummaryHeaderView.swift
//  BalancesCard
//
//  Created by Mahmudul Hasan on 11/27/20.
//

import UIKit

class TransactionHeaderView: UIView {
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var inAmountLabel: UILabel!
    @IBOutlet private weak var outAmountLabel: UILabel!

    var name: String = "" {
        didSet {
            nameLabel.text = name
        }
    }
    
    var inAmnt: String = "" {
        didSet {
            inAmountLabel.text = inAmnt
        }
    }

    var outAmnt: String = "" {
        didSet {
            outAmountLabel.text = outAmnt
        }
    }
}
