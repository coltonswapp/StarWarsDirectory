//
//  NetworkManager.swift
//  DirectoryCoreData
//
//  Created by Colton Swapp on 8/21/22.
//

import Foundation

import SwiftUI
import CoreData

final class NetworkService {
    
    static let shared = NetworkService()
    
    private let cache = NSCache<NSString, UIImage>()
    
    let url = "https://edge.ldscdn.org/mobile/interview/directory"
    
    func fetch(completion: @escaping ( Result<Directory, CSError>) -> Void)  {
        guard let url = URL(string: url) else { return completion(.failure(.invalidURL)) }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            if let _ = error {
                completion(.failure(.invalidURL))
            }
            
            guard let data = data else { return completion(.failure(.noData)) }
            
            do {
                let decoder = JSONDecoder()
                let directory = try decoder.decode(Directory.self, from: data)
                completion(.success(directory))
                return
            } catch {
                completion(.failure(.thrownError(error)))
                return
            }
        }
        task.resume()
        
    }
    
    func downloadImage(from urlString: String, completion: @escaping (UIImage?) -> Void) {
        let cacheKey = NSString(string: urlString)
        if let image = cache.object(forKey: cacheKey) {
            completion(image)
            return
        }
        
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, _ in
         
            guard let data = data, let image = UIImage(data: data) else {
                completion(nil)
                return
            }
            
            self.cache.setObject(image, forKey: cacheKey)
            completion(image)
            return
        }
        task.resume()
    }
}

enum CSError: LocalizedError {
    case invalidURL
    case thrownError(Error)
    case noData
    case unableToDecode
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "The url requested was invalid!"
        case .thrownError(let error):
            return "There was an error: \(error.localizedDescription)"
        case .noData:
            return "Data retreival failed."
        case .unableToDecode:
            return "The data was unable to be decoded."
        }
    }
}
