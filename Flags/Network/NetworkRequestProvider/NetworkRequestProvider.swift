//
//  NetworkRequestProvider.swift
//  NetworkLayer
//
//  Created by admin on 13/05/21.
//

import Foundation

protocol NetworkRequestProvider: NetworkRequestProviderLogger {
    associatedtype Request: ApiRequest
    associatedtype DecodabaleObject: Codable
//    associatedtype ApiErrorConditions: Error
    typealias TargetApiResponse<DecodabaleObject> = (Result<DecodabaleObject?,
                                                            ApiResponseError>) -> Void
    typealias TargetStringResponse = (Result<String,
                                             ApiResponseError>) -> Void
    var api: Request? { get set }
    var request: URLRequest? { get set }
    var shouldLogRequest: Bool { get set }
    init(with api: Request)
    @discardableResult
    init<DecodabaleObject>(with api: ApiRequest,
                           responseType: DecodabaleObject.Type,
                           response: @escaping TargetApiResponse<DecodabaleObject>)
    func call<DecodabaleObject>(responseType: DecodabaleObject.Type,
                                completion: @escaping (Result<DecodabaleObject?, ApiResponseError>) -> Void)
}

extension NetworkRequestProvider {
    func stringRequest(completion: @escaping TargetStringResponse) {
        guard let request = self.request else {
            completion(.failure(handleError(data: nil,
                                            error: .requestCannotBeCreated)))
            return }
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                print(error.localizedDescription)
                completion(.failure(handleError(data: data,
                                                error: .custom(error: error))))
                return
            }
            guard let data = data else { return }
            guard let stringData = String(data: data, encoding: .utf8) else { return }
            completion(.success(stringData))
        }
    }
}

class NewRequestProvider<T: ApiRequest, U: Codable>: NetworkRequestProvider {
    var isLoggingEnabled: Bool = true
    typealias Request = T
    typealias DecodabaleObject = U
    typealias ApiErrorConditions = ApiResponseError
    var api: T?
    var request: URLRequest?
    var shouldLogRequest: Bool = false
    required init(with api: T) {
        self.api = api
        request = api.createRequest()
    }
    required init<DecodabaleObject>(with api: ApiRequest,
                                    responseType: DecodabaleObject.Type,
                                    response: @escaping TargetApiResponse<DecodabaleObject>) {
        self.api = api as? T
        request = api.createRequest()
    }
    func call<DecodabaleObject>(responseType: DecodabaleObject.Type,
                                completion: @escaping (Result<DecodabaleObject?, ApiResponseError>) -> Void) {
    }
}
