//
//  PokedexTableViewController.swift
//  Pokedex_Codable
//
//  Created by Arian Mohajer on 2/8/22.
//

import UIKit

class PokedexTableViewController: UITableViewController {
    
    var pokedexResults: [PokedexResult] = []
    var pokedex: Pokedex?
    
    var baseURL = "https://pokeapi.co/api/v2/pokemon/"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NetworkingController.fetchPokedex(pokedexURLString: baseURL) { result in
            switch result {
            case .success(let pokedex):
                self.pokedex = pokedex
                self.pokedexResults = pokedex.results
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print("There was an error, \(error.errorDescription!)")
            }
        }
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return pokedexResults.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "pokedexCell", for: indexPath) as? PokedexTableViewCell else { return UITableViewCell() }
        
        // Configure the cell...
        cell.updateViews(pokemonURLString: pokedexResults[indexPath.row].url)
        
        return cell
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if indexPath.row == pokedexResults.count-1 {
            
            guard let pokedex = pokedex else {
                return
            }

            NetworkingController.fetchPokedex(pokedexURLString: pokedex.next) { result in
                switch result {
                    
                case .success(let pokedex):
                    self.pokedex = pokedex
                    self.pokedexResults.append(contentsOf: pokedex.results)
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                case .failure(let error):
                    print(error.errorDescription!)
                }
            }
        }
    }
}


