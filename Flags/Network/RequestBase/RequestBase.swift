//
//  RequestBase.swift
//  ViewM
//
//  Created by admin on 13/05/21.
//

import Foundation

protocol RequestBase {
    var scheme: HTTPScheme { get }
    var method: HTTPMethod { get }
    var baseUri: String { get }
    var port: Int? { get }
}

extension RequestBase {
    var port: Int? {
        return nil
    }
}
