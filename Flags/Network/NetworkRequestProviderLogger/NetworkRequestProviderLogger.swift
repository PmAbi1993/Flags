//
//  NetworkRequestProvider.swift
//  NetworkLayer
//
//  Created by admin on 13/05/21.
//

import Foundation

protocol NetworkRequestProviderLogger {
    associatedtype ApiErrorConditions: Error
    var isLoggingEnabled: Bool { get set }
//    func handleError(data: Data?, error: ApiErrorConditions)
}

extension NetworkRequestProviderLogger {
    var isLoggingEnabled: Bool {
        return false
    }
    func handleError(data: Data?, error: NetworkLayerError) -> ApiResponseError {
        if let data = data,
           let stringData = String(data: data, encoding: .utf8), isLoggingEnabled {
            print("Response Data:- ", stringData)
        }
        return .init(data: data, error: error)
    }
}
