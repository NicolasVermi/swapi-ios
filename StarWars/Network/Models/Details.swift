//
//  Details.swift
//  StarWars
//
//  Created by Nicolas on 14/10/2020.
//

import Foundation

struct Details {
    let name: String
    let height: String
    let mass: String
    let hairColor: String
    let skinColor: String
    let eyeColor: String
    let birthYear: String
    let gender: String
    let homeworld: String
//    let species: String
    //let vehicles:[String]
    //let starShips:[String]
    
}
extension Details: Codable {
    
}

extension Details: Identifiable {
    var id: String { "\(name)" }
}
