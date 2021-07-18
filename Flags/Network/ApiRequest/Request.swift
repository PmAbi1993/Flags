//
//  Request.swift
//  ViewM
//
//  Created by admin on 13/05/21.
//

import Foundation

protocol ApiRequest: RequestBase, RequestHeaders, RequestBody, RequestEndpoint {}

extension ApiRequest {
    func createRequest(addedPath: String? = nil) -> URLRequest? {
        var urlComponents: URLComponents = URLComponents()
        urlComponents.scheme = scheme.rawValue
        urlComponents.port = port
        urlComponents.host = baseUri
        print(sanitisedEndpoint)
        if let addedPath = addedPath {
            urlComponents.path = addPathToRequest(addedPath)
        } else {
            urlComponents.path = sanitisedEndpoint
        }
        guard let url = urlComponents.url else {
            print("Url cannot be constructed here")
            return nil }
        var request: URLRequest = URLRequest(url: url)
        request.httpMethod = method.value
        // Add custom Headers and body data
        switch requestParameters {
        case .none:
            break
        case .data(data: let data):
            request.httpBody = data
        case .body(params: let params):
            guard let json = try? JSONSerialization.data(withJSONObject: params,
                                                        options: .fragmentsAllowed) else {
                print("Unable to convert the body parameters to json")
                return nil }
            request.httpBody = json
        case .url(params: let params):
            print(params)
            let queryItems = params.map({ URLQueryItem(name: $0.key,
                                                        value: $0.value as? String ?? "")})
            urlComponents.queryItems = queryItems
            request.url = urlComponents.url
        }
        print(request.url?.absoluteString ?? "")
        return request
    }
}
