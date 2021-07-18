//
//  RequestBody.swift
//  ViewM
//
//  Created by admin on 13/05/21.
//

import Foundation

typealias RequestBodyParams = [String: Any]

enum HTTPRequestBody {
    case none
    case data(data: Data)
    case body(params: RequestBodyParams)
    case url(params: RequestBodyParams)
}

protocol RequestBody {
    var requestParameters: HTTPRequestBody { get }
}
