//
//  NetworkErrors.swift
//  ViewM
//
//  Created by admin on 13/05/21.
//

import Foundation

struct ApiResponseError: Error {
    var data: Data?
    var error: NetworkLayerError?
}

enum NetworkLayerError {
    case invalidUrl
    case noDataPresent
    case modelMappingFailed
    case requestCannotBeCreated
    case custom(error: Error?)
}
