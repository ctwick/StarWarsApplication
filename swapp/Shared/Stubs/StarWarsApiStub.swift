//
//  StarWarApiStub.swift
//  swapp
//
//  Created by Chamini Wickramanayake on 2022-07-05.
//

import Foundation

class StarWarsApiStub {
    
    private func getBaseApiPath() -> String {
        return "https://swapi.dev/api/"
    }
    
    func getPlanetApiPathForPage(pageNumber: Int = 1) -> String {
        
        //return "\(getBaseApiPath())planets/1"
        return "\(getBaseApiPath())planets/?page=\(pageNumber)"
    }
    
}
