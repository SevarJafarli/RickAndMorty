//
//  RMService.swift
//  RickAndMorty
//
//  Created by Sevar Jafarli on 30.04.23.
//

import Foundation

/// Primary API Service object to get Rick and Morty data
final class RMService {
    /// Shared Singleton instance
    static let shared = RMService()
    
    /// Privatized Constructor
    private init() {}
    
    
    /// Send Rick and Morty API call
    /// - Parameters:
    ///   - request: Request instance
    ///   - completion: Callback with data or error
    public func execute(_ request: RMRequest, completion:  @escaping () -> Void) {
        
    }
}
