//
//  SWAPIResponse.swift
//  StarWars
//
//  Created by Nicolas on 13/10/2020.
//

import Foundation

struct SWAPIResponse<Data: Codable> {
    let results: Data
}

extension SWAPIResponse: Codable {}
