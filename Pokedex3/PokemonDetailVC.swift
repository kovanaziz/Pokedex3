//
//  PokemonDetailVC.swift
//  Pokedex3
//
//  Created by Kovan Azeez on 9/17/16.
//  Copyright © 2016 Kovan Azeez. All rights reserved.
//

import UIKit

class PokemonDetailVC: UIViewController {

    var pokemon : Pokemon!
    @IBOutlet weak var nameLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLbl.text = pokemon.name

    }


}
