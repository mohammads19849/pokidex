//
//  Pokemon.swift
//  86_pokedex
//
//  Created by 09107110225 on 7/28/1395 AP.
//  Copyright © 1395 Mohammad_salimi. All rights reserved.
//

import Foundation
import Alamofire
 


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
    private var _nextEvoloutionId : String!
    private var _nextEvoloutionLvl : String!
    private var _pokemonURL: String!
    
    var nextEvoloutionLVL : String{
        get{
            if _nextEvoloutionLvl == nil{
                return ""
            }else{
                return _nextEvoloutionLvl
            }
        }
    }
    
    var nextEvoloutionId : String{
        get{
            if _nextEvoloutionId == nil{
                return ""
            }else{
                return _nextEvoloutionId
            }
        }
        
    }
    
    var nextEvoloutionTXT : String{
        get{
            if _nextEvoloutionText == nil{
                return ""
            }else{
                return _nextEvoloutionText
            }
        }
    }
    
    var attack : String{
        get{
            if _attack == nil{
                return ""
            }else{
                return _attack
            }
        }
    }
    
    
    var weight : String{
        get{
            if _weight == nil{
                return ""
            }else{
                return _weight
            }
        }
    }
    
    var height : String{
        get{
            if _height == nil{
                return ""
            }else{
                return _height
            }
        }
    }
    
    var defence : String{
        get{
            if _defence == nil{
                return ""
            }else{
                return _defence
            }
        }
    }
    
    
    var description : String{
        get{
            if _description == nil{
                return ""
            }else{
                return _description
            }
        }
    }
    
    var type : String{
        get{
            if _type == nil{
                return ""
            }else{
                return _type
            }
        }
    }
    
    
    
    var name : String{
        get{
            if _name == nil{
                return ""
            }else{
                return _name
            }
        }
    }
    
    var pokedexId : Int{
        get{
            if _pokedexId == nil{
                return -1
            }else{
                return _pokedexId
            }
        }
    }
    
    init(name : String, pokedexId : Int) {
        self._name = name
        self._pokedexId = pokedexId
        
        _pokemonURL = "\(URL_BASE)\(URL_POKEMON)\(self._pokedexId!)/"
    }
    
    
    
    
    func downloadPokemonDetails(completed: @escaping DownloadComplete){
        
        
        let url = URL(string: _pokemonURL)!
        
        
        Alamofire.request(url).responseJSON { response in
            
            //print(response.result.value)
            
            if let dict = response.result.value as? Dictionary<String, AnyObject>{
                
                if let weight = dict["weight"] as? String{
                    self._weight = weight
                }
                
                if let height = dict["height"] as? String{
                    self._height = height
                }
                
                if let attack = dict["attack"] as? Int{
                    self._attack = "\(attack)"
                }
                
                if let defense = dict["defense"] as? Int{
                    self._defence = "\(defense)"
                }
                
                if let types = dict["types"] as? [Dictionary<String, String>] {
                    
                    if let name = types[0]["name"]{
                        self._type = name.capitalized
                    }
                    
                    if types.count > 1{
                        
                        for x in 1..<types.count{
                            if let name = types[x]["name"]{
                                self._type! += "/\(name.capitalized)"
                            }
                        }
                        
                    }
                    
                }else{
                    self._type = ""
                }
                
                print(self._type)
                
                if let descArr = dict["descriptions"]as? [Dictionary<String, String>]{
                    if descArr.count > 0{
                        if let desURL = descArr[0]["resource_uri"] {
                            let urldes = URL(string: "\(URL_BASE)\(desURL)")
                            Alamofire.request(urldes!).responseJSON(completionHandler: { response in
                                if let descDict = response.result.value as? Dictionary<String, AnyObject>{
                                    
                                    if let description = descDict["description"] as? String {
                                        self._description = description
                                    }
                                }
                                
                                completed()
                                
                            })
                        }
                        
                    }
                    
                }else{
                    self._description = ""
                }
                
                if let evolutions = dict["evolutions"] as? [Dictionary<String, AnyObject>]{
                    if evolutions.count > 0{
                        if let to = evolutions[0]["to"] as? String{
                            
                            if to.range(of: "mega") == nil{
                                if let uri = evolutions[0]["resource_uri"] as? String{
                                    let newStr = uri.replacingOccurrences(of: "/api/v1/pokemon/", with: "")
                                    let num = newStr.replacingOccurrences(of: "/", with: "")
                                    self._nextEvoloutionId = num
                                    self._nextEvoloutionText = to
                                    
                                    if let lvl = evolutions[0]["level"] as? Int{
                                        self._nextEvoloutionLvl = "\(lvl)"
                                    }
                                    
                                    
                                    
                                    
                                }
                            }
                        }
                    }
                }
                
                
                
            }
            
//            print(self._weight)
//            print(self._height)
//            print(self._attack)
//            print(self._defence)

            
            
        }
        
    }
    
    
}
