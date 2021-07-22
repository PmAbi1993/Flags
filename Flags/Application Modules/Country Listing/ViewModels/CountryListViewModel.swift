//
//  CountryListViewModel.swift
//  Flags
//
//  Created by admin on 18/07/21.
//

import Foundation

enum CountryListViewModelError: Error {
    case noDataFound
}

class CountryListViewModel {
    let apiService: FlagsApiService = .init()
    func getCounryData(completion: @escaping (Result<[Country]?,
                                                     CountryListViewModelError>) -> Void) {
        apiService.fetchAllCountries { (result) in
            switch result {
            case .success(let countries):
                completion(.success(countries))
            case .failure:
                completion(.failure(.noDataFound))
            }
        }
    }
}
