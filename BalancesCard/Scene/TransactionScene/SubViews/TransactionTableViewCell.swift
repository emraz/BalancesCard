//
//  SummaryTableViewCell.swift
//  BalancesCard
//
//  Created by Mahmudul Hasan on 11/27/20.
//

import UIKit

class TransactionTableViewCell: UITableViewCell {

    public static let reuseIdentifier = "TransactionCellID"
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    
    var viewModel: TransactionCellViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            dateLabel.text = viewModel.date
            descriptionLabel.text = viewModel.description
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

class TransactionCellViewModel {
    private let transaction: TransactionInfo

    init(transaction: TransactionInfo) {
        self.transaction = transaction
    }

    var date: String {
        let dateValue = transaction.transactionDate.toDate
        let day = dateValue.get(.day)
        return String(describing: day)
    }
    
    var description: String {
        return transaction.transactionDescription
    }

    var amount: String {
        return transaction.amountDescription
    }
}
