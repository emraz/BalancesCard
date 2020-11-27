//
//  Error.swift
//  BalancesCard
//
//  Created by Mahmudul Hasan on 11/27/20.
//

import Foundation

internal enum ErrorCode: Error {
    case connectionDisconnected
    case connectionTimedOut
    case connectionCanceled
    case badServerResponse
    case emptyData
    case emptyResponse
    case serverError
    case systemError(code: SystemErrorCode)
    case unknown
    
    var localizedDescription:(title: String, message: String) {
        switch self {
        case .connectionDisconnected:
            return ("", "Connection disconnected!")
        case .connectionTimedOut:
            return ("", "Connection Timedout!")
        case .connectionCanceled:
            return ("", "Connection Cancelled!")
        case .unknown:
            return ("", "Unknowned Error")
        case .systemError(code: let code):
            return ("", code.localizedDescription)
        case .badServerResponse:
            return ("", "bad server response")
        case .emptyData:
            return ("", "Empty data from server")
        case .emptyResponse:
            return ("", "Empty response from server")
        case .serverError:
            return ("", "Server error!")
        }
    }
    
    static func errorWithSystemError(_ error: ErrorCode) -> Result<Data, ErrorCode>? {
        switch error {
        case .systemError(let code):
            switch code {
            default:
                return .failure(.unknown)
            }
        default:
            return .failure(error)
        }
    }
}

internal enum SystemErrorCode: Int {
    case unknown

    init(_ code: Int) {
        self = SystemErrorCode(rawValue: code) ?? .unknown
    }

    var localizedDescription: String {
        switch self {
        case .unknown:
            return "Unknown System error!"
        }
    }
}

