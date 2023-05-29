//
//  RMLocationViewViewModel.swift
//  RickAndMorty
//
//  Created by Sevar Jafarli on 29.05.23.
//

import Foundation

final class RMLocationViewViewModel {
    private var locations: [RMLocation] = []
    
    private var cellViewModels: [String] = []
    //MARK: - init
    init() {}
    
    private var apiInfo: RMGetAllLocationsResponse.Info? = nil
    
    
    public func fetchLocations() {
        RMService.shared.execute( .listLocationsRequest, expecting: RMGetAllLocationsResponse.self) { [weak self] result in
            switch result {
            case .success(let responseModel):
                let info = responseModel.info
                let results = responseModel.results
                self?.locations = results
                self?.apiInfo = info
                DispatchQueue.main.async {
//                    self?.delegate?.didLoadInitialLocations()
                }
                
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private var hasMoreResults: Bool {
        return false
    }
}
