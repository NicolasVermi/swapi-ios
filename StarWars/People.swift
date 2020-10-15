//
//  People.swift
//  StarWars
//
//  Created by Nicolas on 13/10/2020.
//
import Foundation

struct People {
    let name: String
    let gender: String
    let films: [String]
}
extension People: Codable {
    
}
