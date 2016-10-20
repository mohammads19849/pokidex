//
//  ViewController.swift
//  86_pokedex
//
//  Created by 09107110225 on 7/28/1395 AP.
//  Copyright © 1395 Mohammad_salimi. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collection : UICollectionView!
   
    var pokemon = [Pokemon]()

    override func viewDidLoad() {
        super.viewDidLoad()
        //collection = UICollectionView()
        collection.delegate = self
        collection.dataSource = self
        
        
        parsePokemonCSV()
        
        
    }
    
    
    func parsePokemonCSV(){
        let path  = Bundle.main.path(forResource: "pokemon", ofType: "csv")!
        
        do{
            let csv = try CSV(contentsOfURL: path)
            let rows = csv.rows
            //print(rows)
            
            for row in rows{
                let pokeID = Int(row["id"]!)!
                let name = row["identifier"]!
                let poke = Pokemon(name: name, pokedexId: pokeID)
                pokemon.append(poke)
                
            }
            
        }catch let err as NSError {
            print(err.debugDescription)
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokeCell", for: indexPath) as? PokeCell{
            
            //let pokemon = Pokemon(name: "Test", pokedexId: indexPath.row+1)
            
            let poke = pokemon[indexPath.row]
            
            cell.configureCell(pokemon: poke)
            
            
            return cell
        }else{
            return UICollectionViewCell()
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 718
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        return CGSize(width: 105, height: 105)
        
    }


}

