//
//  HTTPParameters.swift
//  ViewM
//
//  Created by admin on 13/05/21.
//

import UIKit

typealias HTTPHeader = [String: String]
protocol RequestHeaders {
    var requestHeaders: HTTPHeader { get }
}
extension HTTPHeader where Key == String, Value == String {
    static var none: HTTPHeader { return [:]}
    static var jsonContent: HTTPHeader {
        return ["Content-Type": "application/json; charset=utf-8"]
    }
}
