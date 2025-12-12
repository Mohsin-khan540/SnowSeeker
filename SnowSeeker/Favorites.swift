//
//  Favorites.swift
//  SnowSeeker
//
//  Created by Mohsin khan on 11/12/2025.
//

import SwiftUI

@Observable

class Favorites {
    private var resorts : Set<String>
    
    private let key = "Favorites"
    
    init() {
     resorts = []
        load()
    }
    
    func contains(_ resort : Resort)->Bool{
       resorts.contains(resort.id)
    }
    
    func add(_ resort : Resort){
        resorts.insert(resort.id)
        save()
    }
    
    func remove(_ resort : Resort){
        resorts.remove(resort.id)
        save()
    }
    
    func save(){
        if let encode = try? JSONEncoder().encode(resorts){
            UserDefaults.standard.set(encode, forKey: key)
        }
    }
    func load(){
        if let data = UserDefaults.standard.data(forKey: key){
            if let decode = try? JSONDecoder().decode(Set<String>.self, from: data){
                self.resorts = decode
            }
        }
    }
    
}
