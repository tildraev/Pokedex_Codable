//
//  NetworkingController.swift
//  Pokedex_Codable
//
//  Created by Karl Pfister on 2/7/22.
//

import Foundation
import UIKit.UIImage

class NetworkingController {
    
    private static let baseURLString = "https://pokeapi.co"
    
    static func fetchPokedex(pokedexURLString: String, completion: @escaping (Result<Pokedex, ResultError>) -> Void) {
        
        guard let baseURL = URL(string: pokedexURLString) else {return}
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        urlComponents?.path = "/api/v2/pokemon/"

        guard let finalURL = urlComponents?.url else {
            completion(.failure(.invalidURL("\(urlComponents?.url)")))
            return
        }
        
        URLSession.shared.dataTask(with: finalURL) { dTaskData, _, error in
            if let error = error {
                print("Encountered error: \(error.localizedDescription)")
                completion(.failure(.thrownError(error)))
            }
            
            guard let pokemonData = dTaskData else {
                completion(.failure(.noData))
                return
            }
            
            do {
                let pokedex = try JSONDecoder().decode(Pokedex.self, from: pokemonData)
                completion(.success(pokedex))
            } catch {
                completion(.failure((.thrownError(error))))
            }
        }.resume()
    }
    
    static func fetchPokemon(with urlString: String, completion: @escaping (Result<Pokemon, ResultError>) -> Void) {
        guard let pokemonURL = URL(string: urlString) else {
            completion(.failure(.invalidURL(urlString)))
            return
        }
        
        URLSession.shared.dataTask(with: pokemonURL) { data, _, error in
            if let error = error {
                completion(.failure(.thrownError(error)))
                return
            }
            
            guard let data = data else {
                completion(.failure(.unableToDecode))
                return
            }
            
            do {
                let decodedPokemon = try JSONDecoder().decode(Pokemon.self, from: data)
                completion(.success(decodedPokemon))
            } catch {
                completion(.failure(.thrownError(error)))
            }
        }.resume()
    }
    
    static func fetchPokemonImage(with urlString: String, completion: @escaping (Result<UIImage, ResultError>) -> Void) {
        
        guard let pokemonImageURL  = URL(string: urlString) else {
            completion(.failure(.invalidURL(urlString)))
            return
        }
        
        URLSession.shared.dataTask(with: pokemonImageURL) { data, _, error in
            if let error = error {
                completion(.failure(.thrownError(error)))
                return
            }
            
            guard let pokemonImageData = data else {
                completion(.failure(.noData))
                return
            }
            
            if let decodedImage = UIImage(data: pokemonImageData)  {
                completion(.success(decodedImage))
            }            
        }.resume()
        
    }
}
//    static func fetchImage(for pokemon: Pokemon, completetion: @escaping (UIImage?) -> Void) {
//        guard let imageURL = URL(string: pokemon.spritePath) else {return}
//        
//        URLSession.shared.dataTask(with: imageURL) { data, _, error in
//            if let error = error {
//                print("There was an error", error.localizedDescription)
//                completetion(nil)
//            }
//            guard let data = data else {
//                return
//            }
//            let pokemonImage = UIImage(data: data)
//            completetion(pokemonImage)
//        }.resume()
//    }
//}// end
