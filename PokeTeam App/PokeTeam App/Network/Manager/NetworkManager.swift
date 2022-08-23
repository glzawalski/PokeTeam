//
//  NetworkManager.swift
//  PokeTeam App
//
//  Created by Gabriel Levis Zawalski on 21/05/22.
//

import Foundation

enum NetworkError: Error {
    case invalidUrl
}

protocol NetworkManagerInput {
    func fetch<Model>(_ model: Model.Type, url: String, completion: @escaping (Result<Model, Error>) -> Void) where Model: Decodable
    func fetch<Model>(_ model: Model.Type, url: String) async throws -> Model where Model: Decodable
}

final class NetworkManager: NetworkManagerInput {
    func fetch<Model>(_ model: Model.Type, url: String, completion: @escaping (Result<Model, Error>) -> Void) where Model : Decodable {
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

    func fetch<Model>(_ model: Model.Type, url: String) async throws -> Model where Model : Decodable {
        guard let url = URL(string: url) else { throw NetworkError.invalidUrl }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            return try JSONDecoder().decode(Model.self, from: data)
        } catch {
            throw error
        }
    }
}
