//
//  PokemonViewController.swift
//  Pokedex_Codable
//
//  Created by Karl Pfister on 2/7/22.
//

import UIKit

class PokemonViewController: UIViewController {

    @IBOutlet weak var pokemonSearchBar: UISearchBar!
    @IBOutlet weak var pokemonIDLabel: UILabel!
    @IBOutlet weak var pokemonNameLabel: UILabel!
    @IBOutlet weak var pokemonSpriteImageView: UIImageView!
    @IBOutlet weak var pokemonMovesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        pokemonMovesTableView.delegate = self
//        pokemonMovesTableView.dataSource = self
//        pokemonSearchBar.delegate = self
    }
    
//    var pokemon: Pokemon?
//
//    func updateViews(for pokemon: Pokemon) {
//        NetworkingController.fetchImage(for: pokemon) { image in
//            guard let image = image else {return}
//            DispatchQueue.main.async {
//                self.pokemon = pokemon
//                self.pokemonSpriteImageView.image = image
//                self.pokemonIDLabel.text = ("No:\(pokemon.id)")
//                self.pokemonNameLabel.text = pokemon.name.capitalized
//                self.pokemonMovesTableView.reloadData()
//            }
//        }
//    }
    
}// End


//extension PokemonViewController: UITableViewDelegate, UITableViewDataSource {
//
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return "Moves"
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return pokemon?.moves.count ?? 0
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//        let cell = tableView.dequeueReusableCell(withIdentifier: "moveCell", for: indexPath)
//        guard let pokemon = pokemon else {return UITableViewCell() }
//        let move = pokemon.moves[indexPath.row]
//        cell.textLabel?.text = move
//        return cell
//    }
//}
//
//extension PokemonViewController: UISearchBarDelegate {
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        NetworkingController.fetchPokemon(with: searchText) { pokemon in
//            guard let pokemon = pokemon else {
//                return
//            }
//            self.updateViews(for: pokemon)
//        }
//    }
//}
