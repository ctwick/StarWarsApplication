//
//  Planet.swift
//  swapp
//
//  Created by Chamini Wickramanayake on 2022-07-05.
//

import Foundation

struct Planets: Decodable {
    let count: Int
    var all: [Planet]
    let next: String?
    let previous: String?
    
    enum CodingKeys: String, CodingKey {
        case count
        case all = "results"
        case next
        case previous
    }
}

struct Planet: Decodable, Identifiable {
    let id = UUID()
    let name: String
    let climate: String
    let orbitalPeriod: String
    let gravity: String
    let diameter: String
    let population: String
    let rotationPeriod: String
    let surfaceWater: String
    let terrain: String
    let films: Array<String>
    let residents: Array<String>
    let url: String
    let created: String
    let edited: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case climate
        case orbitalPeriod = "orbital_period"
        case gravity
        case diameter
        case population
        case rotationPeriod = "rotation_period"
        case surfaceWater = "surface_water"
        case terrain
        case films
        case residents
        case url
        case created
        case edited
    }
}



