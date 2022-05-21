//
//  NetworkManager.swift
//  PokeTeam App
//
//  Created by Gabriel Levis Zawalski on 21/05/22.
//

import Foundation

protocol NetworkManagerInput {
    func fetch<Model>(_ model: Model.Type,
                      url: String,
                      completion: @escaping (Result<Model, Error>) -> Void) where Model: Decodable
}

final class NetworkManager: NetworkManagerInput {
    
    func fetch<Model>(_ model: Model.Type,
                      url: String,
                      completion: @escaping (Result<Model, Error>) -> Void) where Model : Decodable {
        guard let url = URL(string: url) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { (data, _, error) in
            do {
                if let data = data {
                    let decoder = JSONDecoder()
                    
                    let result = try decoder.decode(Model.self, from: data)
                    completion(.success(result))
                }
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
}
