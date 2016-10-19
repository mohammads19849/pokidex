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
