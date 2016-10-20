//
//  ViewController.swift
//  86_pokedex
//
//  Created by 09107110225 on 7/28/1395 AP.
//  Copyright © 1395 Mohammad_salimi. All rights reserved.
//

import UIKit
import AVFoundation


class ViewController: UIViewController ,UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
    
    
    //MARK: Property
    
    @IBOutlet weak var collection : UICollectionView!
   
    @IBOutlet var searchBar: UISearchBar!
    
    var pokemon = [Pokemon]()
    var filteredPokimone = [Pokemon]()
    var musicPlayer : AVAudioPlayer!
    var inSearchMode = false
    
    
    @IBAction func musicBtnPressed(_ sender: UIButton!) {
        if musicPlayer.isPlaying{
            musicPlayer.stop()
            sender.alpha = 0.2
        }else{
            musicPlayer.play()
            sender.alpha = 1
        }
    }
    
    
    //MARK: functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //collection = UICollectionView()
        collection.delegate = self
        collection.dataSource = self
        searchBar.delegate = self
        searchBar.returnKeyType = .done
        
        initAudio()
        parsePokemonCSV()
        
        
    }
    
    func initAudio(){
        let path = Bundle.main.path(forResource: "music", ofType: "mp3")!
 
        do{
            musicPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            musicPlayer.prepareToPlay()
            musicPlayer.numberOfLoops = -1
            musicPlayer.play()
        }catch let err as NSError{
            print(err.debugDescription)
        }
        
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
    
    //MARK: Collection Function

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokeCell", for: indexPath) as? PokeCell{
            
            //let pokemon = Pokemon(name: "Test", pokedexId: indexPath.row+1)
            
            let poke : Pokemon!
            
            if inSearchMode{
                poke = filteredPokimone[indexPath.row]
            }else{
                poke = pokemon[indexPath.row]
            }
            
            cell.configureCell(pokemon: poke)
            
            
            return cell
        }else{
            return UICollectionViewCell()
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let poke : Pokemon!
        
        if inSearchMode{
            poke = filteredPokimone[indexPath.row]
        }else{
            poke = pokemon[indexPath.row]
        }
        
        performSegue(withIdentifier: "PokemonDetailVC", sender: poke)
        
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if inSearchMode {
            return filteredPokimone.count
        }
        
        return 718
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        return CGSize(width: 105, height: 105)
        
    }

    
    //MARK: SearchBar Funcs
    
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchBar.text == nil || searchBar.text == ""{
            inSearchMode = false
            view.endEditing(true)
            collection.reloadData()
            
        }else{
            inSearchMode = true
            let lower = searchBar.text!.lowercased()
            filteredPokimone = pokemon.filter({$0.name.range(of: lower) != nil})
            collection.reloadData()
            
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "PokemonDetailVC"{
            if let detailVC = segue.destination as? PokemonDetailVC{
                if let poke = sender as? Pokemon{
                    detailVC.pokemon = poke
                    
                }
            }
        }
        
    }
}

