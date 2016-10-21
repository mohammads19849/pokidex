//
//  Pokemon.swift
//  86_pokedex
//
//  Created by 09107110225 on 7/28/1395 AP.
//  Copyright © 1395 Mohammad_salimi. All rights reserved.
//

import Foundation


class Pokemon{
    private var _name : String!
    private var _pokedexId : Int!
    private var _description : String!
    private var _type : String!
    private var _defence : String!
    private var _height : String!
    private var _weight : String!
    private var _attack : String!
    private var _nextEvoloutionText : String!
    
    
    var name : String{
        return _name
    }
    
    var pokedexId : Int{
        return _pokedexId
    }
    
    init(name : String, pokedexId : Int) {
        self._name = name
        self._pokedexId = pokedexId
    }
    
    
}
