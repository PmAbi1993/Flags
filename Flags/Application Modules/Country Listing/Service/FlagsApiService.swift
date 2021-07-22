//
//  FlagsApiService.swift
//  Flags
//
//  Created by admin on 20/07/21.
//

import Foundation

enum FlagsApiServiceResponseStatus: Error {
    case applicationalInternalError
    case noDataFound
    case noNetwork
    case modelMappingFailed
}

class FlagsApiService {
    func fetchAllCountries(completion: @escaping (Result<[Country]?,
                                               FlagsApiServiceResponseStatus>) -> Void) {
        let flagRequestProvider: RequestProvider<FlagsApi> = .init(with: .all)
        flagRequestProvider.callApi(responseType: [Country].self) { (result) in
            switch result {
            case .success(let countries):
                completion(.success(countries))
            case .failure(let error):
                guard error.error != nil else {
                    completion(.failure(.applicationalInternalError))
                    return }
                completion(.failure(.applicationalInternalError))
            }
        }
    }
}
