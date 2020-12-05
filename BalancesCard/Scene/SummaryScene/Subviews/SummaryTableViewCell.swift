//
//  SummaryTableViewCell.swift
//  BalancesCard
//
//  Created by Mahmudul Hasan on 11/27/20.
//

import UIKit

class SummaryTableViewCell: UITableViewCell {

    public static let reuseIdentifier = "SummaryCellID"
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var amountLabel: UILabel!

    var viewModel: SummaryCellViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            nameLabel.text = viewModel.name
            amountLabel.text = viewModel.amount
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

class SummaryCellViewModel {
    private let account: AccountInfo

    init(account: AccountInfo) {
        self.account = account
    }

    var name: String {
        return account.acountName
    }

    var amount: String {
        return account.amountDescription
    }
    
    var amountInLocalCurrency: String {
        return "JPY \(account.currentBalanceInLocal)"
    }
    
    var currency: String {
        return account.currency
    }
    
    var id: Int {
        return account.id
    }
}
