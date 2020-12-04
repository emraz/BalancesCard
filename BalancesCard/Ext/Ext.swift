//
//  Ext.swift
//  BalancesCard
//
//  Created by Mahmudul Hasan on 11/27/20.
//

import UIKit
import Foundation

extension Bundle {
    
    //Just using for test purpose
    func jsonData(fileName: String) -> Data {
        if let path = Bundle.main.path(forResource: fileName, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                return data
            } catch (let error){
                print(error.localizedDescription)
                return Data()
            }
        }
        return Data()
    }
}

extension Bool {
    var intValue: Int {
        return self ? 1 : 0
    }
}

extension DateFormatter {

    static func with(format: String) -> DateFormatter {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = format
        return formatter
    }
    
    static var clock: DateFormatter {
        with(format: "HH:mm")
    }
}

extension Date {
    var ISOTime: Date? {
        DateFormatter.clock.string(from: self).clock
    }
    
    func toLocalTime() -> Date {
        let timezone = TimeZone.current
        let seconds = TimeInterval(timezone.secondsFromGMT(for: self))
        return Date(timeInterval: seconds, since: self)
    }

    static var dayBefore: Date {
        return Calendar.current.date(byAdding: .day, value: -1, to: Date())!
    }
    
    func toString(dateFormat format  : String) -> String {
        return DateFormatter.with(format: format).string(from: self)
    }
}

extension String {
    var clock: Date? {
        DateFormatter.clock.date(from: self)
    }
}

// MARK: UIApplication extensions
extension UIApplication {
    class func getTopViewController() -> UIViewController? {
        let keyWindow = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) ?? UIApplication.shared.windows.first
        let topController = keyWindow?.rootViewController
        return topController
    }
}

extension UIStackView {
    func removeAllViews() {
        for view in self.arrangedSubviews {
            view.removeFromSuperview()
        }
    }
}

extension UIView {
    class func fromNib<T: UIView>() -> T {
        Bundle.main.loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as? T ?? T()
    }
}
