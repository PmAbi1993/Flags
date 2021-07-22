//
//  FlagsApiService.swift
//  Flags
//
//  Created by admin on 20/07/21.
//

import Foundation

enum FlagsApi {
    case all
}

// https://restcountries.eu/rest/v2/all
extension FlagsApi: ApiRequest {
    var scheme: HTTPScheme {
        .https
    }
    var method: HTTPMethod {
        .get
    }
    var baseUri: String {
        "restcountries.eu"
    }
    var requestHeaders: HTTPHeader {
        .jsonContent
    }
    var requestParameters: HTTPRequestBody {
        .none
    }
    var endPoint: String {
        "rest/v2/all"
    }
}
