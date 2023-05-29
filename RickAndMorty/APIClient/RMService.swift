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
    
    private let cacheManager = RMAPICacheManager()
    
    /// Privatized Constructor
    private init() {}
    enum RMServiceError: Error {
        case failedToCreateRequest
        case failedToGetData
    }
    
    /// Send Rick and Morty API call
    /// - Parameters:
    ///   - request: Request instance
    ///   - completion: Callback with data or error
    public func execute<T: Codable>(_ request: RMRequest,
                                    expecting type: T.Type, completion:  @escaping (Result<T, Error>) -> Void) {
        
        if let cachedData = cacheManager.cachedResponse(for: request.endpoint, url: request.url) {
            do {
                let result = try JSONDecoder().decode(type.self, from: cachedData)
                print("Using cached API Response")
                completion(.success(result))
                
            }
            catch {
                completion(.failure(error))
            }
            return
        }
        
        
        guard let urlReqest = self.request(from: request) else {
            completion(.failure(RMServiceError.failedToCreateRequest))
            return }
        
        let task = URLSession.shared.dataTask(with: urlReqest) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(error ?? RMServiceError.failedToGetData))
                return
            }
            
            do {
                let result = try JSONDecoder().decode(type.self, from: data)
                self?.cacheManager.setCache(for: request.endpoint, url: request.url, data: data)
                completion(.success(result))
                
            }
            catch {
                completion(.failure(error))
            }
           
        }
        task.resume()
}
    
    
    //MARK: - Private
    private func request(from request: RMRequest) -> URLRequest? {
        guard let url = request.url else {return nil }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.httpMethod
        return urlRequest
    }
}
