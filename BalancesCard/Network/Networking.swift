//
//  Networking.swift
//  BalancesCard
//
//  Created by Mahmudul Hasan on 11/27/20.
//

import Foundation


typealias ResultHandler<T, E> = (Swift.Result<T, Error>) -> Void

/// protocol
protocol NetworkingProtocol {

    func requestNetworkTask<T: Codable>(endpoint: BalanceAPI,
                                        type: T.Type,
                                        completion: @escaping ResultHandler<T, Error>)

}

struct Networking: NetworkingProtocol {

    func requestNetworkTask<T: Codable>(endpoint: BalanceAPI,
                                        type: T.Type,
                                        completion:  @escaping ResultHandler<T, Error>) {
        let urlString = endpoint.baseURL.appendingPathComponent(endpoint.path).absoluteString.removingPercentEncoding
        guard let urlRequest = URL(string: urlString ?? "") else { return }

        let urlSession = URLSession.shared.dataTask(with: urlRequest) { (data, urlResponse, error) in
            if let serverError = error {
                completion(Swift.Result.failure(serverError))
            }
            guard let data = data else {
                return
            }
            let response = Response(data: data)
            guard let decoded = response.decode(type) else {
                return
            }
            completion(Swift.Result.success(decoded))
        }
        urlSession.resume()
    }

    // Added this to use at some point to map the error
    private func errorWithResponse(_ response: URLResponse?) -> ErrorCode? {
        guard let httpResponse = response as? HTTPURLResponse else { return nil}
        switch httpResponse.statusCode {
        case 500...599:
            return .serverError
        default:
            break
        }
        return .unknown
    }

}


internal struct NetworkingStab: NetworkingProtocol {
    func requestNetworkTask<T: Codable>(endpoint: BalanceAPI, type: T.Type,
                               completion:  @escaping ResultHandler<T, Error>) {
        var jsonData = Data()
        if T.self == AccountTopLevel.self {
            jsonData = Bundle.main.jsonData(fileName: "accounts")
        }else {
            jsonData = Bundle.main.jsonData(fileName: endpoint.path)
        }
        let response = Response(data: jsonData)
        guard let decoded = response.decode(type) else {
            return
        }
        completion(Swift.Result.success(decoded))
    }
}

