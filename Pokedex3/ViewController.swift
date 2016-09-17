//
//  ViewController.swift
//  Pokedex3
//
//  Created by Kovan Azeez on 9/16/16.
//  Copyright © 2016 Kovan Azeez. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout, UISearchBarDelegate{

    @IBOutlet weak var collection: UICollectionView!
    @IBOutlet weak var SearchBar: UISearchBar!
    
    
    var pokemon = [Pokemon]()
    var musicplayer : AVAudioPlayer!
    var filteredPokemon = [Pokemon]()
    var inSearchMode = false

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collection.delegate = self
        collection.dataSource = self
        SearchBar.delegate = self

        
        SearchBar.returnKeyType = UIReturnKeyType.done
        
        parsePokemonCSV()
       // initAudio()

    }
    
    func initAudio () {
        let audioPath = Bundle.main.path(forResource: "music", ofType: "mp3")
        do {
            musicplayer = try AVAudioPlayer(contentsOf: URL(string:audioPath!)!)
            musicplayer.prepareToPlay()
            musicplayer.numberOfLoops = -1
            musicplayer.play()
            
        }catch let err as NSError {
            print(err.debugDescription)
        }
        
    }
    
    
    func parsePokemonCSV() {
        let path = Bundle.main.path(forResource: "pokemon", ofType: "csv")
        
        do {
            let csv = try CSV(contentsOfURL: path!)
            let rows = csv.rows
            for obj in rows {

                let pokemon = Pokemon(name: obj["identifier"]!, pokedexID: Int(obj["id"]!)!)
                self.pokemon.append(pokemon)
            }
            
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokeCell", for: indexPath) as? PokeCell {
            let poke : Pokemon!
            if inSearchMode {
                poke = filteredPokemon[indexPath.row]
                cell.configureCell(poke)
            } else {
                poke = pokemon[indexPath.row]
                cell.configureCell(poke)
            }
           
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
        var poke : Pokemon!
        if inSearchMode{
            poke = filteredPokemon[indexPath.row]
        } else {
            poke = pokemon[indexPath.row]
        }
        
        performSegue(withIdentifier: "PokemonDetailVC", sender: poke)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PokemonDetailVC" {
            if let detailVC = segue.destination as? PokemonDetailVC {
                if let poke = sender as? Pokemon {
                    detailVC.pokemon = poke
                }
            }
        }
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if inSearchMode {
        return filteredPokemon.count
        } else {
            return pokemon.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 105, height: 105)
    }
    
    @IBAction func musicBtnPressed(_ sender: UIButton) {
        if musicplayer.isPlaying{
            musicplayer.stop()
            sender.alpha = 0.4
        }else {
            musicplayer.play()
            sender.alpha = 1
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true) // remove keyboard after searching
    }
    
    

    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if SearchBar.text == nil || SearchBar.text == "" {
            inSearchMode = false
            collection.reloadData()
            view.endEditing(true)
            
        }else {
            inSearchMode = true
            let lower = searchBar.text?.lowercased()
            filteredPokemon = pokemon.filter({$0.name.range(of: lower!) != nil})
            collection.reloadData()
        }
    }
    
}

