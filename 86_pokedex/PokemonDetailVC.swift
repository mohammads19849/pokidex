//
//  PokemonDetailVC.swift
//  86_pokedex
//
//  Created by 09107110225 on 7/29/1395 AP.
//  Copyright © 1395 Mohammad_salimi. All rights reserved.
//

import UIKit

class PokemonDetailVC: UIViewController {
    
    var pokemon: Pokemon!
    @IBOutlet var nameLbl: UILabel!
    @IBOutlet var mainImg: UIImageView!
    @IBOutlet var descriptionLbl: UILabel!
    @IBOutlet var typeLbl: UILabel!
    @IBOutlet var defenceLbl: UILabel!
    @IBOutlet var heightLbl: UILabel!
    @IBOutlet var pokedexIdLbl: UILabel!
    @IBOutlet var weightLbl: UILabel!
    @IBOutlet var baseAttkLbl: UILabel!
    @IBOutlet var currentEvolImg: UIImageView!
    @IBOutlet var nextEvolImg: UIImageView!
    @IBOutlet var evolLbl: UILabel!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nameLbl.text = pokemon.name
        
        let img = UIImage(named: "\(pokemon.pokedexId)")
        mainImg.image = img
        currentEvolImg.image = img
        
        
        
        

        
        
        pokemon.downloadPokemonDetails { 
            //this will be call after download is done
            self.updateUI()
            
        }
        
        
    }

    func updateUI(){
        descriptionLbl.text = pokemon.description
        typeLbl.text = pokemon.type
        defenceLbl.text = pokemon.defence
        heightLbl.text = pokemon.height
        pokedexIdLbl.text = "\(pokemon.pokedexId)"
        weightLbl.text = pokemon.weight
        baseAttkLbl.text = pokemon.attack
        
        
        if  pokemon.nextEvoloutionId == ""{
            evolLbl.text = "No Evolution"
            nextEvolImg.isHidden = true
        }else{
            nextEvolImg.isHidden = false
            nextEvolImg.image = UIImage(named: pokemon.nextEvoloutionId)
            var str = "Next Evolution: \(pokemon.nextEvoloutionTXT)"
            if pokemon.nextEvoloutionLVL != ""{
                str += " -LVL \(pokemon.nextEvoloutionLVL)"
            }
            print("###\(pokemon.nextEvoloutionLVL)")
            
            evolLbl.text = str
        }
        
        
        
        
        
        
    }

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func backBtnPressed(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
    
    

  

}
