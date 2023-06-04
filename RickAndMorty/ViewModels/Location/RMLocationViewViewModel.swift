//
//  RMLocationViewViewModel.swift
//  RickAndMorty
//
//  Created by Sevar Jafarli on 29.05.23.
//

import Foundation

protocol RMLocationViewViewModelDelegate: AnyObject {
    func didFetchInitialLocations()
}
final class RMLocationViewViewModel {
    weak var delegate: RMLocationViewViewModelDelegate?
    
    private var locations: [RMLocation] = [] {
        didSet {
            for location in locations {
                let cellViewModel = RMLocationTableViewCellViewModel(location: location)
                if !cellViewModels.contains(cellViewModel) {
                    cellViewModels.append(cellViewModel)
                }
            }
        }
    }
    
    public private(set) var cellViewModels: [RMLocationTableViewCellViewModel] = []
    //MARK: - Init
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
                    self?.delegate?.didFetchInitialLocations()
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
