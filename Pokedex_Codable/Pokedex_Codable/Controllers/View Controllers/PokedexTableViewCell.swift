//
//  PokedexTableViewCell.swift
//  Pokedex_Codable
//
//  Created by Arian Mohajer on 2/8/22.
//

import UIKit

class PokedexTableViewCell: UITableViewCell {

    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var pokemonNameLabel: UILabel!
    @IBOutlet weak var pokemonIDLabel: UILabel!
    
    func updateViews(pokemonURLString: String) {
        NetworkingController.fetchPokemon(with: pokemonURLString) { result in
            switch result {
                
            case .success(let pokemon):
                DispatchQueue.main.async {
                    self.updateImage(pokemon: pokemon)
                }
            case .failure(let error):
                print(error.errorDescription!)
            }
        }
    }
    
    func updateImage(pokemon: Pokemon) {
        NetworkingController.fetchPokemonImage(with: pokemon.spritePath.frontShiny) { result in
            switch result {
                
            case .success(let pokemonImage):
                DispatchQueue.main.async {
                    self.pokemonImage.image = pokemonImage
                    self.pokemonNameLabel.text = pokemon.name
                    self.pokemonIDLabel.text = "\(pokemon.id)"
                }
            case .failure(let error):
                print(error.errorDescription!)
            }
        }
    }
}
