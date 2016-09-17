//
//  ViewController.swift
//  Pokedex3
//
//  Created by Kovan Azeez on 9/16/16.
//  Copyright © 2016 Kovan Azeez. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{

    @IBOutlet weak var collection: UICollectionView!
    
    var pokemon = [Pokemon]()
    var musicplayer : AVAudioPlayer!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collection.delegate = self
        collection.dataSource = self
        parsePokemonCSV()
        initAudio()

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
            let poke = pokemon[indexPath.row]
            cell.configureCell(poke)
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // next step for selction of the cell
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pokemon.count
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
    
}

