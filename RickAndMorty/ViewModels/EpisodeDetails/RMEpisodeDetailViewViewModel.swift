//
//  RMEpisodeDetailViewViewModel.swift
//  RickAndMorty
//
//  Created by Sevar Jafarli on 23.05.23.
//

protocol RMEpisodeDetailViewViewModelDelegate: AnyObject {
    func didFetchEpisodeDetails()
}
import Foundation
final class RMEpisodeDetailViewViewModel {
    public weak var delegate: RMEpisodeDetailViewViewModelDelegate?
    
    private let endpointUrl: URL?
    private var dataTuple: (episode: RMEpisode, characters: [RMCharacter])? {
        didSet {
            createCellViewModels()
            delegate?.didFetchEpisodeDetails()
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
      
        let episode = dataTuple.episode
        let characters = dataTuple.characters
        
        var createdString = ""
        if let createdDate = RMCharacterInfoCollectionViewCellViewModel.dateFormatter.date(from: episode.created) {
            createdString = RMCharacterInfoCollectionViewCellViewModel.shortDateFormatter.string(from: createdDate)
        }
        cellViewModels = [
            .information(viewModels: [
                .init(title: "Episode Name", value: episode.name),
                .init(title: "Air date", value: episode.air_date),
                .init(title: "Episode", value: episode.episode),
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
    
    ///fetch backing episode model
    public func fetchEpisodeData() {
        guard let url = endpointUrl, let request = RMRequest(url: url) else { return }
        
        RMService.shared.execute(request, expecting: RMEpisode.self) { [weak self] result in
            switch result {
            case .success(let model):
                self?.fetchRelatedCharacters(episode: model)
            case .failure(let failure):
                print(failure)
                break
            }
        }
    }
    private func fetchRelatedCharacters(episode: RMEpisode) {
        let requests : [RMRequest] = episode.characters.compactMap({
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
            self.dataTuple = (episode: episode, characters: characters)
        }
    }
}
