//
//  PokemonViewController.swift
//  Pokedex_Codable
//
//  Created by Karl Pfister on 2/7/22.
//

import UIKit

class PokemonViewController: UIViewController {

    @IBOutlet weak var pokemonIDLabel: UILabel!
    @IBOutlet weak var pokemonNameLabel: UILabel!
    @IBOutlet weak var pokemonSpriteImageView: UIImageView!
    @IBOutlet weak var pokemonMovesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pokemonMovesTableView.delegate = self
        pokemonMovesTableView.dataSource = self
    }
    
    var pokemon: Pokemon? {
        didSet {
            updateViews()
        }
    }

    func updateViews() {
        
        guard let pokemon = pokemon else { return }
        
        NetworkingController.fetchPokemonImage(with: pokemon.spritePath.frontShiny) { result in
            switch result {
                
            case .success(let pokemonImage):
                DispatchQueue.main.async {
                    self.pokemonSpriteImageView.image = pokemonImage
                    self.pokemonIDLabel.text = ("No:\(pokemon.id)")
                    self.pokemonNameLabel.text = pokemon.name.capitalized
                    self.pokemonMovesTableView.reloadData()
                }
            case .failure(let error):
                print(error.errorDescription!)
            }
        }
    }
    
}// End


extension PokemonViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Abilities"
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let pokemon = pokemon else { return 0 }
        return pokemon.abilities.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "moveCell", for: indexPath)
        guard let pokemon = pokemon else {return UITableViewCell() }
        let move = pokemon.abilities[indexPath.row]
        cell.textLabel?.text = move.ability.name
        return cell
    }
}
