//
//  Subclasses.swift
//  BalancesCard
//
//  Created by Mahmudul Hasan on 11/27/20.
//

import UIKit

class Button: UIButton {
    enum Styles {
        case call
        case chat
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    public init(style: Styles, text: String, corner: CGFloat = 0, tag: Int = 0) {
        super.init(frame: CGRect.zero)
        self.layer.cornerRadius = corner
        self.clipsToBounds = true
        switch style {
        case .call:
            self.backgroundColor = .petGreen
            self.tag = 100
        case .chat:
            self.backgroundColor = .petBlue

        }
        self.tag = tag

        let attributedTitle = NSAttributedString.init(string: text, attributes: [
            .font: UIFont.systemFont(ofSize: 28, weight: .regular),
            .foregroundColor: UIColor.white
        ])
        self.setAttributedTitle(attributedTitle, for: .normal)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
