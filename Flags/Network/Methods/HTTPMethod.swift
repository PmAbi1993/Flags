//
//  HTTPMethod.swift
//  ViewM
//
//  Created by admin on 13/05/21.
//

import Foundation

enum HTTPMethod: String {
    case get
    case post
    case put
    case delete
    var value: String {
        self.rawValue.uppercased()
    }
}
