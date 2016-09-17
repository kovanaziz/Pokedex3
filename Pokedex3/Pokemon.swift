//
//  Pokemon.swift
//  Pokedex3
//
//  Created by Kovan Azeez on 9/16/16.
//  Copyright © 2016 Kovan Azeez. All rights reserved.
//

import Foundation

class Pokemon {
    
    fileprivate var _name : String!
    fileprivate var _pokedexID : Int!
    private var _description: String!
    private var _type: String!
    private var _defense: String!
    private var _height: String!
    private var _weight: String!
    private var _attack: String!
    private var _nextEvolutionTxt: String!
    
    
    
    var name : String {
        return _name
    }
    
    var pokedexID : Int {
        return _pokedexID
    }
    
    
    init (name : String, pokedexID : Int) {
        self._name = name
        self._pokedexID = pokedexID
    }
    
}
