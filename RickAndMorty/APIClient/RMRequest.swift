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
    
    convenience init?(url : URL) {
        let string = url.absoluteString
        
        if !string.contains(Constants.baseUrl) {
            return nil
        }
        let trimmed = string.replacingOccurrences(of: Constants.baseUrl + "/", with: "")
        if trimmed.contains("/") {
            let components = trimmed.components(separatedBy: "/")
            var pathComponents: [String] = []
            if !components.isEmpty {
                let endpointString = components[0]
                if components.count > 1 {
                    pathComponents = components
                    pathComponents.removeFirst()
                }
                if let rmEndpoint = RMEndpoint(rawValue: endpointString) {
                    self.init(endpoint: rmEndpoint, pathComponents: pathComponents)
                    return
                }
            }
        }
        else if trimmed.contains("?") {
            let components = trimmed.components(separatedBy: "?")
            if !components.isEmpty, components.count >= 2 {
                let endpointString = components[0]
                let queryItemsString = components[1]
                
                let queryItem: [URLQueryItem] = queryItemsString.components(separatedBy: "&").compactMap({
                    guard  $0.contains("=") else
                    {
                        return nil
                    }
                    
                    let parts = $0.components(separatedBy:"=")
                    return URLQueryItem(name: parts[0], value: parts[1])
                })
                if let rmEndpoint = RMEndpoint(rawValue: endpointString) {
                    self.init(endpoint: rmEndpoint, queryParams: queryItem)
                    return
                }
            }
        }
        
        return nil
    }
}


extension RMRequest {
    static let listCharactersRequest = RMRequest(endpoint: .character)
}
