//
//  UI+Extension.swift
//  BalancesCard
//
//  Created by Mahmudul Hasan on 11/27/20.
//

import UIKit

extension UIStoryboard {
    class func stwithName(name: String) -> UIStoryboard {
        return UIStoryboard(name: name, bundle: nil)
    }
}

extension UIView {
    func setBorder(with color: UIColor = .clear, borderWidth: CGFloat = 0) {
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = borderWidth
    }
}

extension UIColor {
    static let petGreen = UIColor(red: 63/255, green: 210/255, blue: 95/255, alpha: 1)
    static let petBlue = UIColor(red: 18/255, green: 127/255, blue: 251/255, alpha: 1)
}

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
