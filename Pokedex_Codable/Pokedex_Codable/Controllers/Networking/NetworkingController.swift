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
    
    static func fetchPokemon(with searchTerm: String, completion: @escaping (Pokemon?) -> Void) {
        
        guard let baseURL = URL(string: baseURLString) else {return}
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        urlComponents?.path = "/api/v2/pokemon/\(searchTerm.lowercased())"

        guard let finalURL = urlComponents?.url else {return}
        print(finalURL)
        
        URLSession.shared.dataTask(with: finalURL) { dTaskData, _, error in
            if let error = error {
                print("Encountered error: \(error.localizedDescription)")
                completion(nil)
            }
            
            guard let pokemonData = dTaskData else {return}
            
            do {
                if let topLevelDict = try JSONSerialization.jsonObject(with: pokemonData, options: .allowFragments) as? [String:Any]
                {
                    let pokemon = Pokemon(dictionary: topLevelDict)
                    completion(pokemon)
                }
            } catch {
                print("Encountered error when decoding the data:", error.localizedDescription)
                completion(nil)
            }
        }.resume()
    }
    
    
    static func fetchImage(for pokemon: Pokemon, completetion: @escaping (UIImage?) -> Void) {
        guard let imageURL = URL(string: pokemon.spritePath) else {return}
        
        URLSession.shared.dataTask(with: imageURL) { data, _, error in
            if let error = error {
                print("There was an error", error.localizedDescription)
                completetion(nil)
            }
            guard let data = data else {
                return
            }
            let pokemonImage = UIImage(data: data)
            completetion(pokemonImage)
        }.resume()
    }
}// end
