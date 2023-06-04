//
//  RMLocationDetailViewViewModel.swift
//  RickAndMorty
//
//  Created by Sevar Jafarli on 04.06.23.
//
import Foundation

protocol RMLocationDetailViewViewModelDelegate: AnyObject {
    func didFetchLocationDetails()
}

final class RMLocationDetailViewViewModel {
    public weak var delegate: RMLocationDetailViewViewModelDelegate?
    
    private let endpointUrl: URL?
    private var dataTuple: (location: RMLocation, characters: [RMCharacter])? {
        didSet {
            createCellViewModels()
            delegate?.didFetchLocationDetails()
        }
    }
    enum SectionType {
        case information(viewModels: [RMEpisodeInfoCollectionViewCellViewModel])
        case characters(viewModels: [RMCharacterListViewCellViewModel])
    }
    
    public private(set) var cellViewModels: [SectionType] = []
    
    private func createCellViewModels() {
        guard let dataTuple = dataTuple else {
            return
        }
        
        let location = dataTuple.location
        let characters = dataTuple.characters
        
        var createdString = ""
        if let createdDate = RMCharacterInfoCollectionViewCellViewModel.dateFormatter.date(from: location.created) {
            createdString = RMCharacterInfoCollectionViewCellViewModel.shortDateFormatter.string(from: createdDate)
        }
        cellViewModels = [
            .information(viewModels: [
                .init(title: "Location Name", value: location.name),
                .init(title: "Type", value: location.type),
                .init(title: "Dimension", value: location.dimension),
                .init(title: "Created", value: createdString),
            ]),
            .characters(viewModels: characters.compactMap({ character in
                return .init(characterName: character.name,
                             characterStatus: character.status,
                             characterImageUrl:URL(string: character.image)
                )
            }))
        ]
    }
    public func character(at index: Int) -> RMCharacter? {
        guard let dataTuple = dataTuple else {
            return nil
        }
        return dataTuple.characters[index]
    }
    
    //MARK: - Init
    init(endpointUrl: URL?) {
        self.endpointUrl = endpointUrl
        
    }
    
    ///fetch backing location model
    public func fetchLocationData() {
        guard let url = endpointUrl, let request = RMRequest(url: url) else { return }
        
        RMService.shared.execute(request, expecting: RMLocation.self) { [weak self] result in
            switch result {
            case .success(let model):
                self?.fetchRelatedCharacters(location:model)
            case .failure(let failure):
                print(failure)
                break
            }
        }
    }
    private func fetchRelatedCharacters(location: RMLocation) {
        let requests : [RMRequest] = location.residents.compactMap({
            return URL(string: $0)
        })
            .compactMap({
                return RMRequest(url: $0)
            })
        
        let group = DispatchGroup()
        var characters: [RMCharacter] = []
        for request in requests {
            group.enter()
            RMService.shared.execute(request, expecting: RMCharacter.self) { result in
                defer {
                    group.leave()
                }
                switch result {
                case .success(let character):
                    characters.append(character)
                case .failure:
                    break
                }
            }
        }
        group.notify(queue: .main) {
            self.dataTuple = (location: location, characters: characters)
        }
    }
}
