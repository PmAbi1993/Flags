//
//  RequestProvider.swift
//  ViewM
//
//  Created by admin on 13/05/21.
//

import Foundation

class RequestProvider<T: ApiRequest> {
    private var api: T?
    private var request: URLRequest?
    typealias ApiResponse<U: Codable> = (Result<U?, ApiResponseError>) -> Void
    // MARK: Initializers
    init(with api: T,
         addedPath: String? = nil) {
        self.api = api
        self.request = api.createRequest(addedPath: addedPath)
    }
    @discardableResult
    init<U>(with api: T,
            responseType: U.Type,
            response: @escaping ApiResponse<U>) where U: Codable {
        self.api = api
        self.request = api.createRequest()
        callApi(responseType: responseType, completion: response)
    }
}
// MARK: Basic Request Builder
extension RequestProvider {
    // MARK: Basic request Maker
    func callApi<U: Codable>(responseType: U.Type,
                             completion: @escaping (Result<U?, ApiResponseError>) -> Void) {
        guard let request = self.request else {
            let result: Result<U?, ApiResponseError> = .failure(ApiResponseError(data: nil,
                                                                                 error: .invalidUrl))
            completion(result)
            return }
        let session: URLSession = URLSession.shared
        session.dataTask(with: request) { (data, _, error) in
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(.init(data: data,
                                              error: .custom(error: error))))
                }
            }
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(.failure(.init(data: nil,
                                              error: .noDataPresent)))
                }
                return }
            let stringData = String(data: data, encoding: .utf8)
            print(stringData ?? "")
            guard let convertedData = try? JSONDecoder().decode(responseType, from: data) else {
                DispatchQueue.main.async {
                    completion(.failure(.init(data: data,
                                              error: .modelMappingFailed)))
                }
                return }
            DispatchQueue.main.async {
                completion(.success(convertedData))
            }
        }.resume()
    }
    func callApi<U: Codable>(responseType: [U].Type,
                             completion: @escaping (Result<[U]?, ApiResponseError>) -> Void) {
        guard let request = self.request else {
            let result: Result<[U]?, ApiResponseError> = .failure(ApiResponseError(data: nil,
                                                                                   error: .invalidUrl))
            completion(result)
            return }
        let session: URLSession = URLSession.shared
        session.dataTask(with: request) { (data, _, error) in
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(.init(data: data,
                                              error: .custom(error: error))))
                }
            }
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(.failure(.init(data: nil,
                                              error: .noDataPresent)))
                }
                return }
            let stringData = String(data: data, encoding: .utf8)
            print(stringData ?? "")
            guard let convertedData = try? JSONDecoder().decode(responseType, from: data) else {
                DispatchQueue.main.async {
                    completion(.failure(.init(data: data,
                                              error: .modelMappingFailed)))
                }
                return }
            DispatchQueue.main.async {
                completion(.success(convertedData))
            }
        }.resume()
    }
}
extension RequestProvider: RequestProviderConfigurations {}
