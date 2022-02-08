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
        guard let pokemon = pokemon else {return}
        NetworkingController.fetchImage(for: pokemon.sprites.frontShiny) { result in
            switch result {
            case .success(let image):
                DispatchQueue.main.async {
                    self.pokemonSpriteImageView.image = image
                    self.pokemonNameLabel.text = pokemon.name.capitalized
                    self.pokemonIDLabel.text = "No: \(pokemon.id)"
                    self.pokemonMovesTableView.reloadData()
                }
            case .failure(let error):
                print("There was an error!", error.errorDescription!)
            }
        }
    }
}// End


extension PokemonViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Moves"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemon?.moves.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "moveCell", for: indexPath)
        guard let pokemon = pokemon else {return UITableViewCell() }
        let move = pokemon.moves[indexPath.row].move.name
        cell.textLabel?.text = move
        return cell
    }
}


