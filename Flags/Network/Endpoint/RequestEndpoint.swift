//
//  Endpoint.swift
//  ViewM
//
//  Created by admin on 13/05/21.
//

import Foundation

protocol RequestEndpoint {
    var endPoint: String { get }
}

extension RequestEndpoint {
    var sanitisedEndpoint: String {
        var sanitisedEndpoint: String = endPoint
        if !sanitisedEndpoint.starts(with: "/") {
            sanitisedEndpoint.insert("/", at: sanitisedEndpoint.startIndex)
        }
        return sanitisedEndpoint
    }
    func addPathToRequest(_ path: String) -> String {
        let oldPath: String = sanitisedEndpoint + "/"
        return oldPath.appending(path)
    }
}
