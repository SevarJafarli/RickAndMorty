//
//  RMAPICacheManager.swift
//  RickAndMorty
//
//  Created by Sevar Jafarli on 23.05.23.
//

import Foundation

/// manages in memory session scoped API caches
final class RMAPICacheManager {
    
    init() {
        setupCache()
    }
    
    private var cacheDictionary: [RMEndpoint: NSCache<NSString, NSData>] = [:]
    
    public func cachedResponse(for endpoint: RMEndpoint, url: URL?) -> Data? {
        guard let targetCache = cacheDictionary[endpoint], let url = url else { return nil }
        
        let key = url.absoluteString as NSString
        return targetCache.object(forKey: key) as? Data
    }
    
    public func setCache(for endpoint: RMEndpoint, url: URL?, data: Data) {
        guard let targetCache = cacheDictionary[endpoint], let url = url else { return }
        
        let key = url.absoluteString as NSString
        targetCache.setObject(data as NSData, forKey: key)
    }
    
    private func setupCache() {
        RMEndpoint.allCases.forEach { endpoint in
            cacheDictionary[endpoint] = NSCache<NSString, NSData>()
        }
    }
}
