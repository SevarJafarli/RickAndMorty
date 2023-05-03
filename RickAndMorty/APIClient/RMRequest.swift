//
//  RMRequest.swift
//  RickAndMorty
//
//  Created by Sevar Jafarli on 30.04.23.
//

import Foundation

/// Object that represents a single API Call
final class RMRequest {
    /// API Constants
    private struct Constants {
        static let baseUrl = "https://rickandmortyapi.com/api"
    }
    
    /// construstec url for api request in string format
    private var urlString: String {
        var string = Constants.baseUrl
        string += "/"
        string += endpoint.rawValue
        
        if !pathComponents.isEmpty {
            pathComponents.forEach({
                string += "/\($0)"
            })
        }
        
        if !queryParams.isEmpty {
            string += "?"
            let argString = queryParams.compactMap({
                guard let value = $0.value else { return nil }
                return "\($0.name)=\(value)"
                
            }).joined(separator: "&")
            
            string += argString
        }
        
        return string
    }
    
    
    public var url: URL? {
        return URL(string: urlString)
        
    }
    public let httpMethod = "GET"
    
    private let endpoint: RMEndpoint
    private let pathComponents: [String]
    private let queryParams: [URLQueryItem]
    
    public init(endpoint: RMEndpoint,pathComponents: [String] = [], queryParams: [URLQueryItem] = []) {
        self.endpoint = endpoint
        self.pathComponents = pathComponents
        self.queryParams = queryParams
    }
}


extension RMRequest {
    static let listCharactersRequest = RMRequest(endpoint: .character)
}
