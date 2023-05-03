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
        guard let urlReqest = self.request(from: request) else {
            completion(.failure(RMServiceError.failedToCreateRequest))
            return }
        
        let task = URLSession.shared.dataTask(with: urlReqest) { data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(error ?? RMServiceError.failedToGetData))
                return
            }
            
            do {
                let result = try JSONDecoder().decode(type.self, from: data)
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
